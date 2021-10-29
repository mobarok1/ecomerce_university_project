import 'package:flutter/foundation.dart';

class Product{
  int id;
  int catId;
  int subCatId;
  String title;
  String description;
  int quantity;
  int price;
  String image1,image2,image3;
  String imageSmall1,imageSmall2,imageSmall3;
  int status;
  double offerPrice;
  bool favourite;

  Product({
      required this.id,
      required this.catId,
      required this.subCatId,
      required this.title,
      required this.description,
      required this.quantity,
      required this.price,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.imageSmall1,
      required this.imageSmall2,
      required this.imageSmall3,
      required this.status,
      required this.offerPrice,
      required this.favourite,
  });

  factory Product.fromJSON(data){
    return Product(
        id: data["id"],
        catId: data["cat_id"],
        subCatId: data["sub_id"],
        title: data["title"],
        description: data["description"],
        quantity: data["quantity"],
        price: data["price"],
        image1: data["image"],
        image2: data["image2"],
        image3: data["image3"],
        imageSmall1: data["image_small"],
        imageSmall2: data["image2_small"],
        imageSmall3: data["image3_small"],
        status: data["status"],
        offerPrice: data["offer_price"]??0,
        favourite: data["favourite"]??false,

    );
  }
  static Map<String,dynamic> toJSON(Product product){
    return {
      "id": product.id,
      "cat_id": product.catId,
      "sub_id": product.subCatId,
      "title": product.title,
      "description": product.description,
      "quantity": product.quantity,
      "price": product.price,
      "image": product.image1,
      "image2": product.image2,
      "image3": product.image3,
      "image_small": product.imageSmall1,
      "image2_small": product.imageSmall2,
      "image3_small": product.imageSmall3,
      "status": product.status,
      "offer_price": product.offerPrice,
      "favourite": product.favourite,
    };
  }
}