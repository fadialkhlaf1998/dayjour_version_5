import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
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
          color: App.main2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              const Icon(Icons.wifi_off,size: 130,color: Colors.white,),
              const SizedBox(
                height: 15,
              ),
              Text(App_Localization.of(context).translate("no_net").toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25
              ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  MyApi.check_internet().then((value) {
                    if (value) {
                      Get.back();
                    }
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh,
                      color: App.main2,),
                      const SizedBox(width: 5,),
                      Center(
                          child: Text(App_Localization.of(context).translate("reaload"),
                            style: TextStyle(
                              color: App.main2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              const Spacer(),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
