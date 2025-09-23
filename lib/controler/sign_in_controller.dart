import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/intro_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/helper/api_v2.dart';
import 'package:dayjour_version_3/helper/store.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/view/recovery_code.dart';
import 'package:dayjour_version_3/view/sign_in.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:dayjour_version_3/view/no_internet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInController extends GetxController{

  var hide_passeord=true.obs;
  var loading = false.obs;
  var email_vaildate = true.obs;
  var pass_vaildate = true.obs;
  var remember_value = Global.remember_pass.obs;

  void change_visibilty(){
    hide_passeord.value = !hide_passeord.value;
  }

  Future<bool> signInWithGoogle(BuildContext context)async{
    try{
      loading(true);
      UserCredential googleData = await getGoogleUser();
      print(googleData.user);
      if(googleData.user == null){
        App.error_msg(context, App_Localization.of(context).translate("wrong"));
        loading(false);
        return false;
      }else{
        String pass = generatePassword(googleData.user!.email!.split("@")[0]);
        singInVerfied(context,googleData.user!.email!,pass,
            getFirstName(googleData.user!.displayName!),getLastName(googleData.user!.displayName!));
        return true;
      }
    }catch(e){
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
      print('---------');
      print(e);
      print('---------');
      loading(false);
      return false;
    }
  }
  Future<UserCredential> getGoogleUser() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  getFirstName(String fullName){
    String firstName = "";
    List<String> parts = fullName.trim().split(RegExp(r"\s+"));

    if (parts.length == 1) {
      // Only one name given
      firstName = parts[0];
    } else if (parts.length == 2) {
      // Typical: First + Last
      firstName = parts[0];
      // lastName = parts[1];
    } else {
      // More than 2 parts: take first as firstName, the rest as lastName
      firstName = parts.first;
      // lastName = parts.sublist(1).join(" ");
    }
    return firstName;
  }

  getLastName(String fullName){
    String lastName = "";
    List<String> parts = fullName.trim().split(RegExp(r"\s+"));

    if (parts.length == 1) {
      // Only one name given
      // firstName = parts[0];
    } else if (parts.length == 2) {
      // Typical: First + Last
      // firstName = parts[0];
      lastName = parts[1];
    } else {
      // More than 2 parts: take first as firstName, the rest as lastName
      // firstName = parts.first;
      lastName = parts.sublist(1).join(" ");
    }
    return lastName;
  }

  signInWithApple(BuildContext context)async {
    // https://albasel-2025-dabd5.firebaseapp.com/__/auth/handler
    try{
      loading(true);
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      if (credential.email != null) {
        // AppStyle.successMsg(context, credential.email!);
        String email = credential.email!;
        String pass = generatePassword(credential.email!.split("@")[0]);
        String name = "";
        if (credential.givenName != null && credential.familyName != null) {
          name = credential.givenName! + " " + credential.familyName!;
        }
        singInVerfied(context,email,pass,
            getFirstName(name),getLastName(name));
      } else if (credential.identityToken != null) {
        // AppStyle.successMsg(context, credential.identityToken!.substring(0,15));
        String email = credential.identityToken!.substring(0, 15);
        String pass = generatePassword(
            credential.identityToken!.substring(0, 15));
        String name = "";
        if (credential.givenName != null && credential.familyName != null) {
          name = credential.givenName! + " " + credential.familyName!;
        }
        singInVerfied(context,email,pass,
            getFirstName(name),getLastName(name));
      } else {
        loading(false);
        App.error_msg(context, App_Localization.of(context).translate("wrong"));
      }
    }catch(e){
      loading(false);
    }
  }
  generatePassword(String mail){
    String pass = mail;
    pass+="AlbaselAutoSignin";
    return pass;
  }

  singInVerfied(BuildContext context,String email,String  pass, String fName, String lName)async{
    print('-----------');
    print(email);
    print(pass);
    print(fName);
    print(lName);
    bool s = await ApiV2.signUpVerfied(email, pass, fName, lName);
    print('----END----');
    IntroController introController = Get.find();
    introController.get_nav();
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
        MyApi.check_internet().then((net) async{
          if(net){
            loading.value=true;
            final packageInfo = await PackageInfo.fromPlatform();
            MyApi.login(email, pass,Global.firebase_token,packageInfo.version).then((value) {
              if(value.state==200){
                if(value.data[0].isActive == 0){
                  Get.offAll(RecoveryCode());
                }else{
                  Store.saveLoginInfo(email, pass);
                  App.sucss_msg(context,App_Localization.of(context).translate("login_has_been_successfully") );
                  loading.value=false;
                  Get.offAll(()=>Home());
                  CartController cartController= Get.find();
                  WishListController wishListController= Get.find();
                  cartController.getData(null);
                  wishListController.getData();
                }

                // MyApi.login(email,pass,Global.firebase_token,packageInfo.version).then((result){
                //   loading.value=false;
                //   Global.customer=result.data.first;
                //   Get.offAll(()=>Home());
                // });

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