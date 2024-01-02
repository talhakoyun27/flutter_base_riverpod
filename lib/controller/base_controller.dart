import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/debouncer.dart';

class BaseController with ChangeNotifier {
  BaseController() {
    init();
  }

  void init() {}
  //dispose kısaltması
  void disp() {}

  bool isLoading = false;

  final debouncer = Debouncer(milliseconds: 1000);

  updateLoadingState(bool state) {
    isLoading = state;
    refreshView();
  }

  void refreshView() {
    notifyListeners();
  }
}
