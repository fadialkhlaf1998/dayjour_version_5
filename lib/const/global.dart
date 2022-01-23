import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/main.dart';
import 'package:dayjour_version_3/my_model/address.dart';
import 'package:dayjour_version_3/my_model/product_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dayjour_version_3/my_model/log_in_info.dart';
import 'package:dayjour_version_3/my_model/customer.dart';

class Global{
  static String lang_code="en";
  static LogInInfo? logInInfo;
  static List<String> suggestion_list=["fanola","makeup","powder"];
  static Address? my_address;
  static MyCustomer? customer;
  static List<ProductInfo> recentlyProduct = <ProductInfo>[];

  static add_to_recently(ProductInfo productInfo){
    for (int i = 0; i < recentlyProduct.length; i++){
      if(productInfo.id == recentlyProduct[i].id){
        return;
      }
    }
    if(recentlyProduct.length>10){
      recentlyProduct.removeAt(0);
      recentlyProduct.add(productInfo);
    }else{
      recentlyProduct.add(productInfo);
    }
  }
  static save_language(String locale){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("lang", locale);
    });
  }



  static Future<String> load_language()async{
    try{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      String lang=prefs.getString("lang")??'def';
      if(lang!="def"){
        Global.lang_code=lang;
      }else{
        Global.lang_code="en";
      }
      return Global.lang_code;
    }catch(e){

      return "en";
    }

  }
}