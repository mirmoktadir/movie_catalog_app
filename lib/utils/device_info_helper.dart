import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoHelper {
  static String? deviceID;
  static String? deviceName;
  static String? deviceType;
  static String? registrationID;

  static Future<void> initializeDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceID = androidInfo.id;
      deviceName = androidInfo.model;
      deviceType = 'android';
      registrationID = '';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceID = iosInfo.identifierForVendor;
      deviceName = iosInfo.name;
      deviceType = 'iOS';
      registrationID = '';
    }
  }
}
