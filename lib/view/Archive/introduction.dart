import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/intro_controller.dart';
// import 'package:dayjour_version_3/view/home.dart';
// import 'package:dayjour_version_3/view/sign_in.dart';
// import 'package:dayjour_version_3/view/sign_up.dart';
import 'package:dayjour_version_3/controler/intro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Intro extends StatelessWidget {

  final IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main2,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/introduction/introduction.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Image.asset("assets/introduction/logo.png",
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

