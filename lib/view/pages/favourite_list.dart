import 'package:ecomerce/models/client/api_client.dart';
import 'package:ecomerce/models/client/shared_preference.dart';
import 'package:ecomerce/models/dataClass/cart_model.dart';
import 'package:ecomerce/models/dataClass/product_model.dart';
import 'package:ecomerce/utils/theme_data.dart';
import 'package:ecomerce/view/pages/cart_list.dart';
import 'package:flutter/material.dart';

class FavouriteItemPage extends StatefulWidget {
  const FavouriteItemPage({Key? key}) : super(key: key);

  @override
  State<FavouriteItemPage> createState() => _FavouriteItemPageState();
}

class _FavouriteItemPageState extends State<FavouriteItemPage> {
  List<Product> items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDataFromCart();
  }
  loadDataFromCart() async{
    items = await SharedPrefManager.getFavoriteItems();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Products"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Flexible(
              child: items.isEmpty?Center(
                child: Text("Empty",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(.5)),),
              ): ListView(
                children: items.map((e) =>
                    Card(
                      child: Container(
                        padding: const EdgeInsets.only(left: 5,right: 0,top: 5,bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              child: Image.network(
                                baseUrlIMage+e.image1,
                                width: 75,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 15),
                                      child: Text(e.title,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: mainColor.withOpacity(.9),
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 13),
                                  child: Text("Price : ৳${e.price}",style: TextStyle(fontSize: 15,color: Colors.red[900],fontWeight: FontWeight.bold),),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 25,
                                  child: ElevatedButton.icon(
                                    onPressed: (){
                                      CartModel model = CartModel(subTotal: e.price, total: e.price, quantity: 1, product: e);
                                      SharedPrefManager.removeFromFavoriteItems(e);
                                      SharedPrefManager.addToCart(context,model);
                                      loadDataFromCart();
                                    },
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.resolveWith((states) => 0),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap
                                    ),
                                    icon: const Icon(Icons.add_shopping_cart,size: 12,),
                                    label: const Text("ADD TO CART",style: TextStyle(fontSize: 10),),
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                    )
                ).toList(),
              )
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (int index){
          if(index==2){
            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const CartListPage()));
          }else if(index==0){
            Navigator.pop(context);
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
    );
  }
}
