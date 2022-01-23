import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/helper/api.dart';
import 'package:dayjour_version_3/helper/log_in_api.dart';
import 'package:dayjour_version_3/helper/store.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/view/sign_in.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:dayjour_version_3/view/no_internet.dart';
// import 'package:dayjour_version_2/view/home.dart';
// import 'package:dayjour_version_2/view/no_internet.dart';
// import 'package:dayjour_version_2/view/verification_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{

  var hide_passeord=true.obs;
  var loading = false.obs;
  var email_vaildate = true.obs;
  var pass_vaildate = true.obs;

  void change_visibilty(){
    hide_passeord.value = !hide_passeord.value;
  }

  signIn(BuildContext context,String email,String pass){
    try{
      if(email.isEmpty||pass.isEmpty){
        if(email.isEmpty){
          email_vaildate.value=false;
        }
        if(pass.isEmpty){
          pass_vaildate.value=false;
        }
      }else{
        MyApi.check_internet().then((net) {
          if(net){
            loading.value=true;
            MyApi.login(email, pass).then((value) {
              if(value.state==200){
                Store.saveLoginInfo(email, pass);
                App.sucss_msg(context,App_Localization.of(context).translate("login_has_been_successfully") );
                MyApi.login(email,pass).then((result){
                  loading.value=false;
                  Global.customer=result.data.first;
                  Get.offAll(()=>Home());
                });

              }else{
                loading.value=false;
                App.error_msg(context, App_Localization.of(context).translate("worng_mail_pass"));
              }
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              signIn(context,email,pass);
            });
          }
        });

      }

    }catch (e){
      print(e.toString());
      loading.value=false;
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }
    
  }

  forget_pass(BuildContext context,String email){
    try{
      if(email.isEmpty){
        email_vaildate.value=false;
      } else{
        MyApi.check_internet().then((net) {
          if(net){
            email_vaildate.value=true;
            loading.value=true;
            MyApi.forget_password(email).then((value) {
              loading.value=false;
              if(value.succses){
                App.sucss_msg(context, App_Localization.of(context).translate("password_sent_to_email_successfully"));
                Get.off(()=>SignIn());
              }else{
                App.error_msg(context, App_Localization.of(context).translate("wrong"));
              }
            })
            .catchError((value){
              loading.value=false;
              App.error_msg(context, App_Localization.of(context).translate("wrong"));
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              forget_pass(context,email);
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