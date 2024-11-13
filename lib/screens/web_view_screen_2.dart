import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class WebViewExample extends StatefulWidget {
  final String url;
  final String name;
  const WebViewExample({super.key, required this.url, required this.name});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _initializeWebView();
  }

  Future<void> _requestPermissions() async {
    // Request audio and video permissions
    await [
      Permission.microphone,
      Permission.camera,
    ].request();
  }

  void _initializeWebView() {
    late final PlatformWebViewControllerCreationParams params =
        const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
      params,
      onPermissionRequest: (request) {
        request.grant();
      },
    );

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..clearCache()
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
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
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  BuildContext? parentCOntext;
  @override
  Widget build(BuildContext context) {
    parentCOntext = context;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Hello ${widget.name}"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _onBackPressed(),
          ),
        ),
        body: SafeArea(
          child: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: parentCOntext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('Do You Want to Exit From Meeting?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(parentCOntext!);
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
            ],
          ),
        );
      },
    );
  }
}
