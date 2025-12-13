import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

Future<Map<String, dynamic>> getDeviceInfo() async {
  final deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final android = await deviceInfoPlugin.androidInfo;
    return {
      "deviceType": "Android",
      "deviceName": android.device,
      "model": android.model,
      "brand": android.brand,
      "deviceId": android.id, // ANDROID_ID
    };
  }

  if (Platform.isIOS) {
    final ios = await deviceInfoPlugin.iosInfo;
    return {
      "deviceType": "iOS",
      "deviceName": ios.name,
      "model": ios.model,
      "brand": "Apple",
      "deviceId": ios.identifierForVendor,
    };
  }

  return {"error": "Unknown device"};
}

var deviceInfo;
Future<Map<String, dynamic>> getFullDeviceData() async {
  deviceInfo = await getDeviceInfo();

  return {
    "deviceType": deviceInfo["deviceType"],
    "deviceName": deviceInfo["deviceName"],
    "model": deviceInfo["model"],
    "brand": deviceInfo["brand"],
    "deviceId": deviceInfo["deviceId"],
  };
}

void loadDeviceData() async {
  final data = await getFullDeviceData();
  log("Device Info: $data");
}
