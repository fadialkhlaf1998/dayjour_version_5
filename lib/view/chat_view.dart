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
  WebViewController? controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(
          Uri.parse('https://tawk.to/chat/6117c35cd6e7610a49b02c5b/1fd2d68fb'));
    setState(() {
      loading = false;
    });
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
        title: Text(
          App_Localization.of(context).translate("l_c_title"),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: App.main2,
        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),
        ],
      ),
      //todo uncomment
      body: SafeArea(
        child: Center(
          child: loading
              ? CircularProgressIndicator()
              : WebViewWidget(controller: controller!),
          // child: WebView(
          //   initialUrl: "https://tawk.to/chat/6117c35cd6e7610a49b02c5b/1fd2d68fb",
          //   // initialUrl: "https://community.shopify.com/c/shopify-apis-and-sdks/bd-p/shopify-apis-and-technology",
          //   javascriptMode: JavascriptMode.unrestricted,
          // ),
        ),
      ),
    );
  }
}
