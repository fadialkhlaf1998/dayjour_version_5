// To parse this JSON data, do
//
//     final productInfo = productInfoFromMap(jsonString);

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class ProductInfo {
  ProductInfo({
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
    required this.images,
    required this.reviews,
    required this.availability,
    required this.offer_price,
    required this.category_id,
    required this.super_category_id,
    required this.sub_category,
    required this.sku,
    required this.brand,
  });

  int id;
  int subCategoryId;
  int brandId;
  String title;
  String subTitle;
  String description;
  double price;
  double rate;
  String image;
  String sub_category;
  String brand;
  String sku;
  int ratingCount;
  List<Image> images;
  List<Review> reviews;
  int availability;
  double? offer_price;
  var is_favoirite=false.obs;
  int category_id;
  int super_category_id;

  factory ProductInfo.fromJson(String str) => ProductInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductInfo.fromMap(Map<String, dynamic> json) => ProductInfo(
    id: json["id"],
    subCategoryId: json["sub_category_id"],
    sub_category: json["sub_category"]??"",
    sku: json["sku"]??"",
    brand: json["brand"]??"",
    brandId: json["brand_id"],
    title: json["title"],
    subTitle: json["sub_title"],
    description: json["description"],
    price: double.parse(json["price"].toString()),
    offer_price: json["offer_price"]==null?null:double.parse(json["offer_price"].toString()),
    rate:double.parse(json["rate"].toString()),
    image: json["image"],

    ratingCount: json["rating_count"],
    images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromMap(x))),
      availability: json["availability"]==null?0:json["availability"]<0?0:json["availability"],
      category_id: json["category_id"],
      super_category_id: json["super_category_id"]
    // availability: 0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "sub_category_id": subCategoryId,
    "brand_id": brandId,
    "title": title,
    "sub_title": subTitle,
    "description": description,
    "price": price,
    "offer_price": offer_price,
    "rate": rate,
    "image": image,
    "rating_count": ratingCount,
    "images": List<dynamic>.from(images.map((x) => x.toMap())),
    "reviews": List<dynamic>.from(reviews.map((x) => x.toMap())),
    "availability":availability,
    "category_id":category_id,
    "super_category_id":super_category_id
  };
}

class Image {
  Image({
    required this.link,
  });

  String link;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
    link: json["link"],
  );

  Map<String, dynamic> toMap() => {
    "link": link,
  };
}

class Review {
  Review({
    required this.id,
    required this.priductId,
    required this.customerId,
    required this.body,
    required this.customerName
  });

  int id;
  int priductId;
  int customerId;
  String body;
  String customerName;

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
    id: json["id"],
    priductId: json["priduct_id"],
    customerId: json["customer_id"],
    body: json["body"],
    customerName: json["customer"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "priduct_id": priductId,
    "customer_id": customerId,
    "body": body,
    "customer":customerName
  };
}
