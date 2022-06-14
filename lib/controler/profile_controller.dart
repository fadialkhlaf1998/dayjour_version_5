import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  var openNewPass = false.obs;
  var validateNewPass = true.obs;
  var validateConfNewPass = true.obs;
  var loading = false.obs;

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  change_password(BuildContext context,String pass,String confPass){
    if(pass.isEmpty||confPass.isEmpty){
      if(pass.isEmpty){
        validateNewPass.value=false;
      }else{
        validateNewPass.value=true;
      }

      if(confPass.isEmpty){
        validateConfNewPass.value=false;
      }else{
        validateConfNewPass.value=true;
      }
    }else{
      if(pass==confPass&&pass.length>=6){
        MyApi.check_internet().then((internet){
          if(internet){
            validateConfNewPass.value=true;
            validateNewPass.value=true;
            loading.value=true;
            MyApi.change_password(Global.customer!.email, pass).then((result) {
              loading.value=false;
              if(result.succses){
                App.sucss_msg(context,App_Localization.of(context).translate("password_changed_succ"));
                Get.back();
              }else{
                App.error_msg(context, App_Localization.of(context).translate("wrong"));
              }
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              change_password(context,pass,confPass);
            });
          }
        });
      }else{
        if(pass.length<6){
          App.error_msg(
              context, App_Localization.of(context).translate("small_pass"));
        }else {
          App.error_msg(
              context, App_Localization.of(context).translate("pass"));
        }
      }
    }
  }
}