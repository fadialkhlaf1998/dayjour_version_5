
import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/view/reset_password.dart';
import 'package:dayjour_version_3/view/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);


  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      color: AppColors.main2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  App_Localization.of(context).translate("my_profile"),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          )),
      child:
      Global.customer != null ?
      Column(
        children: [
          SizedBox(height: 50),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                App_Localization.of(context).translate("first_name"),
                style: TextStyle(
                    fontSize: 18,
                ),
              )
          ),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                Global.customer!.firstname.toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black45
                ),
              )
          ),
          Divider(
            color: Colors.black45,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 20),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                App_Localization.of(context).translate("last_name"),
                style: TextStyle(
                    fontSize: 18
                ),
              )
          ),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                Global.customer!.lastname.toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black45
                ),
              )
          ),
          Divider(
            color: Colors.black45,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 20),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                App_Localization.of(context).translate("email"),
                style: TextStyle(
                    fontSize: 18
                ),
              )
          ),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                Global.customer!.email.toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black45
                ),
              )
          ),
          Divider(
            color: Colors.black45,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(()=> ResetPassword());
                  },
                  child:  Text(
                    App_Localization.of(context).translate("password_reset"),
                    style: TextStyle(color: Colors.black,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ) :
      Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("you_must_login"),
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => SignIn());
                },
                child: Text(
                  App_Localization.of(context).translate("click_here"),
                  style: TextStyle(
                      fontSize: 20,
                      decoration:
                      TextDecoration.underline,
                      color: AppColors.main2
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.main2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _header(context),
                    _body(context)
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

}
