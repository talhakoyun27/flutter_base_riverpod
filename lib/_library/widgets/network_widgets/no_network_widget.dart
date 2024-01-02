import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/connectivity_management.dart';
import 'package:flutter_base_riverpod/_library/widgets/null_page_view.dart';

class NoNetworkWidget extends StatefulWidget {
  const NoNetworkWidget({super.key});

  @override
  State<NoNetworkWidget> createState() => _NoNetworkWidgetState();
}

class _NoNetworkWidgetState extends State<NoNetworkWidget> with StateMixin {
  late final INetworkChangeManager _networkChange;
  NetworkResult? _networkResult;
  @override
  void initState() {
    super.initState();
    _networkChange = NetworkChangeManager();

    waitForScreen(() {
      _networkChange.handleNetworkChange((result) {
        _updateView(result);
      });
    });
  }

  Future<void> fetchFirstResult() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await _networkChange.checkNetworkFirstTime();
      _updateView(result);
    });
  }

  void _updateView(NetworkResult result) {
    setState(() {
      _networkResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async => false,
      child: _networkResult == NetworkResult.off
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: nullPageView(
                  context,
                  "ImageConstants.instance.error", // burası değişecek
                  "Bir şeyler yanlış gitti",
                  "İnternet bağlantınızı kontrol ediniz."),
            )
          : const SizedBox(),
    );
  }
}

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void waitForScreen(VoidCallback onComplete) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onComplete.call();
    });
  }
}
