import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_video_conference/common_methods.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/screens/waiting_screen.dart';
import 'package:test_video_conference/widgets/p_appbar.dart';
import 'package:test_video_conference/widgets/p_button.dart';
import 'package:test_video_conference/widgets/p_text.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';


class WebViewExample extends StatefulWidget {
  final String url ;
  final String name ;
  const WebViewExample({super.key, required this.url,required this.name});


  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // callPermission();
    late  PlatformWebViewControllerCreationParams params = const PlatformWebViewControllerCreationParams();
    final WebViewController controller = WebViewController.fromPlatformCreationParams(params,
      onPermissionRequest: (WebViewPermissionRequest request) {
      request.grant();
    },);
    controller..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..clearCache()
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            // WebViewCookieManager().setCookie([
            //   Cookie('name', 'value')..domain=''
            //   ..httpOnly=false
            // ])
          },
          onPageFinished: (String url) {

            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   debugPrint('blocking navigation to ${request.url}');
            //   return NavigationDecision.prevent;
            // }
            // debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },onUrlChange: (UrlChange change) {
            if(change.url!=null&&change.url!.isNotEmpty){
              List<String> searchKeywords = List<String>.generate(change.url!.length, (index) => change.url![index]);
                if(searchKeywords.last=='/'){
                  try{
                  finish(parentCOntext!);
                  }catch(e){}
                }
            }
            debugPrint('url change to ${change.url}');
          },
        ),
      )..addJavaScriptChannel('Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text(message.message)),
          // );
        },
      )..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
    _controller = controller;

    clearCache();
  }

  void clearCache() async {
    await _controller.clearCache();
    await _controller.clearLocalStorage();
    print('Cache cleared successfully!');
  }

  final FocusNode _focusNode = FocusNode();


  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      // Handle UI when the keyboard is opened
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } else {
      // Restore UI when the keyboard is closed
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  BuildContext? parentCOntext;
  @override
  Widget build(BuildContext context) {
    parentCOntext=context;
    // if(isFirstLoad) {
    //   _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
    //     if (_controller != null) {
    //       _controller.reload();
    //       isFirstLoad=false;
    //     }
    //   });
    // }
    // if(isFirstLoad){
    //   try{
    //     Future.delayed(const Duration(seconds:4),() {
    //       isFirstLoad=false;
    //       Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder:(_)=>
    //           WebViewExample(url: widget.url, name: widget.name??'')));
    //     },);
    //   }catch(e){}
    // }

    return WillPopScope(
      onWillPop:_onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar:appBar(context: context,text:"${'hello'.tr()} ${widget.name}",isCenter:true,onBack:() {
          // if(webView!=null){
          //   try{webView!.stopLoading();}catch(e){}}
          // finish(parentCOntext!);
          _onBackPressed();
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
        },),
        body: SafeArea(child: WebViewWidget(controller: _controller,)),
        // body: SafeArea(child: Webview),
      ),
    );
  }
  // Future<PermissionRequestResponse> getPermission(List<String> resources) async{
  //   var item= await (PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT));
  //   return item;
  // }

  Future<bool> _onBackPressed() async {
    return await  showDialog(
      context: parentCOntext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title:const PText(title:'Do You Want to Exit From Meeting ?',size:PSize.large,fontWeight:FontWeight.w600),
            actions: <Widget>[
              PButton(onPressed:() {
                // if(webView!=null){
                //   try{webView!.stopLoading();}catch(e){}}
                Navigator.pop(context);
                finish(parentCOntext!);
                // Navigator.pop(context);Navigator.pop(context);
              },title:'Yes',fillColor:Constants.black,textColor:Constants.white,style:PStyle.tertiary,),
              PButton(onPressed:() {
                Navigator.pop(context);
              },title:'No',fillColor:Constants.black,textColor:Constants.white,style:PStyle.tertiary,)
            ],
          ),
        );
      },
    );
  }
}

