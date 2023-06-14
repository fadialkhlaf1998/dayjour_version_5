import 'dart:io';
import 'dart:math';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/view/welcome.dart';
import 'package:dayjour_version_3/view/introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

void main() {

  TabbySDK().setup(
    withApiKey: 'pk_test_1e0e3651-1f8b-4a0e-8458-0f43711280f5',
    environment: Environment.production,
  );

  runApp(MyApp());
}
//final final 2.0.0
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  static void set_locale(BuildContext context , Locale locale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.set_locale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;
  void set_locale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }

  ///Facebook
  // String _deepLinkUrl = 'Unknown';
  // FlutterFacebookSdk? facebookDeepLinks;
  // bool isAdvertisingTrackingEnabled = true;
  //
  // Future<void> initPlatformState() async {
  //   String? deepLinkUrl;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     facebookDeepLinks = FlutterFacebookSdk();
  //     facebookDeepLinks!.onDeepLinkReceived!.listen((event) {
  //       setState(() {
  //         _deepLinkUrl = event;
  //       });
  //     });
  //     deepLinkUrl = await facebookDeepLinks!.getDeepLinkUrl;
  //     setState(() {
  //       _deepLinkUrl = deepLinkUrl!;
  //     });
  //   } on PlatformException {}
  //   if (!mounted) return;
  // }


  @override
  void initState() {
    super.initState();
    // initPlatformState();
    Global.load_language().then((language) {
      setState(() {
        _locale= Locale(language);
        Get.updateLocale(Locale(language));
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: generateMaterialColor(App.main2),
          fontFamily: "NunitoSans"
        ),
        locale: _locale,
        supportedLocales: [Locale('en', ''), Locale('ar', '')],
        localizationsDelegates: [
          App_Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (local, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == local!.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: Intro()
    );
  }

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));


}
