import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/helper/store.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/view/no_internet.dart';
import 'package:dayjour_version_3/view/recovery_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
 var hide_passeord=true.obs;
 var loading = false.obs;
 var email_vaildate = true.obs;
 var pass_vaildate = true.obs;
 var fname_vaildate = true.obs;
 var lname_vaildate = true.obs;

 void change_visibilty(){
  hide_passeord.value = !hide_passeord.value;
 }
 signUp(BuildContext context,String email,String pass,String fname,String lname){
  try{

   if(email.isEmpty||pass.isEmpty||fname.isEmpty||lname.isEmpty||pass.length<6 ||!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
    if(email.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(email)){

     email_vaildate.value=false;
    }else{
     email_vaildate.value=true;
    }
    if(pass.isEmpty||pass.length<6){
     if(pass.length<6&&pass.isNotEmpty){
      App.error_msg(context, App_Localization.of(context).translate("small_pass"));
      pass_vaildate.value=false;
     }
     pass_vaildate.value=false;

    }else{
     pass_vaildate.value=true;
    }

    if(fname.isEmpty){
     fname_vaildate.value=false;
    }else{
     fname_vaildate.value=true;
    }
    if(lname.isEmpty){
     lname_vaildate.value=false;
    }else{
     lname_vaildate.value=true;
    }
   }else{
    MyApi.check_internet().then((net) {
     if(net){
      loading.value=true;
      MyApi.sign_up(email, pass,fname,lname).then((value) {
        if(value.state==200){
        Store.saveLoginInfo(email, pass);
         App.sucss_msg(context, App_Localization.of(context).translate("user_inserted_successfully"));
         loading.value=false;
         Get.to(() => RecoveryCode());
       }else{
        loading.value=false;
        App.error_msg(context, App_Localization.of(context).translate("wrong_signup_msg"));
       }
      });
     }else{
      Get.to(()=>NoInternet())!.then((value) {
       signUp(context,email,pass,fname,lname);
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