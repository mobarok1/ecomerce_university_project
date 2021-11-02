import 'dart:convert';

import 'package:ecomerce/models/client/api_client.dart';
import 'package:ecomerce/models/dataClass/order_model.dart';
import 'package:ecomerce/models/dataClass/reponse_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class OrderService{

  static Future<List<OrderModel>> getOrders(context) async{
    List<OrderModel> products = [];
    http.Response response =  await http.get(Uri.parse(baseUrl+"orders"),headers:<String,String>{'Content-Type': 'application/json; charset=UTF-8',});
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      for(var e in data){
        OrderModel pro = OrderModel.fromJSON(e);
        products.add(pro);
      }

    }else{
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text("Failed to load product data",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red[900],));
    }

    return products;
  }

  static Future<ResponseModel> createOrder(formBody) async{
    ResponseModel responseModel;
    http.Response response =  await http.post(Uri.parse(baseUrl+"checkout/store"),headers:<String,String>{'Content-Type': 'application/json; charset=UTF-8',} , body: jsonEncode(formBody));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      if(data["statusCode"]=="200"){

        responseModel = ResponseModel(statusCode: 200, message: "Success");

      }else{
        responseModel = ResponseModel(statusCode: 400, message: "Failed");

      }
    }else{
      responseModel = ResponseModel(statusCode: 500, message: "Failed to connect");
    }
    return responseModel;
  }

}