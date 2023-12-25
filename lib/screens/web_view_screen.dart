import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:test_video_conference/common_methods.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/screens/web_v_2.dart';
import 'package:test_video_conference/widgets/p_appbar.dart';
import 'package:test_video_conference/widgets/p_button.dart';
import 'package:test_video_conference/widgets/p_text.dart';

class PublicWebViewScreen extends StatefulWidget {
  final String url ;
  final String name ;
  const PublicWebViewScreen({required this.url,required this.name});


  @override
  State<PublicWebViewScreen> createState() => PublicWebViewScreenState();
}

class PublicWebViewScreenState extends State<PublicWebViewScreen> {
  var loadingPercentage = 0;
  InAppWebViewController? webView;

  @override
  dispose() {
    // if(webView!=null){
    //   try{webView!.stopLoading();}catch(e){}}
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // Future callAgain() async {
  //   String n=widget.name??'';
  //   String u=widget.url??'';
  //   Future.delayed(const Duration(seconds:7), () {
  //     if(webView!=null){
  //       try{webView!.stopLoading();}catch(e){}}
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>
  //         PublicWebView2Screen(url:u, name:n)));
  //   });
  // }
  // Future callPermission() async {
  //   await Permission.camera.request();
  //   await Permission.microphone.request();
  //   await Permission.audio.request();
  //   showLoader();
  // }
BuildContext? parentCOntext;
  @override
  Widget build(BuildContext context) {
    parentCOntext=context;
    return WillPopScope(
      onWillPop:_onBackPressed,
      child: Scaffold(
          appBar:appBar(context: context,text:"${'hello'.tr()} ${widget.name}",isCenter:true,onBack:() {
            // if(webView!=null){
            //   try{webView!.stopLoading();}catch(e){}}
            finish(parentCOntext!);

            // Navigator.pop(context);
            // Navigator.pop(context);
            // Navigator.pop(context);
          },),
          body: InAppWebView(
            onWebViewCreated: (controller) {
              webView = controller;
              // callAgain();
            }, onLoadStop: ( controller,  url) {
            // dismissLoader();
          },initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                mediaPlaybackRequiresUserGesture: false,
                javaScriptCanOpenWindowsAutomatically:true,
                useShouldOverrideUrlLoading: true,
                javaScriptEnabled: true,
              ),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true,
                allowContentAccess: true,
                allowFileAccess: true,
                // hardwareAcceleration: true
              ),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              ),
            ),
            initialUrlRequest: URLRequest(
                url: Uri.parse(widget.url)
            ),
            onReceivedServerTrustAuthRequest: (controller, challenge) async {
              return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
            },androidOnPermissionRequest:(controller, origin, resources) {
            return getPermission(resources);
          },onProgressChanged: ( controller,  progress){
            controller.getOriginalUrl().then((value){
              // print("testtt>>"+(value?.path??''));
              if((value?.path??'').toString()=='/'){
                // if(webView!=null){
                //   try{webView!.stopLoading();}catch(e){}}
                finish(parentCOntext!);
              }
            });
            },onLoadStart:(controller, url) {
            },gestureRecognizers: Set()
            ..add(Factory<DragGestureRecognizer>(() => VerticalDragGestureRecognizer()),
            ),
          )
      ),
    );
  }
  Future<PermissionRequestResponse> getPermission(List<String> resources) async{
    var item= await (PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT));
    return item;
  }

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


// import 'package:flutter/material.dart';
// import 'package:test_video_conference/widgets/p_appbar.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
//
// class WebViewScreen extends StatefulWidget {
//   final String url;
//   WebViewScreen(this.url);
//   @override
//   _WebViewScreenState createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(resizeToAvoidBottomInset: true,
//       appBar:appBar(context: context,text:'Join a Meeting',isCenter:true),
//       body:WebViewWidget(controller: WebViewController()
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..setBackgroundColor(const Color(0x00000000))
//         ..setNavigationDelegate(
//           NavigationDelegate(
//             onProgress: (int progress) {
//               // Update loading bar.
//             },
//             onPageStarted: (String url) {},
//             onPageFinished: (String url) {},
//             onWebResourceError: (WebResourceError error) {},
//             onNavigationRequest: (NavigationRequest request) {
//               // if (request.url.startsWith('https://www.youtube.com/')) {
//               //   return NavigationDecision.prevent;
//               // }
//               return NavigationDecision.navigate;
//             },
//           ),
//         )
//         ..loadRequest(Uri.parse(widget.url))),
//     );
//   }
// }
