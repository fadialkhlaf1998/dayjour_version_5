import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  ProfileController profileController = Get.put(ProfileController());

  bool isHidden_new = true;
  bool isHidden_confirm = true;

  @override
  void initState() {
    super.initState();
  }

  void newPasswordView() {
    setState(() {
      isHidden_new = !isHidden_new;
    });
  }
  void confirmPasswordView() {
    setState(() {
      isHidden_confirm = !isHidden_confirm;
    });
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
              // setState(() {
                Get.back();
              // });
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
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            App_Localization.of(context).translate("reset"),                                    style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children:  [
                          Text(
                            App_Localization.of(context).translate("password"),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
  _body() {
    return  Container(
      width: MediaQuery.of(context).size.width,
      child:  Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              controller: profileController.newPassword,
              cursorColor: AppColors.main2,
              obscureText: isHidden_new,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: InputBorder.none,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorText:
                !profileController.validateNewPass.value ? App_Localization.of(context).translate("password_is_invalid") : null,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.red)),
                hintText: App_Localization.of(context).translate("new_password"),
                hintStyle: TextStyle(color: Colors.black45),
                contentPadding: EdgeInsets.all(5),
                suffixIcon: InkWell(
                  onTap: newPasswordView,
                  child: Icon(
                    isHidden_new
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              controller: profileController.confirmPassword,
              cursorColor: AppColors.main2,
              obscureText: isHidden_confirm,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: InputBorder.none,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorText:
                !profileController.validateConfNewPass.value && (profileController.confirmPassword.text.isEmpty || profileController.confirmPassword.text.length < 6) ? App_Localization.of(context).translate("password_is_invalid") : null,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.red)),
                hintText: App_Localization.of(context).translate("confirm_password"),
                hintStyle: TextStyle(color: Colors.black45),
                contentPadding: EdgeInsets.all(5),
                suffixIcon: InkWell(
                  onTap: confirmPasswordView,
                  child: Icon(
                    isHidden_confirm
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 45),
        ],
      ),
    );
  }
  _submit() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.06,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.main2,
          onPressed: () {
            setState(() {
              profileController.change_password(context,profileController.newPassword.text,profileController.confirmPassword.text);
            });
          },
          label: Text(
            App_Localization.of(context).translate("submit"),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColors.main,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _header(),
                      _body(),
                      _submit(),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: profileController.loading.value?Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.main.withOpacity(0.6),
                  child: Center(
                    child: CircularProgressIndicator(color: App.main2,),
                  ),
                ):Center(),
              )
            ],
          ),
        );
      })
    );
  }
}
