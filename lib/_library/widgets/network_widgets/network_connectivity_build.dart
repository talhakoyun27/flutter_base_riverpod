import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/widgets/network_widgets/no_network_widget.dart';

class NetworkConnectivityBuild {
  NetworkConnectivityBuild._();
  static Widget build(BuildContext context, Widget? child) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: child ?? const SizedBox(),
          ),
          const NoNetworkWidget()
        ],
      ),
    );
  }
}
