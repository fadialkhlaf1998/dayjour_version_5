import 'dart:ui';
import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/settting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _SettingsState();
  SettingController settingController = Get.put(SettingController());

  String value = "English";
  List languages = [
    {
    "name":"English",
    "id":"en"},
    {
    "name":"Arabic",
    "id":"ar"}
    ];

  @override
  void initState() {
    super.initState();
  }
  
  _header() {
    return   Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/signup/signup.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 7,height: 10,),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Text(
                  App_Localization.of(context).translate("settings"),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  _body() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            App_Localization.of(context).translate("languages"),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: DropdownButton(
              iconSize: 25,
              hint:  Text(
                  Global.lang_code == "en" ?
                  App_Localization.of(context).translate("english") :
                  App_Localization.of(context).translate("arabic"),
                style: TextStyle(
                  color: Colors.black45
                ),
              ),
              onChanged: (newValue) {
                print(newValue);
                settingController.change_lang(context, newValue!.toString());
                  if(newValue=="en"){
                    value = languages[0]["name"];
                  }else{
                    value = languages[1]["name"];
                  }

              },
              items: languages.map((valueItem) {
                return DropdownMenuItem(
                  value: valueItem["id"],
                  child: Text(
                    valueItem["name"],
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

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
          color: AppColors.main,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(),
                SizedBox(height: 20,),
                _body()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
