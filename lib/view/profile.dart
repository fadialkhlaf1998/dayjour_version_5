// ignore_for_file: must_be_immutable

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/view/address_info.dart';
import 'package:dayjour_version_3/view/reset_password.dart';
import 'package:dayjour_version_3/view/sign_in.dart';
import 'package:dayjour_version_3/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  HomeController homeController = Get.find();


  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.18,
      color: AppColors.main2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 1,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:Global.customer!=null? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
                Text(
                  App_Localization.of(context).translate("hello")+", ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  Global.customer!.firstname+" "+Global.customer!.lastname,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ],
            ):Center(),
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return  Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.72,
          decoration: BoxDecoration(
              color: AppColors.main,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
          child:
          Global.customer != null ?
          Column(

            children: [
              SizedBox(height: 35),
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width-20,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 1),
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Text(
                      App_Localization.of(context).translate("account_info"),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 26,
                  child: Text(
                    App_Localization.of(context).translate("name")+": "+Global.customer!.firstname.toString()+" "+  Global.customer!.lastname.toString(),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45
                    ),
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 30,
                  child: Text(
                    App_Localization.of(context).translate("email")+": "+Global.customer!.email,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45
                    ),
                  )
              ),

              SizedBox(height: 30,),

              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black,width: 1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(()=> ResetPassword());
                      },
                      child:  Text(
                        App_Localization.of(context).translate("password_reset"),
                        style: TextStyle(color: Colors.black,
                            fontSize: 14,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width -20,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black,width: 1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(AddressView());
                      },
                      child:  Text(
                        App_Localization.of(context).translate("edit_address"),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black,
                            //fontWeight: FontWeight.bold,
                            fontSize: 14,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width*0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black,width: 1)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              homeController.selected_bottom_nav_bar.value=2;
                            },
                            child:  Text(
                              App_Localization.of(context).translate("wishlist"),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 14,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black,width: 1)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              homeController.go_to_my_order(context);
                            },
                            child:  Text(
                              App_Localization.of(context).translate("my_orders"),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 14,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width -20,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red,width: 1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.to(AddressView());
                        homeController.delete_account(context);
                      },
                      child:  Text(
                        App_Localization.of(context).translate("delete_account"),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red,
                            //fontWeight: FontWeight.bold,
                            fontSize: 14,fontWeight: FontWeight.bold),
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
          ),
        ),
        Positioned(
            child: homeController.loading.value?Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.72,
              color: AppColors.main.withOpacity(0.6),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.main2,),
              ),
            ):Container(
              width: MediaQuery.of(context).size.width,
              height: 0,
              color: AppColors.main,
            ))

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
