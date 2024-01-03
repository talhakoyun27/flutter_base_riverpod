import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/constants/app_router.dart';
import 'package:flutter_base_riverpod/_library/widgets/app_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(automaticallyImplyLeading: false, actions: [
          IconButton(
            onPressed: () {
              router.push("/settings");
            },
            icon: const Icon(Icons.settings),
          ),
        ]),
        body: Center(
            child: Text(
          "Home",
          style: Theme.of(context).textTheme.bodyMedium,
        )));
  }
}
