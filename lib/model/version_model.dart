import 'dart:convert';

class VersionModel {
  Android? android;
  Android? ios;

  VersionModel({this.android, this.ios});

  factory VersionModel.fromMap(Map<String, dynamic> map) {
    return VersionModel(
      android: Android.fromMap(map['android']),
      ios: Android.fromMap(map['ios']),
    );
  }
  factory VersionModel.fromJson(String source) =>
      VersionModel.fromMap(json.decode(source));
}

class Android {
  bool? usable;
  String? message;
  int? version;
  String? link;

  Android({this.usable, this.message, this.version, this.link});

  factory Android.fromMap(Map<String, dynamic> map) {
    return Android(
      usable: map['usable'],
      message: map['message'],
      version: map['version'],
      link: map['link'],
    );
  }
  factory Android.fromJson(String source) =>
      Android.fromMap(json.decode(source));
}
