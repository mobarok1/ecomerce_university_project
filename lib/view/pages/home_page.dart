
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
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
    categories = await ProductCategoryService.getAllCategories(context);
    products = await ProductCategoryService.getAllProducts(context);
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
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          actions: [
            IconButton(
                onPressed: (){
                  if(!logged) {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const LoginPage()));
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const ProfilePage()));
                  }
                },
                icon: const Icon(Icons.person)
            )
          ],
        ),
        body:loading?
        const Center(child: CircularProgressIndicator(),) :
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
                child: Container(
                  color: const Color(0xFFf5f6f7),
                ),
              ),
              // Row(
              //   children: [
              //     Flexible(
              //       child: Container(
              //         margin: const EdgeInsets.only(left: 15,right: 0),
              //         child:  TextField(
              //           decoration: InputDecoration(
              //               hintText: "Search Products",
              //               prefixIcon: const Icon(Icons.search,),
              //               fillColor: Colors.grey.withOpacity(.05),
              //               contentPadding: const EdgeInsets.only(top: 5,bottom: 5),
              //               filled: true,
              //               border: const OutlineInputBorder(
              //                   borderRadius: BorderRadius.all(Radius.circular(15))
              //               )
              //           ),
              //         ),
              //       ),
              //     ),
              //     ElevatedButton(
              //         onPressed: (){},
              //         child: Text("Search")
              //     )
              //   ],
              // ),
              //
              // SizedBox(
              //   height: 10,
              //   child: Container(
              //     color: const Color(0xFFf5f6f7),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: mainColor.withOpacity(.1),
                            width: 2
                        )
                    )
                ),
                child: Row(
                  children: [
                    Expanded(
                      child:  Text(
                        "Category",
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: mainColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
                          ),
                          onPressed: (){

                          },
                          child: const Text("View All")
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 75,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: categories.map((e) =>
                      Card(
                        margin: const EdgeInsets.only(right: 5),
                        color: mainColor.withOpacity(.2),
                        child:Container(
                          width: 100,
                          alignment: Alignment.center,
                          child: Text(
                            e.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black.withOpacity(.7),
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ) ,
                      )).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5,top: 10),
                padding: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: mainColor.withOpacity(.1),
                            width: 2
                        )
                    )
                ),
                child: Row(
                  children: [
                    Expanded(
                      child:  Text(
                        "Products",
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: mainColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
                          ),
                          onPressed: (){

                          },
                          child: const Text("View All")
                      ),
                    )
                  ],
                ),
              ),
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
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) async{
            if(index==1){
              await Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const FavouriteItemPage()));
              for(var pro in products){
                pro.favourite = await SharedPrefManager.alreadyExistFavoriteItems(pro);
              }
              setState(() {

              });
            }else if(index==2){
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const CartListPage()));
            }
          },
          showUnselectedLabels: false,

          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home"

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favorite"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Cart"
            )
          ],
        ),
      ),
    );
  }
}
