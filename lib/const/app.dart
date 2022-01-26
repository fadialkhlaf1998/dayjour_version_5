import 'dart:io';

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class App{
  static Color main2 = Color(0xffc01d2d);
  static Color main = Color(0xfffff6f7);
  static Color nav_bar = Color(0xffd37e93);


  static textBlod(Color color,double size){
    return TextStyle(color: color,fontWeight: FontWeight.bold,fontSize: size,overflow: TextOverflow.ellipsis);
  }
  static textNormal(Color color,double size){
    return TextStyle(color: color,fontSize: size,overflow: TextOverflow.ellipsis);
  }
  static textField(TextEditingController controller,String translate,BuildContext context,{bool validate=true}){
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: App_Localization.of(context).translate(translate),
          hintStyle: textNormal(Colors.grey, 14),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: validate?Colors.grey:Colors.red)),
          focusedBorder:  UnderlineInputBorder(borderSide: BorderSide(color: validate?Colors.black:Colors.red))

        ),
        style: textNormal(Colors.grey, 14),
      ),
    );
  }
  static checkoutTextField(TextEditingController controller,String translate,BuildContext context,double width,double height,bool err){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate(translate),style: textNormal(Colors.grey, 12),),
        Container(
          width: width,
          height: height,
    child: TextField(
           controller: controller,
            decoration: InputDecoration(
              enabledBorder: err&&controller.value.text.isEmpty?UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)):UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))
            ),
            style: textNormal(Colors.black, 14),
          ),
        ),
      ],
    );
  }

  static box_shadow(){
    return  BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10);
  }

  static openwhatsapp(BuildContext context,String msg) async{
    var whatsapp ="+971 52 692 4018";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=$msg";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse(msg)}";
    // if(Platform.isIOS){
    //   // for iOS phone only
    //   if( await canLaunch(whatappURL_ios)){
    //     await launch(whatappURL_ios, forceSafariVC: false);
    //   }else{
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: new Text("whatsapp no installed")));
    //
    //   }
    //
    // }else{
      // android , web
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }


    // }

  }

  static Drawer get_drawer(BuildContext context,HomeController homeController){
    return Drawer(
      backgroundColor: Color(0xffE37B2F).withOpacity(0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 0,),
          Container(
            height: MediaQuery.of(context).size.height*0.25,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){
                      homeController.closeDrawer();
                    }, icon: Icon(Icons.close,color: Colors.white,))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Container(
                      height: MediaQuery.of(context).size.height*0.1,
                       width:  MediaQuery.of(context).size.height*0.1,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: AssetImage("assets/logo/logo.png")
                       )
                     ),
                   )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(onTap: (){homeController.nave_to_home();},child: Icon(Icons.home,color: Colors.white,)),
                    GestureDetector(onTap: (){homeController.nave_to_wishlist();},child: Icon(Icons.favorite_border,color: Colors.white,)),
                    GestureDetector(onTap: (){homeController.nave_to_setting();},child: Icon(Icons.settings,color: Colors.white,)),
                    GestureDetector(onTap: (){homeController.nave_to_about_us();},child: Icon(Icons.info_outline,color: Colors.white,)),
                    GestureDetector(onTap: (){homeController.nave_to_logout();},child: Icon(Icons.logout,color: Colors.white,)),
                  ],
                ),
                SizedBox(width: 15,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(onTap: (){homeController.nave_to_home();},child: Text(App_Localization.of(context).translate("home"),style: App.textBlod(Colors.white, 16),)),
                    GestureDetector(onTap: (){homeController.nave_to_wishlist();},child: Text(App_Localization.of(context).translate("wishlist"),style: App.textBlod(Colors.white, 16),)),
                    GestureDetector(onTap: (){homeController.nave_to_setting();},child: Text(App_Localization.of(context).translate("setting"),style: App.textBlod(Colors.white, 16),)),
                    GestureDetector(onTap: (){homeController.nave_to_about_us();},child: Text(App_Localization.of(context).translate("about_us"),style: App.textBlod(Colors.white, 16),)),
                    GestureDetector(onTap: (){homeController.nave_to_logout();},child: Text(App_Localization.of(context).translate("logout"),style: App.textBlod(Colors.white, 16),)),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.25,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset("assets/icon/insta.svg"),
                    SvgPicture.asset("assets/icon/twitter.svg"),
                    SvgPicture.asset("assets/icon/facebook.svg"),
                    SvgPicture.asset("assets/icon/youtube.svg"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(App_Localization.of(context).translate("policy"),style: App.textNormal(Colors.white, 10),),
                    Text(".",style: App.textNormal(Colors.white, 10),),
                    Text(App_Localization.of(context).translate("terms_sale"),style: App.textNormal(Colors.white, 10),),
                    Text(".",style: App.textNormal(Colors.white, 10),),
                    Text(App_Localization.of(context).translate("terms"),style: App.textNormal(Colors.white, 10),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(".",style: App.textNormal(Colors.transparent, 10),),
                    Text(App_Localization.of(context).translate("return_p"),style: App.textNormal(Colors.white, 10),),
                    Text(".",style: App.textNormal(Colors.white, 10),),
                    Text(App_Localization.of(context).translate("warranty_policy"),style: App.textNormal(Colors.white, 10),),
                    Text(".",style: App.textNormal(Colors.transparent, 10),),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 0,),
        ],
      )
    );
  }

  static sucss_msg(BuildContext context,String msg){
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        message:
        msg,
      ),
    );
  }
  static error_msg(BuildContext context,String err){
    return showTopSnackBar(
      context,
      CustomSnackBar.error(
        message:
        err,
      ),
    );
  }

}