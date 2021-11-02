import 'package:ecomerce/models/dataClass/order_model.dart';
import 'package:ecomerce/models/service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<OrderModel> orders = [];
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromServer();
  }
  void getDataFromServer() async{
    setState(() {
      loading = true;
    });
    orders =  await OrderService.getOrders(context);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
      ),
      body: loading?Center(
        child: CircularProgressIndicator(

        ),
      ): ListView(
            children: orders.map((e) =>
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black26
                          )
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(DateFormat("dd/MM/yyy").format(e.orderDate)),
                        padding: EdgeInsets.only(
                            left: 15,
                            right: 20
                        ),
                      ),
                      Expanded(
                          child: Text(e.orderStatus)
                      ),
                      Container(
                        child: Text("${e.amount} BDT"),
                        padding: EdgeInsets.only(left: 15,right: 20),
                      )
                    ],
                  ),
                )
            ).toList(),
          )
    );
  }
}
