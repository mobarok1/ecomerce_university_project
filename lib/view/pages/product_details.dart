import 'dart:convert';

import 'package:ecomerce/models/client/api_client.dart';
import 'package:ecomerce/models/client/shared_preference.dart';
import 'package:ecomerce/models/dataClass/cart_model.dart';
import 'package:ecomerce/models/dataClass/product_model.dart';
import 'package:ecomerce/utils/theme_data.dart';
import 'package:ecomerce/view/pages/cart_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails(this.product, {Key? key}) : super(key: key);
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetails> {
  bool inCart = false;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    checkCart();

  }
  void checkCart() async{
    inCart = await SharedPrefManager.alreadyExist(widget.product);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafa),
      appBar: AppBar(
        title: Text("Product Details"),
        actions: [
          IconButton(
              onPressed: () async{
                await Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const CartListPage()));
                checkCart();
              },
              icon: const Icon(Icons.shopping_cart)
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: SingleChildScrollView(
             child: Column(

                children: <Widget>[
                  /*Image.network(
              widget.productDetails.data.productVariants[0].productImages[0]),*/
                  Image.network( baseUrlIMage+widget.product.image1,fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                    color: Color(0xFFFFFFFF),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Price".toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF565656))),
                        Text(
                            "৳ ${widget.product.price.toStringAsFixed(2)}"
                                .toUpperCase(),
                            style: TextStyle(
                                color: mainColor,
                                fontFamily: 'Roboto-Light.ttf',
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                    color: const Color(0xFFFFFFFF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text("Description",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF565656))),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                            widget.product.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF4c4c4c))),
                      ],
                    ),
                  ),

                ],
              )
          )),
          Row(
            children: [
              Expanded(
                  child:ElevatedButton.icon(
                    onPressed: inCart?null:(){
                        CartModel cartModel = CartModel(subTotal: widget.product.price, total: widget.product.price, quantity: 1, product: widget.product);
                        SharedPrefManager.addToCart(context,cartModel);
                        setState(() {
                          inCart = true;
                        });
                    },
                    icon: Icon(Icons.add_shopping_cart_outlined),
                    label: Text(inCart?"ALREADY IN CART":"ADD TO CART"),
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.only(top: 10,bottom: 10)),
                      shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder())
                    ),
              ) )
            ],
          )
        ],
      ),
    );
  }
}
