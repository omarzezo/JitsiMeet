import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:test_video_conference/common_methods.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/widgets/p_appbar.dart';
import 'package:test_video_conference/widgets/p_button.dart';
import 'package:test_video_conference/widgets/p_text.dart';

class PublicWebView2Screen extends StatefulWidget {
  final String url ;
  final String name ;
  const PublicWebView2Screen({required this.url,required this.name});


  @override
  State<PublicWebView2Screen> createState() => PublicWebView2ScreenState();
}

class PublicWebView2ScreenState extends State<PublicWebView2Screen> {
  var loadingPercentage = 0;
  InAppWebViewController? webView;

  @override
  dispose() {
    if(webView!=null){
      try{webView!.stopLoading();}catch(e){}}
    super.dispose();
  }


  BuildContext? parentCOntext;
  @override
  Widget build(BuildContext context) {
    parentCOntext=context;
    return WillPopScope(
      onWillPop:_onBackPressed,
      child: Scaffold(
          appBar:appBar(context: context,text:"Hello ${widget.name}",isCenter:true,onBack:() {
           if(webView!=null){
             try{webView!.stopLoading();}catch(e){}}
              finish(parentCOntext!);
            // Navigator.pop(context);
            // Navigator.pop(context);
            // Navigator.pop(context);
          },),
          body: InAppWebView(
            onWebViewCreated: (controller) {
              webView = controller;
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
              print("testtt>>"+(value?.path??''));
              if((value?.path??'').toString()=='/'){
                if(webView!=null){
                  try{webView!.stopLoading();}catch(e){}}
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
                if(webView!=null){
                  try{webView!.stopLoading();}catch(e){}}
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


