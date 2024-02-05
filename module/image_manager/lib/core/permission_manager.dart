part of 'image_manager.dart';

class _PermissionManager {
  static Future<bool> requestPermission(
    Permission permission,
    BuildContext context, {
    AlertDialog? permissionDialog,
    Widget? loadingWidget,
  }) async {
    try {
      bool pushed = false;
      if (context.mounted) {
        _ImageManagerDialogs._progressDialogue(
          context,
          loadingWidget: loadingWidget,
        );
        pushed = true;
      }
      PermissionStatus status = await permission.request().whenComplete(() {
        if (pushed) {
          Navigator.pop(context);
        }
      });

      if (status.isPermanentlyDenied && context.mounted) {
        _ImageManagerDialogs.permissionDialogBuilder(
          context,
          permissionDialog: permissionDialog,
        );
      }

      debugPrint(status.toString());
      return status.isGranted;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
