// To parse this JSON data, do
//
//     final topCategory = topCategoryFromMap(jsonString);

import 'package:dayjour_version_3/const/global.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class TopCategory {
  TopCategory({
    required this.id,
    required this.categoryId,
    required this.mainImage,
    required this.category,
    required this.arCategory,
  });

  int id;
  int categoryId;
  String mainImage;
  String category;
  String arCategory;

  getTitle(){
    if(Global.lang_code == "en"){
      return category;
    }else{
      return arCategory;
    }
  }

  factory TopCategory.fromJson(String str) => TopCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TopCategory.fromMap(Map<String, dynamic> json) => TopCategory(
    id: json["id"],
    categoryId: json["category_id"],
    mainImage: json["main_image"],
    category: json["category"],
    arCategory: json["ar_category"]??json["category"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "main_image": mainImage,
    "category": category,
    "ar_category": arCategory,
  };
}
