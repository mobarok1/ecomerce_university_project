import 'package:ecomerce/models/client/api_client.dart';
import 'package:ecomerce/models/client/shared_preference.dart';
import 'package:ecomerce/models/dataClass/cart_model.dart';
import 'package:ecomerce/utils/theme_data.dart';
import 'package:ecomerce/view/pages/checkout.dart';
import 'package:ecomerce/view/pages/login_page.dart';
import 'package:flutter/material.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({Key? key}) : super(key: key);

  @override
  State<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  List<CartModel> items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDataFromCart();
  }
  loadDataFromCart() async{
    items = await SharedPrefManager.getCartItems();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    int total = 0;
    for (var element in items) {
      total+=element.total;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Flexible(
              child: items.isEmpty?Center(
                child: Text("Cart is empty",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(.5)),),
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
                                baseUrlIMage+e.product.image1,
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
                                      margin: EdgeInsets.only(left: 15),
                                      child: Text(e.product.title,
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
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 13),
                                  child: Text("Price : ৳${e.total}",style: TextStyle(fontSize: 15,color: Colors.red[900],fontWeight: FontWeight.bold),),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 115,
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: (){
                                          SharedPrefManager.decrement(e);
                                          loadDataFromCart();
                                        },
                                        icon:  Icon(Icons.indeterminate_check_box_rounded,color: mainColor,),
                                        padding: EdgeInsets.zero,
                                      ),
                                      Center(child: Text(e.quantity.toString())),
                                      IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: (){
                                            SharedPrefManager.increment(e);
                                            loadDataFromCart();
                                          },
                                          icon: Icon(Icons.add_box,color: mainColor,)
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 25,
                              margin: const EdgeInsets.only(right: 10),
                              child: IconButton(
                                  onPressed: (){
                                    SharedPrefManager.removeFromCart(e);
                                    loadDataFromCart();
                                  },
                                  icon: Icon(Icons.delete_forever,color: Colors.red[900],)
                              ),
                            )

                          ],
                        ),
                      ),
                    )
                ).toList(),
              )
          ),
          Container(
            color: Colors.red[900],
            child: Row(
              children: [
                Expanded(
                    child:ElevatedButton.icon(
                      onPressed: (){
                        if(user == null) {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const LoginPage()));
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CheckoutPage(items)));
                        }
                      },
                      icon: const Icon(Icons.payments_outlined),
                      label: const Text("PROCEED TO CHECKOUT"),
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(top: 10,bottom: 10)),
                          shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder())
                      ),
                    ) ),
                Container(
                    padding: const EdgeInsets.only(left: 10,right: 15),
                    width: 100,
                    alignment: Alignment.centerRight,
                    child: Text("৳ $total",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
