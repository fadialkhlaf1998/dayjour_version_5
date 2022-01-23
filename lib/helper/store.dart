import 'dart:convert';

import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/my_model/log_in_info.dart';
import 'package:dayjour_version_3/my_model/my_order.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dayjour_version_3/my_model/address.dart';


class Store{
  static save_order(List<MyOrder> myOrder){
    String myjson = json.encode(List<dynamic>.from(myOrder.map((x) => x.toMap())));
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("my_order", myjson);
    });
  }

  static Future<List<MyOrder>> load_order()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myjson = prefs.getString("my_order")??"non";
    if(myjson=="non"){
      return <MyOrder>[];
    }else{
      var jsonlist = jsonDecode(myjson) as List;
      List<MyOrder> list = <MyOrder>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(MyOrder.fromMap(jsonlist[i]));
      }
      return list;
    }
  }

  static save_wishlist(List<MyProduct> _products){
    SharedPreferences.getInstance().then((prefs) {
      String myjson = json.encode(List<dynamic>.from(_products.map((x) => x.toMap())));
      prefs.setString("wishlist", myjson);
      load_wishlist();
    });
  }

  static Future<List<MyProduct>> load_wishlist()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString("wishlist")??"non";
    if(jsonString=="non"){
      return <MyProduct>[];
    }else{
      var jsonlist = jsonDecode(jsonString) as List;
      List<MyProduct> list = <MyProduct>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return list;
    }
  }

  static saveLoginInfo(String email,String pass){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("email", email);
      prefs.setString("pass", pass);
    });
  }

  static logout(){
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove("email");
      prefs.remove("pass");
      prefs.remove("verificat");
    });
  }

  static Future<LogInInfo> loadLogInInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email")??"non";
    String pass = prefs.getString("pass")??"non";
    return LogInInfo(email, pass);
  }
  static save_verificat(){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("verificat", true);
    });
  }

  static Future<bool> load_verificat()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool("verificat")??false;
    return val;
  }

  static save_recently(List<MyProduct> _products){
    SharedPreferences.getInstance().then((prefs) {
      String myjson = json.encode(List<dynamic>.from(_products.map((x) => x.toMap())));
      prefs.setString("recently", myjson);
      load_wishlist();
    });
  }

  static save_rate(List<MyProduct> _products){
    SharedPreferences.getInstance().then((prefs) {
      String myjson = json.encode(List<dynamic>.from(_products.map((x) => x.toMap())));
      prefs.setString("rate", myjson);
      load_wishlist();
    });
  }

  static Future<List<MyProduct>> load_recently()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString("recently")??"non";
    if(jsonString=="non"){
      return <MyProduct>[];
    }else{
      var jsonlist = jsonDecode(jsonString) as List;
      List<MyProduct> list = <MyProduct>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return list;
    }
  }

  static Future<List<MyProduct>> load_rate()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString("rate")??"non";
    if(jsonString=="non"){
      return <MyProduct>[];
    }else{
      var jsonlist = jsonDecode(jsonString) as List;
      List<MyProduct> list = <MyProduct>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return list;
    }
  }

  static save_address(first_name, last_name, address,apartment, city, country, emirate, phone)async{
    SharedPreferences.getInstance().then((prefs) {
    prefs.setString("address",Address(first_name: first_name,last_name: last_name,address: address,apartment: apartment,city: city,country: country,phone: phone,Emirate: emirate).toJson());
    });
    load_address();
  }

  static load_address()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString("address")??"non";
    if(jsonString!="non"){
      Global.my_address= Address.fromJson(jsonString);
    }

  }

}