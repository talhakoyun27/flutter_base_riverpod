import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';
import 'package:flutter_base_riverpod/_library/utils/screen_size.dart';
import 'package:flutter_base_riverpod/_library/widgets/app_scaffold.dart';
import 'package:flutter_base_riverpod/controller/posts_controller.dart';
import 'package:flutter_base_riverpod/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListViewView extends ConsumerStatefulWidget {
  const ListViewView({super.key});

  @override
  ConsumerState<ListViewView> createState() => _ListViewViewState();
}

class _ListViewViewState extends ConsumerState<ListViewView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postProvider).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final postRef = ref.watch<PostsController>(postProvider);
    // postRef.fetchPosts();
    return AppScaffold(
      body: buildBody(context, postRef),
    );
  }

  Widget buildBody(BuildContext context, PostsController postRef) {
    switch (postRef.postsState.status) {
      case UIStateStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case UIStateStatus.idle:
        return const Center(child: CircularProgressIndicator());

      case UIStateStatus.success:
        return ListView.builder(
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
        );
      case UIStateStatus.error:
        return Center(child: Text(postRef.postsState.failure?.errorText ?? ""));
    }
  }
}
