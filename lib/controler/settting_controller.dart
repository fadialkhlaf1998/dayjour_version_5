import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingController extends GetxController{
  var value = "English".obs;
  @override
  Future<void> onInit() async {
    if(Global.lang_code=="ar"){
      value.value="العربية";
    }else{
      value.value="English";
    }
    super.onInit();
  }
  change_lang(BuildContext context,String lang){
    MyApp.set_locale(context, Locale(lang));
    Get.updateLocale(Locale(lang));
    Global.save_language(lang);
    Global.load_language();
  }
}