import 'package:flutter/material.dart';

extension FutureExtension<T> on Future<T> {
  Widget toBuild({
    required Widget Function(T? data) onSuccess,
    required Widget loadingWidget,
    required Widget notFoundWidget,
    required Widget onError,
    T? data,
  }) {
    return FutureBuilder<T>(
      future: this,
      initialData: data,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return loadingWidget;
          case ConnectionState.done:
            if (snapshot.hasData) return onSuccess(snapshot.data);
            return onError;

          case ConnectionState.none:
            return notFoundWidget;
        }
      },
    );
  }
}
