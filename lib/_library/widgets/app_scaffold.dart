import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final Drawer? drawer;
  final bool resizeToAvoidBottomInset;

  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AppScaffold({
    Key? key,
    this.appBar,
    this.backgroundColor,
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = false,
    this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScaffoldMessenger(
        key: GlobalKeyManager.scaffoldMessengerKey,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: appBar,
          body: body,
          drawer: drawer,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation ??
              FloatingActionButtonLocation.miniCenterFloat,
          bottomSheet: bottomSheet,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        ),
      ),
    );
  }
}
