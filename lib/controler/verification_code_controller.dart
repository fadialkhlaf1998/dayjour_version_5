import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/helper/api.dart';
import 'package:dayjour_version_3/helper/log_in_api.dart';
import 'package:dayjour_version_3/helper/store.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:dayjour_version_3/view/no_internet.dart';
// import 'package:albassel_version_1/view/home.dart';
// import 'package:albassel_version_1/view/no_internet.dart';
// import 'package:albassel_version_1/view/verification_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerificationCodeController extends GetxController{

  var loading = false.obs;
  var code_vaildate = true.obs;

  resend(BuildContext context){
    try{
      MyApi.check_internet().then((net) {
       if(net){
         loading.value=true;
         Store.loadLogInInfo().then((info) {
           MyApi.resend_code(info.email).then((result) {
             loading.value=false;
             if(result.succses){
               App.sucss_msg(context, App_Localization.of(context).translate("check_your_email"));
             }else{
               App.error_msg(context, App_Localization.of(context).translate("something_went_wrong"));
             }
           });
         });
       }else{
         Get.to(()=>NoInternet())!.then((value) {
           resend(context);
         });
       }
     });
    }catch(e){
      loading.value=false;
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }

  }

  verificate(BuildContext context,String code){
    try{
      if(code.isEmpty){
        code_vaildate.value=false;
      }else{
        MyApi.check_internet().then((net) {
          if(net){
            code_vaildate.value=true;
            loading.value=true;
            Store.loadLogInInfo().then((info) {
              MyApi.verify_code(info.email,code).then((result) {
                loading.value=false;
                MyApi.login(info.email,info.pass);
                if(result.succses){
                  App.sucss_msg(context, App_Localization.of(context).translate("user_verified_successfully"));
                  Store.save_verificat();
                  Get.offAll(()=>Home());
                }else{
                  App.error_msg(context, App_Localization.of(context).translate("the_code_is_wrong"));
                }
              });
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              verificate(context,code);
            });
          }
        });
      }
    }catch(e){
      loading.value=false;
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }

  }

}
