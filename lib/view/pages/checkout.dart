import 'package:ecomerce/models/client/shared_preference.dart';
import 'package:ecomerce/models/dataClass/cart_model.dart';
import 'package:ecomerce/models/dataClass/reponse_model.dart';
import 'package:ecomerce/models/service/order_service.dart';
import 'package:ecomerce/utils/theme_data.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartModel> cartItem;
  CheckoutPage(this.cartItem,{Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController firstNameController= TextEditingController(),phoneController= TextEditingController(),addressController = TextEditingController(),emailController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double total = 0;
    int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: loading?Center(
        child: CircularProgressIndicator(),
      ):Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
              child: ListView(
                children: [
                  Card(
                    elevation:0,
                    child: Column(
                      children: [
                        Container(
                          padding:EdgeInsets.only(top: 10,left: 10,bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text("DELIVERY METHOD",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 0,
                                groupValue: 0,
                                onChanged: (index){

                                }
                            ),
                            Text("CASH ON DELIVERY",)
                          ],
                        )
                      ],
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Card(
                      elevation: 0,
                      child: Column(
                        children: [
                          Container(
                            padding:EdgeInsets.only(top: 10,left: 10,bottom: 5),
                            alignment: Alignment.centerLeft,
                            child: Text("DELIVERY ADDRESS",style: const TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          const Divider(
                            height: 2,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: TextFormField(
                              showCursor: true,
                              validator: (str){
                                if(str!.isEmpty){
                                  return "required";
                                }else{
                                  return null;
                                }
                              },
                              controller: firstNameController,

                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Full Name",
                                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5)
                              ),
                            ),
                          ),
                          const Divider(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: TextFormField(
                              showCursor: true,
                              validator: (str){
                                if(str!.isEmpty){
                                  return "required";
                                }else{
                                  return null;
                                }
                              },
                              controller: phoneController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                hintText: "Phone",
                              ),
                            ),
                          ),
                          const Divider(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: TextFormField(
                              showCursor: true,
                              validator: (str){
                                if(str!.isEmpty){
                                  return "required";
                                }else{
                                  return null;
                                }
                              },
                              controller: emailController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                hintText: "Email",
                              ),
                            ),
                          ),
                          const Divider(
                            height: 5,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            child: TextFormField(
                              showCursor: true,
                              validator: (str){
                                if(str!.isEmpty){
                                  return "required";
                                }else{
                                  return null;
                                }
                              },
                              controller: addressController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                hintText: "Shipping Address",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding:EdgeInsets.only(top: 10,left: 10,bottom: 5),
                    child: Text("ORDER ITEMS",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  Card(
                    elevation: 0,
                    child: Column(
                      children: widget.cartItem.map((e){
                        i++;
                        total+=e.total;
                        return Container(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text("$i. ${e.product.title}")),
                              SizedBox(
                                width: 120,
                                child: Text("${e.quantity} X ${e.product.price.toStringAsFixed(2)} = ",textAlign: TextAlign.end,),
                              ),
                              SizedBox(
                                  width:100,
                                  child: Text("৳ ${ e.total.toStringAsFixed(2)}",textAlign: TextAlign.end,)
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 10),
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width:250,
                          padding: EdgeInsets.only(top: 5,bottom: 5,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("SUB TOTAL "),
                              Text("৳ $total"),
                            ],
                          ),
                        ),
                        Container(
                          width:250,
                          padding: EdgeInsets.only(top: 0,bottom: 0,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("DELIVERY CHARGE"),
                              Text("৳ 0"),
                            ],
                          ),
                        ),
                        Divider(

                        ),
                        Container(
                          width:250,
                          padding: EdgeInsets.only(top: 0,bottom: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("TOTAL",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("৳ $total",style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        )
                      ]
                    ),
                  ),

                ],
              )
          ),
          ElevatedButton.icon(
            onPressed: (){
              if(formKey.currentState!.validate()){
                  orderNow(context,total);
              }
            },
            icon: const Icon(Icons.done_outline_outlined),
            label: const Text("Confirm Order"),
            style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(top: 10,bottom: 10)),
                shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder())
            ),
          )
        ],
      ),
    );
  }

  orderNow(context,double total) async{
    var formData ={
    "name":firstNameController.text,
    "email":emailController.text,
    "phone_no":phoneController.text,
    "shipping_address":addressController.text,
    "amount":total,
    "message":"",
      "user_id": user!.id
    };
    setState(() {
      loading = true;
    });
    ResponseModel responseModel = await OrderService.createOrder(formData);
    setState(() {
      loading = false;
    });
    if(responseModel.statusCode==200){
      showDialog(
          context: context,
          builder: (ctx){
            return AlertDialog(
              content: const Text("Order has been submitted"),
              actions: [
                TextButton(
                    onPressed: (){
                      SharedPrefManager.clearCart();
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text("Ok")
                )
              ],
            );
          }
      );
    }
  }
}
