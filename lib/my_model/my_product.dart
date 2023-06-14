// To parse this JSON data, do
//
//     final myProduct = myProductFromMap(jsonString);

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class MyProduct {
  MyProduct({
    required this.id,
    required this.subCategoryId,
    required this.brandId,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.price,
    required this.rate,
    required this.image,
    required this.ratingCount,
    required this.availability,
    this.count,
    required this.offer_price,
    required this.category_id,
    required this.super_category_id,
    required this.sub_category,
    required this.brand,
    required this.sku,
  });

  int id;
  int? count;
  int? subCategoryId;
  int? brandId;
  String title;
  String subTitle;
  String description;
  double price;
  double? offer_price;
  double rate;
  String image;
  String sub_category;
  String brand;
  String sku;
  int ratingCount;
  var favorite=false.obs;
  int availability;
  int category_id;
  int super_category_id;

  factory MyProduct.fromJson(String str) => MyProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyProduct.fromMap(Map<String, dynamic> json){
    return  MyProduct(
        id: json["id"],
        subCategoryId: json["sub_category_id"],
        brandId: json["brand_id"],
        title: json["title"]??"",
        subTitle: json["sub_title"]??"",
        sub_category: json["sub_category"]??"",
        brand: json["brand"]??"",
        sku: json["sku"]??"",
        description: json["description"]??"",
        price: double.parse(json["price"].toString()),
        offer_price: json["offer_price"]==null?null:double.parse(json["offer_price"].toString()),
        rate: double.parse(json["rate"].toString()),
        image: json["image"],
        ratingCount: json["rating_count"],
        availability: json["availability"]==null?0:json["availability"]<0?0:json["availability"],
        // availability: 0,
        count: json["count"],
        category_id: json["category_id"],
        super_category_id: json["super_category_id"]
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "sub_category_id": subCategoryId,
    "brand_id": brandId,
    "title": title,
    "sub_title": subTitle,
    "description": description,
    "price": price,
    "rate": rate,
    "image": image,
    "rating_count": ratingCount,
    "availability":availability,
    "offer_price":offer_price,
    "category_id":category_id,
    "super_category_id":super_category_id
  };
}
