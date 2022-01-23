import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/sign_in_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  TextEditingController _email = TextEditingController();
  SignInController signInController = Get.find();
  var validate = false.obs;

  @override
  void initState() {
    super.initState();
  }

  _header() {
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
          child: GestureDetector(
            onTap: () {
              setState(() {
               Get.back();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      App_Localization.of(context).translate("back"),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 20 , left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            App_Localization.of(context).translate("forget"),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40, fontWeight:
                            FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            App_Localization.of(context).translate("password"),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  _body() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: _email,
        cursorColor: AppColors.main2,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          fillColor: Colors. white,
          filled: true,
          border: InputBorder.none,
          errorText:
          validate.value && (_email.text.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(_email.text)) ? App_Localization.of(context).translate("email_is_required") : null,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.red)),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: App_Localization.of(context).translate("email_address"),
          hintStyle: const TextStyle(color: Colors.black45),
          contentPadding: EdgeInsets.all(5),
          suffixIcon: const Icon(
            Icons.email_outlined,
            color: Colors.black45,
          ),
        ),

      ),
    );
  }
  _submit() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: FloatingActionButton.extended(
              backgroundColor: AppColors.main2,
              onPressed: () {
                setState(() {
                  if(_email.text.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(_email.text)) {
                    validate.value = true;
                  }
                  else {
                    validate.value = false;
                    signInController.forget_pass(context,_email.text);
                  }
                });
              },
              label: Text(
                App_Localization.of(context).translate("submit"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.main,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(),
                const SizedBox(height: 5),
                _body(),
                const SizedBox(height: 50),
                _submit()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
