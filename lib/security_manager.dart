import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_security_checker/flutter_security_checker.dart';
// import 'package:root_jailbreak_sniffer/rjsniffer.dart';

const platform = MethodChannel('com.example.root_check');

Future<void> checkDeviceStatus() async {
  bool rooted = false;
  try {
    //print('checkDeviceStatus1: ');
    rooted = await platform.invokeMethod('isDeviceRooted');
    //print('checkDeviceStatus1: ${rooted}');
    //  jailbroken = await platform.invokeMethod('isDeviceJailbroken');
  } on PlatformException catch (e) {
    // AppLog.logValue(
    //     'PlatformException: Error checking root/jailbreak status: ${e.message}');
  } catch (e) {
    // AppLog.logValue('Catch: Error checking root/jailbreak status: $e');
  }

  if (rooted) {
    // AppLog.logValue('Closing App: Because of : App Is Rooted');
    _closeApp();
  }
}

void checkSafeDevice() async {
  // bool jailBroken;
  // try {
  //   jailBroken = await FlutterJailbreakDetection.jailbroken;
  //
  // }on PlatformException catch(e){
  //   //debugPrint('Error checking root/jailbreak status: ${e.message}');
  //   jailBroken = false;
  // }
  // if (jailBroken) {
  //   _closeApp();
  // }
}

void isFridaRunning() async {
  if (Platform.isAndroid) {
    bool isFridaRunning = false;
    try {
      isFridaRunning = await platform.invokeMethod('checkFrida') ?? false;
    } on PlatformException catch (e) {
      // AppLog.logValue(
      //     'PlatformException: Error checking isFridaRunning status: ${e.message}');
    } catch (e) {
      // AppLog.logValue('Catch: Error checking isFridaRunning status: $e');
    }
    if (isFridaRunning) {
      // AppLog.logValue('Closing App: Because of : Frida Is Running');
      _closeApp();
    }
  }
}

void isAdbEnabled() async {
  if (Platform.isAndroid) {
    bool isAdbEnabled = false;
    try {
      isAdbEnabled = await platform.invokeMethod('isAdbEnabled') ?? false;
      // print("IsADBEnable $isAdbEnabled");
    } on PlatformException catch (e) {
      // AppLog.logValue('PlatformException: Error checking adb status: $e');
    } catch (e) {
      isAdbEnabled = false;

      // AppLog.logValue('Catch: Error checking adb status: $e');
    }
    if (isAdbEnabled == true) {
      // AppLog.logValue('Closing App: Because of : Adb Is Enabled');
      _closeApp();
    }
  }
}

void checkJailbreakSniffer() async {
  // bool amICompromised =
  //     await Rjsniffer.amICompromised() ?? false; //Detect JailBreak and Root
  // bool amIDebugged =
  //     await Rjsniffer.amIDebugged() ?? false; //Detect being Debugged
  // bool amIEmulator =
  //     await Rjsniffer.amIEmulator() ?? false; //Detect Emulator Environment
  //
  // if (amICompromised || amIDebugged || amIEmulator) {
  //   // AppLog.logValue('Closing App: Because of : JailbreakSniffer');
  //   _closeApp();
  // }
}

void checkPhysicalDevice() async {
  // final deviceInfoPlugin = DeviceInfoPlugin();
  // final BaseDeviceInfo deviceInfo = await deviceInfoPlugin.deviceInfo;
  // final allInfo = deviceInfo.data;
  // // AppLog.logValueAndTitle("Device Info", allInfo);
  // if (!(deviceInfo.data['isPhysicalDevice'] as bool)) {
  //   // AppLog.logValue('Closing App: Because of : It Is Not A Physical Device');
  //   _closeApp();
  // }
}

isRootedDevice() async {
  final bool isRooted = await FlutterSecurityChecker.isRooted;
  if (isRooted) {
    _closeApp();
  }
}

// Check whether the device on which the app is installed is a physical device.
isRealDevice() async {
  final bool isRealDevice = await FlutterSecurityChecker.isRealDevice;
  if (!isRealDevice) {
    _closeApp();
  }
}

void performDyldCheck() async {
  bool isHooked = await checkDyldHooked();
  if (isHooked) {
    _closeApp();
  }
}

Future<bool> checkDyldHooked() async {
  try {
    final bool isHooked = await platform.invokeMethod('isDyldHooked');
    return isHooked;
  } on PlatformException catch (e) {
    return false;
  }
}

void checkForFrida() async {
  bool isDetected = await isFridaDetected();
  if (isDetected) {
    _closeApp();
  }
}

void performFridaCheck() async {
  bool isFridaDetected = await checkFridaPresence();
  if (isFridaDetected) {
    _closeApp();
  }
}

Future<bool> checkFridaPresence() async {
  try {
    final bool isPresent = await platform.invokeMethod('isFridaPresent');
    return isPresent;
  } on PlatformException catch (e) {
    print("Failed to check Frida presence: '${e.message}'.");
    return false;
  }
}

Future<bool> isFridaDetected() async {
  try {
    final bool isDetected = await platform.invokeMethod('isFridaDetected');
    return isDetected;
  } on PlatformException catch (e) {
    print("Failed to detect Frida: '${e.message}'.");
    return false;
  }
}

void _closeApp() {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  }
}