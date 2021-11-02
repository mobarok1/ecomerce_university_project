import 'dart:convert';

import 'package:ecomerce/models/client/api_client.dart';
import 'package:ecomerce/models/client/shared_preference.dart';
import 'package:ecomerce/models/dataClass/category_model.dart';
import 'package:ecomerce/models/dataClass/product_model.dart';
import 'package:ecomerce/models/dataClass/reponse_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductCategoryService{

  static Future<List<CategoryModel>> getAllCategories(context) async{
    List<CategoryModel> categories = [];
    http.Response response =  await http.get(Uri.parse(baseUrl+"category"),headers:<String,String>{'Content-Type': 'application/json; charset=UTF-8',});
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      data.forEach((e){
          categories.add(CategoryModel.fromJSON(e));
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text("Failed to load category data",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red[900],));
    }

    return categories;
  }
  static Future<List<Product>> getAllProducts(context) async{
    List<Product> products = [];
    http.Response response =  await http.get(Uri.parse(baseUrl+"product"),headers:<String,String>{'Content-Type': 'application/json; charset=UTF-8',});
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      for(var e in data){
        Product pro = Product.fromJSON(e);
        pro.favourite = await SharedPrefManager.alreadyExistFavoriteItems(pro);
        products.add(pro);
      }

    }else{
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text("Failed to load product data",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red[900],));
    }

    return products;
  }
  static Future<List<Product>> getCategoryProducts(context,int catId) async{
    List<Product> products = [];
    http.Response response =  await http.get(Uri.parse(baseUrl+"category/$catId"),headers:<String,String>{'Content-Type': 'application/json; charset=UTF-8',});
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      for(var e in data){
        Product pro = Product.fromJSON(e);
        pro.favourite = await SharedPrefManager.alreadyExistFavoriteItems(pro);
        products.add(pro);
      }

    }else{
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text("Failed to load product data",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red[900],));
    }

    return products;
  }
}