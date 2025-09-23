import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/view/sign_in.dart';
import 'package:dayjour_version_3/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlzSigninSignup extends StatelessWidget {
  const PlzSigninSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.6-MediaQuery.of(context).padding.top,
      child:  Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/red_logo.png")
                    )
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("welcom_dayjout"),
                style: TextStyle(
                    fontSize: 18
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
                  App_Localization.of(context).translate("sign_in"),
                  style: TextStyle(
                      fontSize: 16,
                      decoration:
                      TextDecoration.underline,
                      color: AppColors.main2
                  ),
                ),
              ),

              SizedBox(width: 10,),
              Text(App_Localization.of(context).translate("or"),style: TextStyle(fontSize: 16,color: Colors.grey),),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  Get.to(() => SignUp());
                },
                child: Text(
                  App_Localization.of(context).translate("sign_up2"),
                  style: TextStyle(
                      fontSize: 16,
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
      )
    );
  }
}
