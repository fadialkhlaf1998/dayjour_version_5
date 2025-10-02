// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/controler/profile_controller.dart';
import 'package:dayjour_version_3/controler/settting_controller.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';

import 'package:dayjour_version_3/view/my_address.dart';
import 'package:dayjour_version_3/view/my_order.dart';
import 'package:dayjour_version_3/view/no_internet.dart';
import 'package:dayjour_version_3/view/policy_page.dart';
import 'package:dayjour_version_3/view/sign_in.dart';
import 'package:dayjour_version_3/view/sign_up.dart';
import 'package:dayjour_version_3/wedgits/plz_signin_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController newpass = TextEditingController();
  TextEditingController confNewpass = TextEditingController();
  HomeController homeController = Get.find();

  SettingController settingController = Get.put(SettingController());

  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx(() {
      return SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white),
            child: profileController.loading.value
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _header(context),
                //
                Global.customer == null
                    ? PlzSigninSignup()
                    : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: Get.width * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(App_Localization.of(context).translate("account_info"),
                                  style: App.textBlod(Colors.black, 14)),
                              SizedBox(height: 10,),
                              myCard(
                                  context,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            App_Localization.of(context).translate("name") + ":   ",
                                            style: App.textNormal(Colors.black, 12),
                                          ),
                                          Text(
                                            Global.customer!.firstname + " " + Global.customer!.lastname,
                                            style: App.textNormal(Colors.black, 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            App_Localization.of(context).translate("email") + ":   ",
                                            style: App.textNormal(Colors.black, 12),
                                          ),
                                          Text(
                                            Global.customer!.email,
                                            style: App.textNormal(Colors.black, 12),
                                          ),
                                        ],
                                      ),
                                      Divider(color: Colors.black,height: 30,),
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(() => MyOrderView());
                                        },
                                        child: myCardItem(
                                            context,
                                            firstIcon: Icon(Icons.shopping_bag_outlined,color: App.main2,),
                                            title: "my_orders",
                                            lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                        ),
                                      ),
                                      Divider(color: Colors.black,height: 30,),
                                      GestureDetector(
                                        onTap: (){
                                          homeController.selected_bottom_nav_bar.value = 3;
                                        },
                                        child: myCardItem(
                                            context,
                                            firstIcon: Icon(Icons.favorite_border,color: App.main2,),
                                            title: "wishlist",
                                            lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                        ),
                                      ),
                                      Divider(color: Colors.black,height: 30,),
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(() => MyAddress());
                                        },
                                        child: myCardItem(
                                            context,
                                            firstIcon: Icon(Icons.location_on_outlined,color: App.main2,),
                                            title: "address",
                                            lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                        ),
                                      )

                                    ],
                                  )
                              ),
                              SizedBox(height: 20,),
                              Text(App_Localization.of(context).translate("settings"),
                                  style: App.textBlod(Colors.black, 14)),
                              SizedBox(height: 10,),
                              myCard(
                                  context,
                                  child: Column(
                                    children: [

                                      GestureDetector(
                                        onTap: (){
                                          settingController.change_lang(context, Global.lang_code=="en"?"ar":"en");
                                        },
                                        child: myCardItem(
                                            context,
                                            firstIcon: Icon(Icons.language,color: App.main2,),
                                            title: "languages",
                                            lastIcon: Global.lang_code=="en"?Text("English"):Text("العربية")
                                        ),
                                      ),
                                      Divider(color: Colors.black,height: 30,),
                                      GestureDetector(
                                        onTap: (){
                                          //todo notifications
                                        },
                                        child: myCardItem(
                                            context,
                                            firstIcon: Icon(Icons.notifications_active_outlined,color: App.main2,),
                                            title: "notifications",
                                            lastIcon: Switch(activeColor: App.main2,value: true, onChanged: (val){

                                            })
                                        ),
                                      ),
                                      Divider(color: Colors.black,height: 30,),
                                      AnimatedContainer(
                                        duration:
                                        const Duration(milliseconds: 300),
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.8,
                                        height: profileController
                                            .openNewPass.value
                                            ? 100
                                            : 0,
                                        child: SingleChildScrollView(
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              App.textField(newpass,
                                                  "new_password", context,
                                                  validate: profileController
                                                      .validateNewPass.value),
                                              App.textField(confNewpass,
                                                  "confirm_password", context,
                                                  validate: profileController
                                                      .validateConfNewPass
                                                      .value),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          if (profileController
                                              .openNewPass.value) {
                                            profileController
                                                .change_password(
                                                context,
                                                newpass.value.text,
                                                confNewpass
                                                    .value.text);
                                          } else {
                                            profileController
                                                .openNewPass.value = true;
                                          }
                                        },
                                        child: myCardItem(
                                            context,
                                            firstIcon: Icon(Icons.lock_open,color: App.main2,),
                                            title: "password_reset",
                                            lastIcon: GestureDetector(
                                                onTap: (){
                                                  if (profileController
                                                      .openNewPass.value) {
                                                    profileController
                                                        .openNewPass.value = false;
                                                  } else {
                                                    profileController
                                                        .openNewPass.value = true;
                                                  }
                                                },
                                                child: profileController.openNewPass.value
                                                    ?Icon(Icons.keyboard_arrow_up,size: 25,)
                                                    :Icon(Icons.keyboard_arrow_down,size: 25,)
                                            )
                                        ),
                                      ),
                                      Divider(color: Colors.black,height: 30,),
                                      GestureDetector(
                                        onTap: (){
                                          homeController.showFloatActionBtn(false);
                                          Scaffold.of(context).showBottomSheet(

                                            backgroundColor: App.main2,

                                                (context) => Container(
                                              height: 200,
                                              width: Get.width,
                                              padding: EdgeInsets.all(14),
                                              color: Colors.white,
                                              child: myCard(context, child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      showAlertDialog(context);
                                                    },
                                                    child: myCardItem(
                                                        context,
                                                        firstIcon: Icon(Icons.delete_outline,color: App.main2,),
                                                        title: "delete_account",
                                                        lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                                    ),
                                                  ),
                                                  Divider(color: Colors.black,height: 30,),
                                                  GestureDetector(
                                                    onTap: (){
                                                      Get.to(PolicyPage(App_Localization.of(context).translate("faqs"), App_Localization.of(context).translate("faqs_content")));
                                                    },
                                                    child: myCardItem(
                                                        context,
                                                        firstIcon: Icon(Icons.question_answer_outlined,color: App.main2,),
                                                        title: "faqs",
                                                        lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                                    ),
                                                  ),
                                                  Divider(color: Colors.black,height: 30,),
                                                  GestureDetector(
                                                    onTap: (){
                                                      App.openwhatsapp(context, "Hi, I need Help");
                                                    },
                                                    child: myCardItem(
                                                        context,
                                                        firstIcon: SvgPicture.asset("assets/icon/whatsapp.svg",height: 25,width: 25,color: App.main2,),
                                                        title: "whatsapp",
                                                        lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                                    ),
                                                  ),

                                                ],
                                              )),
                                            ),
                                            showDragHandle: true,
                                          ).closed.whenComplete(() {
                                            homeController.showFloatActionBtn(true); // show FAB back
                                          });
                                          // showAlertDialog(context);
                                        },
                                        child: myCardItem(
                                            context,
                                            firstIcon: Icon(Icons.help_outline,color: App.main2,),
                                            title: "help",
                                            lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                        ),
                                      ),


                                    ],
                                  )
                              ),
                              const SizedBox(height: 20),

                              GestureDetector(
                                onTap: () {
                                  homeController.nave_to_logout();
                                },
                                child: Container(
                                    width: Get.width *0.9,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      //     color: Colors.black,
                                      //     width: 1),
                                        color: Colors.grey[100],
                                        borderRadius:
                                        BorderRadius.circular(
                                            8)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.logout,color: App.main2,),
                                        SizedBox(width: 10,),
                                        Text(
                                          App_Localization.of(context)
                                              .translate(
                                              "log_out"),
                                          style: App.textBlod(
                                              Colors.black, 14),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                              const SizedBox(height: 20),
                              myCard(context, child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: (){
                                          App.launchURL(context, "https://www.facebook.com/dayjour.beauty");
                                        },
                                        child: FaIcon(FontAwesomeIcons.facebookF,color: Colors.grey,size: 20,),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          App.launchURL(context, "https://www.instagram.com/dayjour.beauty/");
                                        },
                                        child: FaIcon(FontAwesomeIcons.instagram,color: Colors.grey,size: 20,),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          App.launchURL(context, "https://www.tiktok.com/@dayjour.beauty?lang=en");
                                        },
                                        child: FaIcon(FontAwesomeIcons.tiktok,color: Colors.grey,size: 20,),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          App.launchURL(context, "https://www.youtube.com/@dayjourgeneraltradingllc2008");
                                        },
                                        child: FaIcon(FontAwesomeIcons.youtube,color: Colors.grey,size: 20,),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          App.launchURL(context, "https://www.pinterest.com/dayjour_beauty/");
                                        },
                                        child: FaIcon(FontAwesomeIcons.pinterestP,color: Colors.grey,size: 20,),
                                      ),
                                      SizedBox(width: 10,),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(width: 10,),
                                      SizedBox(width: 10,),
                                      GestureDetector(onTap:(){Get.to(PolicyPage(App_Localization.of(context).translate("privacy_policy"), App_Localization.of(context).translate("privacy_policy_content")));},child: Text(App_Localization.of(context).translate("privacy_policy"),style: App.textNormal(Colors.grey, 10),)),
                                      Text(".",style: App.textNormal(Colors.black, 10),),
                                      GestureDetector(onTap:(){Get.to(PolicyPage(App_Localization.of(context).translate("terms_of_sale"), App_Localization.of(context).translate("terms_of_sale_content")));},child: Text(App_Localization.of(context).translate("terms_of_sale"),style: App.textNormal(Colors.grey, 10),)),
                                      Text(".",style: App.textNormal(Colors.black, 10),),
                                      GestureDetector(onTap:(){Get.to(PolicyPage(App_Localization.of(context).translate("return_policy"), App_Localization.of(context).translate("return_policy_content")));},child: Text(App_Localization.of(context).translate("return_policy"),style: App.textNormal(Colors.grey, 10),)),
                                      SizedBox(width: 10,),
                                      SizedBox(width: 10,),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(onTap: (){Get.to(PolicyPage(App_Localization.of(context).translate("shipping_policy"), App_Localization.of(context).translate("shipping_policy_content")));},child: Text(App_Localization.of(context).translate("shipping_policy"),style: App.textNormal(Colors.grey, 10),)),
                                    ],
                                  )
                                ],
                              )),
                              const SizedBox(height: 20),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    });
  }

  myCard(BuildContext context , {required Widget child}){
    return Container(
        width: Get.width * 0.9,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          // color: Colors.white,
          // border: Border.all(color: Colors.black),
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8)
        ),
        child: child
    );
  }
  myCardItem(BuildContext context,
      {required Widget firstIcon, required String title, required Widget lastIcon}){
    return Container(
      // color: App.nav_bar,
      height: 24,
      child: Row(
        children: [
          firstIcon,
          SizedBox(width: 14,),
          Text(App_Localization.of(context).translate(title)),
          Spacer(),
          lastIcon
        ],
      ),
    );
  }


  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: App.main2,
        boxShadow: [App.box_shadow()],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    homeController.selected_bottom_nav_bar.value = 0;
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                  )),
              GestureDetector(
                onTap: () {
                  homeController.selected_bottom_nav_bar.value = 0;
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/introduction/DAYJOUR_logo.png"))),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.transparent,
                    size: 25,
                  ))
            ],
          ),
          const SizedBox(),
          const SizedBox(),
          Global.customer == null
              ? const Center()
              : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Text(
                App_Localization.of(context).translate("hello") + " ",
                style: App.textBlod(Colors.white, 16),
              ),
              Text(
                Global.customer!.firstname +
                    " " +
                    Global.customer!.lastname,
                style: App.textNormal(Colors.white, 16),
              ),
            ],
          )
        ],
      ),
    );
  }


  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(App_Localization.of(context).translate("confirm")),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            profileController.delete_account(context);
          },
          child: Text(
            App_Localization.of(context).translate("yes"),
            style: TextStyle(color: App.main2),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            App_Localization.of(context).translate("no"),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
      content: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(App_Localization.of(context)
                .translate("are_you_sure_to_delete_account"))
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}



// // ignore_for_file: must_be_immutable
//
// import 'package:dayjour_version_3/app_localization.dart';
// import 'package:dayjour_version_3/const/app_colors.dart';
// import 'package:dayjour_version_3/const/global.dart';
// import 'package:dayjour_version_3/controler/home_controller.dart';
// import 'package:dayjour_version_3/controler/my_address_controller.dart';
// import 'package:dayjour_version_3/view/address_info.dart';
// import 'package:dayjour_version_3/view/my_address.dart';
// import 'package:dayjour_version_3/view/reset_password.dart';
// import 'package:dayjour_version_3/view/sign_in.dart';
// import 'package:dayjour_version_3/view/sign_up.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
//
// class Profile extends StatelessWidget {
//   Profile({Key? key}) : super(key: key);
//
//   HomeController homeController = Get.find();
//
//
//   _header(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * 0.18,
//       color: AppColors.main2,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(height: 1,),
//           Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   App_Localization.of(context).translate("my_profile"),
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child:Global.customer!=null? Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(width: 10,),
//                 Text(
//                   App_Localization.of(context).translate("hello")+", ",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16),
//                 ),
//                 Text(
//                   Global.customer!.firstname+" "+Global.customer!.lastname,
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14),
//                 ),
//               ],
//             ):Center(),
//           ),
//         ],
//       ),
//     );
//   }
//   _body(BuildContext context) {
//     return  Stack(
//       children: [
//         Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height * 0.72,
//           decoration: BoxDecoration(
//               color: AppColors.main,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(20),
//                 topLeft: Radius.circular(20),
//               )),
//           child:
//           Global.customer != null ?
//           Column(
//
//             children: [
//               SizedBox(height: 35),
//               Container(
//                 height: 35,
//                 width: MediaQuery.of(context).size.width-20,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black,width: 1),
//                   borderRadius: BorderRadius.circular(40)
//                 ),
//                 child: Row(
//                   children: [
//                     SizedBox(width: 10,),
//                     Text(
//                       App_Localization.of(context).translate("account_info"),
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10,),
//               Container(
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   height: 26,
//                   child: Text(
//                     App_Localization.of(context).translate("name")+": "+Global.customer!.firstname.toString()+" "+  Global.customer!.lastname.toString(),
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black45
//                     ),
//                   )
//               ),
//               Container(
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   height: 30,
//                   child: Text(
//                     App_Localization.of(context).translate("email")+": "+Global.customer!.email,
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black45
//                     ),
//                   )
//               ),
//
//               SizedBox(height: 30,),
//
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.45,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: Colors.black,width: 1)
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Get.to(()=> ResetPassword());
//                       },
//                       child:  Text(
//                         App_Localization.of(context).translate("password_reset"),
//                         style: TextStyle(color: Colors.black,
//                             fontSize: 14,fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 width: MediaQuery.of(context).size.width -20,
//                 height: 40,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: Colors.black,width: 1)
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Get.to(MyAddress());
//                       },
//                       child:  Text(
//                         App_Localization.of(context).translate("edit_address"),
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.black,
//                             //fontWeight: FontWeight.bold,
//                             fontSize: 14,fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 width: MediaQuery.of(context).size.width*0.95,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.4,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: Colors.black,width: 1)
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               homeController.selected_bottom_nav_bar.value=2;
//                             },
//                             child:  Text(
//                               App_Localization.of(context).translate("wishlist"),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(color: Colors.black,
//                                   //fontWeight: FontWeight.bold,
//                                   fontSize: 14,fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.4,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(color: Colors.black,width: 1)
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               homeController.go_to_my_order(context);
//                             },
//                             child:  Text(
//                               App_Localization.of(context).translate("my_orders"),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(color: Colors.black,
//                                   //fontWeight: FontWeight.bold,
//                                   fontSize: 14,fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 width: MediaQuery.of(context).size.width -20,
//                 height: 40,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.red,width: 1)
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         // Get.to(AddressView());
//                         homeController.delete_account(context);
//                       },
//                       child:  Text(
//                         App_Localization.of(context).translate("delete_account"),
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.red,
//                             //fontWeight: FontWeight.bold,
//                             fontSize: 14,fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ) :
//           Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.2,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 70,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage("assets/red_logo.png")
//                       )
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 10,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(App_Localization.of(context).translate("welcom_dayjout"),
//                     style: TextStyle(
//                         fontSize: 18
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Get.to(() => SignIn());
//                     },
//                     child: Text(
//                       App_Localization.of(context).translate("sign_in"),
//                       style: TextStyle(
//                           fontSize: 16,
//                           decoration:
//                           TextDecoration.underline,
//                           color: AppColors.main2
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(width: 10,),
//                   Text(App_Localization.of(context).translate("or"),style: TextStyle(fontSize: 16,color: Colors.grey),),
//                   SizedBox(width: 10,),
//                   GestureDetector(
//                     onTap: () {
//                       Get.to(() => SignUp());
//                     },
//                     child: Text(
//                       App_Localization.of(context).translate("sign_up2"),
//                       style: TextStyle(
//                           fontSize: 16,
//                           decoration:
//                           TextDecoration.underline,
//                           color: AppColors.main2
//                       ),
//                     ),
//                   ),
//
//                 ],
//               ),
//               SizedBox(height: 20,),
//             ],
//           ),
//         ),
//         Positioned(
//             child: homeController.loading.value?Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 0.72,
//               color: AppColors.main.withOpacity(0.6),
//               child: Center(
//                 child: CircularProgressIndicator(color: AppColors.main2,),
//               ),
//             ):Container(
//               width: MediaQuery.of(context).size.width,
//               height: 0,
//               color: AppColors.main,
//             ))
//
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     return Builder(
//         builder: (context) {
//           return SafeArea(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: AppColors.main2,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _header(context),
//                     _body(context)
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//     );
//   }
//
// }
