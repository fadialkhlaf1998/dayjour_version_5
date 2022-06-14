// To parse this JSON data, do
//
//     final customerOrder = customerOrderFromMap(jsonString);

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class CustomerOrder {
  CustomerOrder({
    required this.id,
    required this.customerId,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.apartment,
    required this.country,
    required this.emirate,
    required this.phone,
    required this.details,
    required this.subTotal,
    required this.shipping,
    required this.total,
    required this.isPaid,
    required this.deliver,
    required this.date,
    required this.code,
    required this.current,
    required this.tax,
  });

  int id;
  int customerId;
  String firstname;
  String lastname;
  String address;
  String apartment;
  String country;
  String emirate;
  String phone;
  String details;
  double subTotal;
  double shipping;
  double total;
  double tax;
  int isPaid;
  int deliver;
  var openCard = false.obs;
  var date ;
  var current ;
  String code;


  factory CustomerOrder.fromJson(String str) => CustomerOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerOrder.fromMap(Map<String, dynamic> json) => CustomerOrder(
    id: json["id"],
    customerId: json["customer_id"],
    firstname: json["firstname"]??"non",
    lastname: json["lastname"]??"non",
    address: json["address"]??"non",
    apartment: json["apartment"]??"non",
    country: json["country"]??"non",
    emirate: json["emirate"]??"non",
    phone: json["phone"]??"non",
    details: json["details"]??"non",
    subTotal: double.parse(json["sub_total"].toString()),
    shipping: double.parse(json["shipping"].toString()),
    total: double.parse(json["total"].toString()),
    tax:json["tax"]==null?0.0: double.parse(json["tax"].toString()),
    isPaid: json["is_paid"]??"non",
    deliver: json["deliver"]??"non",
    date: DateTime.parse(json["created_at"]),
    current: DateTime.parse(json["current"]),

    code: json["code"]??"non"
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "customer_id": customerId,
    "firstname": firstname,
    "lastname": lastname,
    "address": address,
    "apartment": apartment,
    "country": country,
    "emirate": emirate,
    "phone": phone,
    "details": details,
    "sub_total": subTotal,
    "shipping": shipping,
    "total": total,
    "is_paid": isPaid,
    "current":current,
    "tax":tax,
  };
}
