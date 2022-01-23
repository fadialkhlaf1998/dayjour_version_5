import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/sign_up_controller.dart';
import 'package:dayjour_version_3/controler/verification_code_controller.dart';
import 'package:dayjour_version_3/view/welcome.dart';
import 'package:dayjour_version_3/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class RecoveryCode extends StatefulWidget {
  const RecoveryCode({Key? key}) : super(key: key);

  @override
  _RecoveryCodeState createState() => _RecoveryCodeState();
}

class _RecoveryCodeState extends State<RecoveryCode> {

  final code = TextEditingController();
  VerificationCodeController verificationCodeController = Get.put(VerificationCodeController());

  @override
  void initState() {
    super.initState();
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
              setState(() {
               Get.off(SignUp());
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 20),
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
            height: MediaQuery.of(context).size.height * 0.15,
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
                            App_Localization.of(context).translate("enter_the_code"),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
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
      ],
    );
  }
  _body() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.17,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.number,

                    controller: code,
                    cursorColor: AppColors.main2,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      errorText:
                      !verificationCodeController.code_vaildate.value ? App_Localization.of(context).translate("code_is_required") : null,
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.red)),
                      hintText:  App_Localization.of(context).translate("enter_the_code"),
                      contentPadding: EdgeInsets.only(top: 2),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: SvgPicture.asset(
                            'assets/icons/G -.svg'),
                      ),
                      prefixStyle: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {

                      });
                      verificationCodeController.resend(context);
                      },
                    child: Text(
                      App_Localization.of(context).translate("send_again"),
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  _submit() {
    return Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: FloatingActionButton.extended(
            backgroundColor: AppColors.main2,
            onPressed: () {
              setState(() {

              });
              verificationCodeController.verificate(context, code.text);
            },
            label: Text(
              App_Localization.of(context).translate("submit"),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        );
  }
  _cancel() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: FloatingActionButton.extended(
        backgroundColor: AppColors.main2,
        onPressed: () {
          Get.offAll(()=>Welcome());
        },
        label: Text(
          App_Localization.of(context).translate("cancel"),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15),
        ),
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
      backgroundColor: AppColors.main,
      body: SafeArea(
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
                    const SizedBox(height: 30),
                    _submit(),
                    SizedBox(height: 15),
                    _cancel(),
                  ],
                ),
              ),
            ),
           Obx((){
             return  Positioned(
               child: verificationCodeController.loading.value?Container(
                 width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height,
                 color: AppColors.main.withOpacity(0.6),
                 child: Center(
                   child: CircularProgressIndicator(color: App.main2,),
                 ),
               ):Center(),);
           })
          ],
        ),
      ),
    );
  }
}
