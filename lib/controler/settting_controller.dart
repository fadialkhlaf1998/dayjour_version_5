import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingController extends GetxController{
  var value = "English".obs;
  HomeController homeController = Get.find();
  @override
  Future<void> onInit() async {
    if(Global.lang_code=="ar"){
      value.value="العربية";
    }else{
      value.value="English";
    }
    super.onInit();
  }
  change_lang(BuildContext context,String lang)async {
    MyApp.set_locale(context, Locale(lang));
    Get.updateLocale(Locale(lang));
    await Global.save_language(lang);
    await Global.load_language();
    homeController.updateMarqueeData();
  }
}