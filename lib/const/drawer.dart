import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/helper/store.dart';
import 'package:dayjour_version_3/view/policy_page.dart';
import 'package:dayjour_version_3/view/sign_in.dart';
import 'package:dayjour_version_3/view/cart.dart';
import 'package:dayjour_version_3/view/introduction.dart';
import 'package:dayjour_version_3/view/settings.dart';
import 'package:dayjour_version_3/view/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_colors.dart';


class DrawerWidget {

  static HomeController homeController = Get.find();


  static _launchURL(String _url,BuildContext context) async {
    if (!await launch(_url)){
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    };
  }

  static Drawer drawer(BuildContext context) {
    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.main2,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Image.asset("assets/introduction/logo.png"),
                  ),
                ),
                const SizedBox(height: 00),
                Container(
                  width: 150,
                  child: GestureDetector(
                    onTap: () {
                      homeController.go_to_my_order(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart_outlined,color: Colors.white,),
                        SizedBox(width: 15,),
                        Text(
                          App_Localization.of(context).translate("my_orders"),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: 150,
                  child: GestureDetector(
                    onTap: () {
                     Get.to(() => Settings());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.settings,color: Colors.white,),
                        SizedBox(width: 15,),
                        Text(
                          App_Localization.of(context).translate("settings"),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: 150,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(()=>PolicyPage("about_us","about_us_content" ));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.info_outline,color: Colors.white,),
                        SizedBox(width: 15,),
                        Text(
                          App_Localization.of(context).translate("about_us"),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: 150,
                  child: GestureDetector(
                    onTap: () {
                      //todo something
                      App.openwhatsapp(context, App_Localization.of(context).translate("whatsapp_info"));
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/whatsapp.svg",width: 21,),
                        SizedBox(width: 15,),
                        Text(
                          App_Localization.of(context).translate("whatsapp"),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: 150,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(()=>PolicyPage( "faq","faq_content"));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.question_answer_outlined,color: Colors.white,),
                        SizedBox(width: 15,),
                        Text(
                          App_Localization.of(context).translate("faq"),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Global.customer==null?Center():Container(
                  width: 150,
                  child: GestureDetector(
                    onTap: () async {
                      Global.customer=null;
                      await Store.logout();
                      Get.offAll(Welcome());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.logout, color: Colors.white,),
                        SizedBox(width: 15),
                        Text(
                          App_Localization.of(context).translate("log_out"),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _launchURL("https://www.instagram.com/dayjour.beauty/",context);
                        },
                        child:  Container(
                          width: 25,
                          height: 25,
                          child: SvgPicture.asset("assets/social_media/instagram.svg"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchURL("https://www.facebook.com/dayjour.beauty",context);
                        },
                        child:  Container(
                          width: 25,
                          height: 25,
                          child: SvgPicture.asset("assets/social_media/facebook.svg"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchURL("https://www.youtube.com/channel/UCGm57DZEItU6mtJPnkZt2PA",context);
                        },
                        child:  Container(
                          width: 25,
                          height: 25,
                          child: SvgPicture.asset("assets/social_media/youtube.svg"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(PolicyPage('privacy_policy','privacy_policy_content'));
                            //_launchURL("https://www.dayjour.net/pages/privacy-policy",context);
                          },
                          child: Column(
                            children: [
                              Text(
                                App_Localization.of(context).translate("privacy_policy"),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: const [
                            Text(".",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(PolicyPage('terms_of_sale', 'terms_of_sale_content'));
                            //_launchURL("https://www.dayjour.net/pages/terms-conditions",context);
                          },
                          child: Column(
                            children: [
                              Text(
                                App_Localization.of(context).translate("terms_of_sale"),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: const [
                            Text(".",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(PolicyPage('return_policy', 'return_policy_content'));
                            //_launchURL("https://www.dayjour.net/pages/refund-policy",context);
                          },
                          child: Column(
                            children: [
                              Text(
                                App_Localization.of(context).translate("return_policy"),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                    Get.to(PolicyPage('shipping_policy','shipping_policy_content'));
                    //_launchURL("https://www.dayjour.net/pages/privacy-policy",context);
                  },
                  child: Column(
                    children: [
                      Text(
                        App_Localization.of(context).translate("shipping_policy"),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Version 3.30(1019)",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.white60
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.camera_rounded,
                                  size: 10,
                                  color: Colors.white,),
                              ],
                            ),
                            SizedBox(width: 1,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("2018Dayjour.ALL RIGHTS RESERVED.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

