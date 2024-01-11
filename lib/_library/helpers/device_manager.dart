// ignore_for_file: prefer_constructors_over_static_methods

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_base_riverpod/_library/extensions/string_extension.dart';

/// Cihaz ie ilgili işlemleri yapar.
// class DeviceManager {
//   DeviceManager._init();

//   // static DeviceManager? _instance;

//   // /// Returns the singleton instance of [DeviceManager].
//   // static DeviceManager get instance {
//   //   _instance ??= DeviceManager._init();
//   //   return _instance!;
//   // }

//   PackageInfo? packageInfo;
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

//   late IosDeviceInfo info;

//   /// The padding bottom area for iPad devices.
//   final Rect ipadPaddingBottom = const Rect.fromLTWH(30, 50, 30, 50);

//   /// Checks if the current device is an iPad.
//   Future<bool> isIpad() async {
//     info = await deviceInfo.iosInfo;
//     return (info.name).toLowerCase().contains('ipad');
//   }

//   /// mailto bağlantısı oluşturur. verilen başlık ve içerik ile.
//   String shareMailText(String title, String body) =>
//       "mailto:?subject='$title'&body=$body ";

//   /// paket bilgilerini başlatır.
//   Future<void> initPackageInfo() async {
//     packageInfo = await PackageInfo.fromPlatform();
//   }

//   /// Cihazın, cihaz bilgilerini döndürür.
//   Future<String> getUniqueDeviceId() async {
//     if (Platform.isIOS) {
//       final iosDeviceInfo = await deviceInfo.iosInfo;
//       return iosDeviceInfo.identifierForVendor ?? '';
//     } else if (Platform.isAndroid) {
//       final androidDeviceInfo = await deviceInfo.androidInfo;
//       return androidDeviceInfo.id;
//     } else {
//       throw Exception('That platform is not supported.');
//     }
//   }
// }
class DeviceManager {
  PackageInfo packageInfo;
  AndroidDeviceInfo? _androidDeviceInfo;
  IosDeviceInfo? _iosDeviceInfo;

  DeviceManager._android(
    this._androidDeviceInfo, {
    required this.packageInfo,
  });

  DeviceManager._iOS(this._iosDeviceInfo, {required this.packageInfo});

  static Future<DeviceManager> createDeviceInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo =
          await DeviceInfoPlugin().androidInfo;

      return DeviceManager._android(androidDeviceInfo,
          packageInfo: packageInfo);
    } else {
      IosDeviceInfo iosDeviceInfo = await DeviceInfoPlugin().iosInfo;

      return DeviceManager._iOS(iosDeviceInfo, packageInfo: packageInfo);
    }
  }

  String get deviceId => (Platform.isAndroid
          ? _androidDeviceInfo?.id
          : _iosDeviceInfo?.identifierForVendor)!
      .getValueOrDefault;

  String get appVersion => packageInfo.version;

  bool get isPhysicalDevice =>
      (Platform.isAndroid
          ? _androidDeviceInfo?.isPhysicalDevice
          : _iosDeviceInfo?.isPhysicalDevice) ??
      false;

  bool get isAndroid => Platform.isAndroid;
  bool get isIos => Platform.isIOS;
}
