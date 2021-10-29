import 'dart:convert';

import 'package:ecomerce/models/dataClass/cart_model.dart';
import 'package:ecomerce/models/dataClass/product_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefManager{

  static Future<bool> alreadyExist(Product product) async{
    List<CartModel> cartItems = [];
    bool alreadyExist = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> oldItems =  sharedPreferences.getStringList("cartItems")??[];
    for (var element in oldItems) {
      CartModel model = CartModel.fromJSON(jsonDecode(element));
      if(model.product.id==product.id){
        alreadyExist = true;
      }
      cartItems.add(model);
    }
    return alreadyExist;
  }

  static void addToCart(context,CartModel newItem) async{
    List<CartModel> cartItems = [];
    bool alreadyExist = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> oldItems =  sharedPreferences.getStringList("cartItems")??[];
    for (var element in oldItems) {
      CartModel model = CartModel.fromJSON(jsonDecode(element));
      if(model.product.id==newItem.product.id){
        alreadyExist = true;
      }
      cartItems.add(model);
    }
    if(alreadyExist){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item already in cart")));
    }else{
        oldItems.add(jsonEncode(CartModel.toJSON(newItem)));
    }
    sharedPreferences.setStringList("cartItems", oldItems);
  }

  static void removeFromCart(CartModel newItem) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> oldItems =  sharedPreferences.getStringList("cartItems")??[];
    List<String> newItems =  [];
    for (var element in oldItems) {
      CartModel model = CartModel.fromJSON(jsonDecode(element));
      if(model.product.id!=newItem.product.id){
        newItems.add(jsonEncode(CartModel.toJSON(model)));
      }
    }
    sharedPreferences.setStringList("cartItems", newItems);
  }

  static void increment(CartModel newItem) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> oldItems =  sharedPreferences.getStringList("cartItems")??[];
    List<String> newItems = [];
    for (var element in oldItems) {
      CartModel model = CartModel.fromJSON(jsonDecode(element));
      if(model.product.id==newItem.product.id){
          model.quantity++;
          model.subTotal =model.product.price;
          model.total = model.quantity * model.subTotal;
      }
      newItems.add(jsonEncode(CartModel.toJSON(model)));
    }

    sharedPreferences.setStringList("cartItems", newItems);
  }
  static void decrement(CartModel newItem) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> oldItems =  sharedPreferences.getStringList("cartItems")??[];
    List<String> newItems = [];
    for (var element in oldItems) {
      CartModel model = CartModel.fromJSON(jsonDecode(element));
      if(model.product.id==newItem.product.id){
        if(model.quantity > 1){
          model.quantity--;
        }
        model.subTotal =model.product.price;
        model.total = model.quantity * model.subTotal;
      }
      newItems.add(jsonEncode(CartModel.toJSON(model)));
    }

    sharedPreferences.setStringList("cartItems", newItems);
  }
  static Future<List<CartModel>> getCartItems() async{
    List<CartModel> cartItems = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> oldItems =  sharedPreferences.getStringList("cartItems")??[];
    for (var element in oldItems) {
      CartModel model = CartModel.fromJSON(jsonDecode(element));
      cartItems.add(model);
    }
    return cartItems;
  }



  static Future<bool> alreadyExistFavoriteItems(Product product) async{
    bool alreadyExist = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> oldItems =  sharedPreferences.getStringList("FavoriteItems")??[];
    for (var element in oldItems) {
      Product model = Product.fromJSON(jsonDecode(element));
      if(model.id==product.id){
        alreadyExist = true;
      }
    }
    return alreadyExist;
  }

  static void addToFavoriteItems(context,Product newItem) async{
    List<Product> favorites = [];
    bool alreadyExist = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> oldItems =  sharedPreferences.getStringList("FavoriteItems")??[];
    for (var element in oldItems) {
      Product model = Product.fromJSON(jsonDecode(element));
      if(model.id==newItem.id){
        alreadyExist = true;
      }
      favorites.add(model);
    }
    if(alreadyExist){
      removeFromFavoriteItems(newItem);
    }else{
      oldItems.add(jsonEncode(Product.toJSON(newItem)));
    }
    sharedPreferences.setStringList("FavoriteItems", oldItems);
  }

  static void removeFromFavoriteItems(Product newItem) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> oldItems =  sharedPreferences.getStringList("FavoriteItems")??[];
    List<String> newItems =  [];
    for (var element in oldItems) {
      Product model = Product.fromJSON(jsonDecode(element));
      if(model.id!=newItem.id){
        newItems.add(jsonEncode(Product.toJSON(model)));
      }
    }
    sharedPreferences.setStringList("FavoriteItems", newItems);
  }



  static Future<List<Product>> getFavoriteItems() async{
    List<Product> favourites = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> oldItems =  sharedPreferences.getStringList("FavoriteItems")??[];
    for (var element in oldItems) {
      Product model = Product.fromJSON(jsonDecode(element));
      favourites.add(model);
    }
    return favourites;
  }

}