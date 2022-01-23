import 'dart:ui';

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/sign_up_controller.dart';
import 'package:dayjour_version_3/view/sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {

  SignUpController signUpController = Get.put(SignUpController());

  TextEditingController fname=TextEditingController();
  TextEditingController lname=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool isHidden = true;


  _header(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/signup/signup.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text(App_Localization.of(context).translate("sign_up2"),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
            ],
          ),
        ),
      ],
    );
  }
  _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child:  TextField(
                controller:fname,
                cursorColor: App.main2,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  errorText:
                  !signUpController.fname_vaildate.value && fname.text.isEmpty ? App_Localization.of(context).translate("first_name_is_required") : null,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: App_Localization.of(context).translate("first_name"),
                  hintStyle: TextStyle(color: Colors.black45),
                  contentPadding: EdgeInsets.all(5),
                  suffixIcon: Icon(
                    Icons.person,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child:  TextField(
                controller: lname,
                cursorColor: App.main2,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  errorText:
                  !signUpController.lname_vaildate.value && lname.text.isEmpty ? App_Localization.of(context).translate("last_name_is_required") : null,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: App_Localization.of(context).translate("last_name"),
                  hintStyle: TextStyle(color: Colors.black45),
                  contentPadding: EdgeInsets.all(5),
                  suffixIcon: Icon(
                    Icons.person,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child:  TextFormField(
                controller: email,
                cursorColor: App.main2,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  errorText:
                  !signUpController.email_vaildate.value && (email.text.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(email.text)) ? App_Localization.of(context).translate("email_is_required") : null,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: App_Localization.of(context).translate("email_address"),
                  hintStyle: TextStyle(color: Colors.black45),
                  contentPadding: EdgeInsets.all(5),
                  suffixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: password,
                cursorColor: App.main2,
                textAlignVertical: TextAlignVertical.center,
                obscureText: isHidden,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  errorText:
                  !signUpController.pass_vaildate.value && (password.text.isEmpty || password.text.length < 6) ? App_Localization.of(context).translate("password_is_invalid") : null,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: App_Localization.of(context).translate("password"),
                  hintStyle: TextStyle(color: Colors.black45),
                  contentPadding: EdgeInsets.all(5),
                  suffixIcon: InkWell(
                    onTap: signUpController.change_visibilty,
                    child: Icon(
                      isHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
  _sign_up(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.06,
          child: FloatingActionButton.extended(
            backgroundColor: App.main2,
            onPressed: () {
                signUpController.signUp(context,email.text,password.text,fname.text,lname.text);
            },
            label: Text(
              App_Localization.of(context).translate("sign_up"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
  _sign_in(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  App_Localization.of(context).translate("already_i_have_account"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black45),
                ),
                SizedBox(width: 7,),
                GestureDetector(
                  onTap: () {
                      Get.off(()=>SignIn());
                  },
                  child: Text(
                    App_Localization.of(context).translate("sign_in"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration:
                        TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: App.main2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      body: SafeArea(
        child: Obx((){
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: App.main,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _header(context),
                      _body(context),
                      _sign_up(context),
                      SizedBox(height: 20),
                      _sign_in(context),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: signUpController.loading.value?Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.main.withOpacity(0.6),
                  child: Center(
                    child: CircularProgressIndicator(color: App.main2,),
                  ),
                ):Center(),
              )
            ],
          );
        }),
      ),
    );
  }
}

