import 'dart:convert';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/my_model/log_in_info.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
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

  static save_remember(bool val){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("remember", val);
      Global.remember_pass=val;
    });
  }

  static Future<bool> load_remember()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool("remember")??false;
    String pass = prefs.getString("remember_pass")??"non";
    String email = prefs.getString("remember_email")??"non";
    Global.remember_password=pass;
    Global.remember_email=email;
    Global.remember_pass=val;
    return val;
  }

  static Future<List<MyOrder>> load_order()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myjson = prefs.getString("my_order")??"non";
    if(myjson=="non"){
      return <MyOrder>[];
    }else{
      var jsonlist = jsonDecode(myjson) as List;
      List<MyOrder> list = <MyOrder>[];
      List<int> arr = <int>[];
      for(int i=0;i<jsonlist.length;i++){
        MyOrder order = MyOrder.fromMap(jsonlist[i]);
        list.add(order);
        arr.add(order.product.value.id);
      }
      List<MyProduct> prods = await MyApi.getCart(arr);
      for(int i=0 ; i<prods.length;i++){
        for(int j=0;j<list.length;j++){
          if(prods[i].id==list[j].product.value.id){
            list[j].product.value.availability=prods[i].availability;
            if(prods[i].availability==0){
              list[j].price.value="0.00";
            }
            if(list[j].quantity.value>prods[i].availability&&prods[i].availability!=0){
              list[j].quantity.value=prods[i].availability;
              list[j].price.value=(list[j].quantity.value*list[j].product.value.price).toString();
            }else if(prods[i].availability!=0){
              list[j].price.value=(list[j].quantity.value*list[j].product.value.price).toString();
            }
          }
        }
      }
      save_order(list);
      return list;
    }
  }
  static save_discount_code(String code){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("discount_code", code);
    });
  }

  static Future<String> load_discount_code()async{
    var prefs = await SharedPreferences.getInstance();
    String code=prefs.getString("discount_code")??"non";

    return code;
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
      prefs.setString("remember_pass", pass);
      prefs.setString("remember_email", email);
      Global.remember_password=pass;
      Global.remember_email=email;
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

  static save_address( address,apartment, city, country, emirate, phone)async{
    SharedPreferences.getInstance().then((prefs) {
    prefs.setString("address",Address(address: address,apartment: apartment,city: city,country: country,phone: phone,Emirate: emirate).toJson());
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