import 'dart:io';

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("l_c_title"),),
        backgroundColor: App.main2,
        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: WebView(
            initialUrl: "https://tawk.to/chat/61e3bbedb84f7301d32b3e85/1fpgpc6d4",
            // initialUrl: "https://community.shopify.com/c/shopify-apis-and-sdks/bd-p/shopify-apis-and-technology",
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}

