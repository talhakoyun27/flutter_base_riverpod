import 'package:flutter_base_riverpod/_library/helpers/injection.dart';
import 'package:flutter_base_riverpod/_library/theme/controller/theme_state.dart';
import 'package:flutter_base_riverpod/controller/posts_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsProviders =
    ChangeNotifierProvider((ref) => serviceLocator<PostsController>());

final appThemeStateNotifier = ChangeNotifierProvider((ref) => ThemeState());
