import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/constants/app_router.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';
import 'package:flutter_base_riverpod/_library/utils/screen_size.dart';
import 'package:flutter_base_riverpod/_library/widgets/app_scaffold.dart';
import 'package:flutter_base_riverpod/providers.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postsProviders).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final postRef = ref.watch(postsProviders);
    return SafeArea(
      child: AppScaffold(
        appBar: AppBar(automaticallyImplyLeading: false, actions: [
          IconButton(
            onPressed: () {
              AppRouter().router.push("/settings");
            },
            icon: const Icon(Icons.settings),
          ),
        ]),
        body: Builder(
          builder: (context) {
            switch (postRef.postsState.status) {
              case UIStateStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case UIStateStatus.idle:
                return const Center(child: CircularProgressIndicator());

              case UIStateStatus.success:
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: postRef.postsState.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final post = postRef.postsState.data![index];
                      return ListTile(
                        title: Image.network(
                          post.imageUrl ?? "",
                          width: ScreenSize().screenSize.width * .4,
                          height: ScreenSize().screenSize.height * .2,
                          fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                        ),
                        trailing: Text(post.title ?? ""),
                      );
                    },
                  ),
                );
              case UIStateStatus.error:
                return Center(
                    child: Text(postRef.postsState.failure?.errorText ?? ""));
            }
          },
        ),
      ),
    );
  }
}
