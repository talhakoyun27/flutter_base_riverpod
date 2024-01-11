import 'package:flutter_base_riverpod/_library/theme/controller/theme_state.dart';
import 'package:flutter_base_riverpod/controller/posts_controller.dart';
import 'package:flutter_base_riverpod/controller/version_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeStateNotifier = ChangeNotifierProvider((ref) => ThemeState());
final postProvider = ChangeNotifierProvider((ref) => PostsController());
final versionProvider = ChangeNotifierProvider((ref) => VersionController());
