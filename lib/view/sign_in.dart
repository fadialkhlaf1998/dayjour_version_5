import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/sign_in_controller.dart';
import 'package:dayjour_version_3/view/forget_password.dart';
import 'package:dayjour_version_3/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignIn extends StatelessWidget {
  SignInController signInController=Get.put(SignInController());
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  _header(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/signin/signin.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.18,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("sign_in2"),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35)),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ],
    );
  }
  _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: email,
                  cursorColor: App.main2,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    errorText:
                    !signInController.email_vaildate.value && (email.text.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(email.text)) ? App_Localization.of(context).translate("email_is_required") : null,
                    border: InputBorder.none,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.red)),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                child: TextField(
                  controller: password,
                  cursorColor: App.main2,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: signInController.hide_passeord.value,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                    errorText:
                    !signInController.pass_vaildate.value && (password.text.isEmpty || password.text.length < 6) ? App_Localization.of(context).translate("password_is_invalid") : null,
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
                      onTap: signInController.change_visibilty,
                      child: Icon(
                        signInController.hide_passeord.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                       Get.to(()=> ForgetPassword());
                  },
                  child:  Text(
                    App_Localization.of(context).translate("forget_password"),
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _sign_in(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.06,
      child: FloatingActionButton.extended(
        backgroundColor: App.main2,
        onPressed: () {
            signInController.signIn(context, email.text, password.text);
        },
        label: Text(
          App_Localization.of(context).translate("sign_in"),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
  _sign_up(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  App_Localization.of(context).translate("or"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black45),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  App_Localization.of(context).translate("new_user"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black45),
                ),
                SizedBox(width: 2,),
                GestureDetector(
                  onTap: () {
                      Get.off(()=> SignUp());
                  },
                  child: Text(
                    App_Localization.of(context).translate("sign_up"),
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.main2),
                  ),
                ),
                SizedBox(width: 5,),
                Text(
                  App_Localization.of(context).translate("here"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black45),
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
        backgroundColor: AppColors.main2,
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
                        _sign_in(context),
                        _sign_up(context)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: signInController.loading.value?Container(
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
        ));
  }
}

