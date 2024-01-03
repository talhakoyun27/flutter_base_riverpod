import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/error/data/manager/exception_logger_manager.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

@immutable
final class GlobalKeyManager {
  const GlobalKeyManager._();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}

@immutable
final class GlobalContextKey {
  final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  static GlobalContextKey instance = GlobalContextKey._init();
  GlobalContextKey._init();
}

@immutable
final class MaskFormatterHelper {
  static MaskedInputFormatter phoneMaskForTextField =
      MaskedInputFormatter('0(###)### ## ##');
  static MaskedInputFormatter turkeyPhoneMaskForTextField =
      MaskedInputFormatter('+90(###) ### ## ##');
  static MaskedInputFormatter dateMask = MaskedInputFormatter('##/##/####');
}

class UIState<T> {
  late UIStateStatus status;
  T? data;
  Failure? failure;
  UIState.idle() : status = UIStateStatus.idle;
  UIState.loading() : status = UIStateStatus.loading;
  UIState.success(this.data) : status = UIStateStatus.success;
  UIState.error(this.failure,
      {StackTrace? stackTrace, bool logException = true}) {
    status = UIStateStatus.error;

    if (logException) {
      ExceptionLoggerManager()
          .captureException(failure, stackTrace: stackTrace);
    }
  }

  bool get isIdle => status == UIStateStatus.idle;
  bool get isLoading => status == UIStateStatus.loading;
  bool get isSuccess => status == UIStateStatus.success;
  bool get isError => status == UIStateStatus.error;
}

enum UIStateStatus { idle, loading, success, error }
