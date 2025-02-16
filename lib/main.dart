import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
// import 'package:no_screenshot/no_screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_video_conference/cache_helper.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/injections.dart';
import 'package:test_video_conference/screens/home_screen.dart';
import 'package:test_video_conference/screens/otp_screen.dart';
import 'package:test_video_conference/screens/send_mobile_screen.dart';
import 'package:test_video_conference/security_manager.dart';
// import 'package:uni_links/uni_links.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

bool _initialUriIsHandled = false;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  configLoading();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  // checkDeviceStatus();
  // checkSafeDevice();
  // isAdbEnabled();
  // isFridaRunning();
  // isRootedDevice();
  // isRealDevice();
  // checkJailbreakSniffer();
  // checkPhysicalDevice();
  // performDyldCheck();
  // checkForFrida();
  // performFridaCheck();
  await Permission.camera.request();
  await Permission.microphone.request();
  Injections().setupDependencyInjection();
  GetIt.I.isReady<SharedPreferences>().then((_) {
    runApp(EasyLocalization(supportedLocales: const [Locale('ar'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child:MyApp()));
  });
  // runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;

  StreamSubscription? _sub;

  final _scaffoldKey = GlobalKey();
  final _cmds = getCmds();
  final _cmdStyle = const TextStyle(fontFamily: 'Courier', fontSize: 12.0, fontWeight: FontWeight.w700);

  @override
  void initState() {
    super.initState();
    // enableSecureMode();
    // _handleIncomingLinks();
    // _handleInitialUri();
  }
  Future<void> enableSecureMode() async {
    // await disableScreenshot();
    await ScreenProtector.protectDataLeakageOn();
    await ScreenProtector.preventScreenshotOn();
  }
  // Future<void> disableScreenshot() async {
  //   final noScreenshot = NoScreenshot.instance;
  //   bool result = await noScreenshot.screenshotOff();
  //   debugPrint('Screenshot Off: $result');
  // }
  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.
  // void _handleIncomingLinks() {
  //   if (!kIsWeb) {
  //     // It will handle app links while the app is already started - be it in
  //     // the foreground or in the background.
  //     _sub = uriLinkStream.listen((Uri? uri) {
  //       if (!mounted) return;
  //       print('got uri: $uri');
  //       setState(() {
  //         _latestUri = uri;
  //         // SchedulerBinding.instance.addPostFrameCallback((_) {
  //         //   Navigator.of(context)
  //         //       .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
  //         //     return OtpScreen();
  //         //   }));
  //         context.push('/pjoin/eHZUeHJRVTd5LytNR2NUU3VWZm1qZz09');
  //           // Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>OtpScreen()));
  //         // });
  //
  //         _err = null;
  //       });
  //     }, onError: (Object err) {
  //       if (!mounted) return;
  //       print('got err: $err');
  //       setState(() {
  //         _latestUri = null;
  //         if (err is FormatException) {
  //           _err = err;
  //         } else {
  //           _err = null;
  //         }
  //       });
  //     });
  //   }
  // }

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  /// We handle all exceptions, since it is called from initState.
  // Future<void> _handleInitialUri() async {
  //   // In this example app this is an almost useless guard, but it is here to
  //   // show we are not going to call getInitialUri multiple times, even if this
  //   // was a weidget that will be disposed of (ex. a navigation route change).
  //   if (!_initialUriIsHandled) {
  //     _initialUriIsHandled = true;
  //     try {
  //       final uri = await getInitialUri();
  //       if (uri == null) {
  //         print('no initial uri');
  //       } else {
  //         print('got initial uri: $uri');
  //         context.go('/pjoin/eHZUeHJRVTd5LytNR2NUU3VWZm1qZz09');
  //       }
  //       if (!mounted) return;
  //       setState(() => _initialUri = uri);
  //     } on PlatformException {
  //       // Platform messages may fail but we ignore the exception
  //       print('falied to get initial uri');
  //     } on FormatException catch (err) {
  //       if (!mounted) return;
  //       print('malformed initial uri');
  //       setState(() => _err = err);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final queryParams = _latestUri?.queryParametersAll.entries.toList();
    return MaterialApp.router(
      builder:EasyLoading.init(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'برهان',
      routerConfig: GoRouter(errorBuilder:(context, state) {
        print("state>"+state.uri.toString());
        print("state>"+state.uri.path.toString());
        print("state>"+state.pathParameters['id'].toString());
        return SizedBox();
      },routes: [
        GoRoute(
          path: "/",
          builder: (context, state) =>  HomeScreen(),
          routes:[
            GoRoute(
              path: "pjoin/:id",
              builder:(context, state) {
                return OtpScreen(id:state.pathParameters['id']??'',mobileNumber:'',meetingId:'',);
              },
            ),
            GoRoute(
              path: "meet",
              builder:(context, state) {
                print("state>"+state.uri.queryParameters['m'].toString());
                return SendMobileScreen(meetingId:state.uri.queryParameters['m']??'');
              },
            ),
            GoRoute(
              path: "join/:id",
              builder:(context, state) {
                return SendMobileScreen(meetingId:state.pathParameters['id']??'');
              },
            ),
          ],
        ),
      ]),
    );
    // return MaterialApp(
    //   builder:EasyLoading.init(),
    //   localizationsDelegates: context.localizationDelegates,
    //   supportedLocales: context.supportedLocales,
    //   locale: context.locale,
    //   debugShowCheckedModeBanner: false,
    //   title: 'برهان',
    //   home: Scaffold(
    //     key: _scaffoldKey,
    //     appBar: AppBar(
    //       title: const Text('uni_links example app'),
    //     ),
    //     body: ListView(
    //       shrinkWrap: true,
    //       padding: const EdgeInsets.all(8.0),
    //       children: [
    //         if (_err != null)
    //           ListTile(
    //             title: const Text('Error', style: TextStyle(color: Colors.red)),
    //             subtitle: Text('$_err'),
    //           ),
    //         ListTile(
    //           title: const Text('Initial Uri'),
    //           subtitle: Text('$_initialUri'),
    //         ),
    //         if (!kIsWeb) ...[
    //           ListTile(
    //             title: const Text('Latest Uri'),
    //             subtitle: Text('$_latestUri'),
    //           ),
    //           ListTile(
    //             title: const Text('Latest Uri (path)'),
    //             subtitle: Text('${_latestUri?.path}'),
    //           ),
    //           ExpansionTile(
    //             initiallyExpanded: true,
    //             title: const Text('Latest Uri (query parameters)'),
    //             children: queryParams == null
    //                 ? const [ListTile(dense: true, title: Text('null'))]
    //                 : [
    //               for (final item in queryParams)
    //                 ListTile(
    //                   title: Text(item.key),
    //                   trailing: Text(item.value.join(', ')),
    //                 )
    //             ],
    //           ),
    //         ],
    //         _cmdsCard(_cmds),
    //         const Divider(),
    //       ],
    //     ),
    //   ),
    // );
  }


  Future<void> _printAndCopy(String cmd) async {
    print(cmd);

    await Clipboard.setData(ClipboardData(text: cmd));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to Clipboard')),
    );
  }

  void _showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _scaffoldKey.currentContext;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
        ));
      }
    });
  }
}

List<String>? getCmds() {
  late final String cmd;
  var cmdSuffix = '';

  const plainPath = 'path/subpath';
  const args = 'path/portion/?uid=123&token=abc';
  const emojiArgs =
      '?arr%5b%5d=123&arr%5b%5d=abc&addr=1%20Nowhere%20Rd&addr=Rand%20City%F0%9F%98%82';

  if (kIsWeb) {
    return [
      plainPath,
      args,
      emojiArgs,
      // Cannot create malformed url, since the browser will ensure it is valid
    ];
  }

  if (Platform.isIOS) {
    cmd = '/usr/bin/xcrun simctl openurl booted';
  } else if (Platform.isAndroid) {
    cmd = '\$ANDROID_HOME/platform-tools/adb shell \'am start'
        ' -a android.intent.action.VIEW'
        ' -c android.intent.category.BROWSABLE -d';
    cmdSuffix = "'";
  } else {
    return null;
  }

  // https://orchid-forgery.glitch.me/mobile/redirect/
  return [
    // '$cmd "https://blog.logrocket.com',
    '$cmd "unilinks://host/$plainPath"$cmdSuffix',
    '$cmd "unilinks://example.com/$args"$cmdSuffix',
    '$cmd "unilinks://example.com/$emojiArgs"$cmdSuffix',
    '$cmd "unilinks://@@malformed.invalid.url/path?"$cmdSuffix',
  ];
}

List<Widget> intersperse(Iterable<Widget> list, Widget item) {
  final initialValue = <Widget>[];
  return list.fold(initialValue, (all, el) {
    if (all.isNotEmpty) all.add(item);
    all.add(el);
    return all;
  });
}


Future<void> configLoading() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 500)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 38.0
    ..radius = 0.0
    ..progressWidth=0.2
    ..progressColor = Constants.yellow
    ..backgroundColor = Colors.transparent
    ..boxShadow = <BoxShadow>[]
    ..maskType=EasyLoadingMaskType.clear
    ..indicatorColor = Constants.yellow
    ..textColor = Colors.white
    ..maskColor = Colors.grey[100]
    ..userInteractions = true
    ..dismissOnTap = false;
}





































// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get_it/get_it.dart';
// // import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
// // import 'package:jitsi_meeting_plus/jitsi_meet_plus.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:test_video_conference/cache_helper.dart';
// import 'package:test_video_conference/constants.dart';
// import 'package:test_video_conference/injections.dart';
// import 'package:test_video_conference/screens/home_screen.dart';
// import 'package:test_video_conference/widgets/p_button.dart';
// // import 'package:uqudosdk_flutter/UqudoIdPlugin.dart';
//
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }
// Future<void> main() async {
//   HttpOverrides.global = MyHttpOverrides();
//   configLoading();
//   WidgetsFlutterBinding.ensureInitialized();
//   await CacheHelper.init();
//   // UqudoIdPlugin.init();
//   // UqudoIdPlugin.setLocale('en');
//   await EasyLocalization.ensureInitialized();
//   Injections().setupDependencyInjection();
//   GetIt.I.isReady<SharedPreferences>().then((_) {
//     runApp(EasyLocalization(supportedLocales: const [Locale('ar'), Locale('en')],
//       path: 'assets/translations',
//       fallbackLocale: const Locale('en'),
//       child:  MyApp(),));
//   });
//   // runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Meeting());
//   }
// }
//
// class Meeting extends StatefulWidget {
//   @override
//   _MeetingState createState() => _MeetingState();
// }
//
// class _MeetingState extends State<Meeting> {
//   final  roomIdController = TextEditingController();
//   final  nameController = TextEditingController();
//   final  phoneController = TextEditingController();
//   final  otpController = TextEditingController();
//   bool isAudioMuted = false;
//   bool isAudioOnly = false;
//   bool isVideoMuted = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       home:HomeScreen(),
//       builder:EasyLoading.init(),
//       localizationsDelegates: context.localizationDelegates,
//       supportedLocales: context.supportedLocales,
//       locale: context.locale,
//       debugShowCheckedModeBanner: false,
//       title: 'برهان',
//     );
//   }
//
// }
//
//
// Future<void> configLoading() async {
//   EasyLoading.instance
//     ..displayDuration = const Duration(milliseconds: 500)
//     ..indicatorType = EasyLoadingIndicatorType.circle
//     ..loadingStyle = EasyLoadingStyle.custom
//     ..indicatorSize = 38.0
//     ..radius = 0.0
//     ..progressWidth=0.2
//     ..progressColor = Constants.yellow
//     ..backgroundColor = Colors.transparent
//     ..boxShadow = <BoxShadow>[]
//     ..maskType=EasyLoadingMaskType.clear
//     ..indicatorColor = Constants.yellow
//     ..textColor = Colors.white
//     ..maskColor = Colors.grey[100]
//     ..userInteractions = true
//     ..dismissOnTap = false;
// }