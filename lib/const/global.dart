import 'package:dayjour_version_3/my_model/address.dart';
import 'package:dayjour_version_3/my_model/auto_discount.dart';
import 'package:dayjour_version_3/my_model/product_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dayjour_version_3/my_model/log_in_info.dart';
import 'package:dayjour_version_3/my_model/customer.dart';

import '../my_model/shipping.dart';

class Global{
  static Shipping shipping = Shipping(amount: 10, minAmountFree: 250,emirate: "");
  static List<Shipping> new_shipping = <Shipping>[];
  static List<AutoDiscount> auto_discounts = <AutoDiscount>[];
  static String lang_code="en";
  static bool remember_pass=false;
  static String remember_password="non";
  static String remember_email="non";
  static LogInInfo? logInInfo;
  static List<String> suggestion_list=["Loreal","viva","mira","Kerastase","Mariani","Fanola","Maybelline","Roial","Ozone","MIM","Redone","Beauty","Make up","Men car","Salon & spa equipment","Salon & spa furniture","Tools & accessories","Conditioner","Facial Cleanser","Facial Mask","Facial cream & lotion","Facial Scrub","Foot & Body Care","Rose Water","Hair Coloring","Hair Mask","Face Mask","Hair Serum","Shampoo","Hair Treatment","Waxing & Hair Removal","Fragrance","Hairstyling Spray","Hand Sanitizer","Nail Extension","Nail Art Tools","Compact Powder","Nail Polish","Contact Lenses","Concealer","Mascara","Makeup Sponge","Eyebrows","Eyelashes","Eyeliner","Highlighters","Eyeshadow","Primer","Foundation","Lipstick","After Shave","Beard Brush","Grooming Tool","Hairstyling Wax","Facial Machine","Hair Steamer","Hairstyling Equipment","Wax Equipment","Trimmers & Clippers","Other Equipment","Nail Equipment","Gents Chair","Hair Washing Chair","Ladies Chair","Kids Chair","Salon Mirror","Salon Trolley","Other Furniture","Spa Bed","Manicure Pedicure Chair","Reception Sofa","Reception Counter","Barber Cape","Clips & Pins","Bed Roll","Comb & Brush","Hair Removal tools","Scissors","Spray Bottles","Other Tools","Spa Towels","Manicure Pedicure Tools"];
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