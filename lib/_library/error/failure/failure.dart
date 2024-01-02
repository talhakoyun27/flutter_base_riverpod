import 'package:flutter_base_riverpod/_library/widgets/custom_message.dart';

abstract class Failure {
  final String? errorText;

  Failure({this.errorText});

  String get message;
}

extension FailureExtension on Failure {
  void showSnackBar() {
    showCustomMessenger(CustomMessageEnum.ERROR, message);
  }
}

//*Gerektikçe failure classları eklenecek...

class ServiceFailure extends Failure {
  ServiceFailure({String? errorText}) : super(errorText: errorText);

  @override
  String get message => errorText ?? "Service Error";
}

class NullPointerFailure extends Failure {
  NullPointerFailure({String? errorText}) : super(errorText: errorText);
  @override
  String get message => errorText ?? "Data equals null";
}
