import 'dart:convert';

class Address {
  String first_name;
  String last_name;
  String address;
  String apartment;
  String city;
  String country;
  String Emirate;
  String phone;

  Address({
    required this.first_name,
    required this.last_name,
    required  this.address,
    required this.apartment,
    required this.city,
    required this.country,
    required this.Emirate,
    required this.phone});

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    first_name:json['first_name'],
    last_name:json['last_name'],
    address: json["address"],
    apartment: json["apartment"],
    city: json["city"],
    country: json["country"],
    Emirate: json["Emirate"],
    phone: json["phone"],
  );

  Map<String, dynamic> toMap() => {
    "address": address,
    "last_name":last_name,
    "first_name":first_name,
    "apartment": apartment,
    "city": city,
    "country": country,
    "Emirate": Emirate,
    "phone": phone,
  };
}