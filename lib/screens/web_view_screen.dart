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
