
import 'package:ecomerce/models/client/api_client.dart';
import 'package:ecomerce/models/client/shared_preference.dart';
import 'package:ecomerce/models/dataClass/category_model.dart';
import 'package:ecomerce/models/dataClass/product_model.dart';
import 'package:ecomerce/models/service/products_category.dart';
import 'package:ecomerce/utils/theme_data.dart';
import 'package:ecomerce/view/pages/cart_list.dart';
import 'package:ecomerce/view/pages/favourite_list.dart';
import 'package:ecomerce/view/pages/login_page.dart';
import 'package:ecomerce/view/pages/product_details.dart';
import 'package:ecomerce/view/pages/profile_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryPage extends StatefulWidget {
  final CategoryModel catModel;
  const CategoryPage({Key? key, required this.catModel}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CategoryPage> {
  List<Product> products = [];
  bool loading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromServer();
  }

  getDataFromServer() async{
    setState(() {
      loading = true;
    });
    products = await ProductCategoryService.getCategoryProducts(context,widget.catModel.id);
    setState(() {
      loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        appBar: AppBar(
          title:  Text(widget.catModel.name),
        ),
        body:loading?
        const Center(child: CircularProgressIndicator(),) :
            products.isEmpty?
            const Center(
              child: Text("No Product Found"),
            ): Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Flexible(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  children: products.map((e){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ProductDetails(e)));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        margin: const EdgeInsets.only(bottom: 0,top: 10,left: 10,right: 10),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 130,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)
                                      ),
                                      child: Image.network(baseUrlIMage+e.image1)
                                  ),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 5,left: 5,right: 5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      e.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withOpacity(.7),
                                          fontSize: 17
                                      ),
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Price : ৳ ${e.price.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(.6)
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Positioned(
                                right: 0,
                                top: -7,
                                child: IconButton(
                                  onPressed: () async{
                                    SharedPrefManager.addToFavoriteItems(context, e);
                                    e.favourite = !e.favourite;
                                    setState(() {

                                    });
                                  },
                                  icon: Icon(
                                    e.favourite?Icons.favorite:Icons.favorite_border,
                                    color: mainColor,
                                  ),
                                )
                            )
                            // Positioned(
                            //   right: 0,
                            //     child: Container(
                            //       width: 60,
                            //       alignment: Alignment.center,
                            //       padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                            //       decoration: BoxDecoration(
                            //         color: Colors.red[900],
                            //         borderRadius: BorderRadius.only(topRight: Radius.circular(10))
                            //       ),
                            //       child: const Text("Top",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                            //     )
                            // ),
                          ],
                        ),
                      ),
                    );
                  }).toList() ,

                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
