// ignore_for_file: must_be_immutable

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class PolicyPage extends StatelessWidget {
  String title;
  String  content;


  PolicyPage(this.title, this.content);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: AppColors.main2,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                _body(context),
              ],
            ),
          ),
        ),
      ),
    );
  }


  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.18,
      color: AppColors.main2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: 25,
                  child: IconButton(onPressed: (){
                    Get.back();
                  },
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white,size: 25,)),
                ),
                Text(
                  App_Localization.of(context).translate(title),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: 25,
                  child: IconButton(onPressed: (){

                  },
                      icon: Icon(Icons.arrow_back_ios, color: Colors.transparent,size: 25,)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return  Stack(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.main,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              )),
          child: Html(data: App_Localization.of(context).translate(content),style: content=="about_us_content"?{

            "*": Style(
                textAlign: TextAlign.center
            ),
            "p": Style(
                textAlign: TextAlign.justify
            ),
          }:{
            "table": Style(
              backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
            ),
            "p": Style(
                textAlign: TextAlign.justify
            ),
          },),
        ),
      ],
    );
  }

}




