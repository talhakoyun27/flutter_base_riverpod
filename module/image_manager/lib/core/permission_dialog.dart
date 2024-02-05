part of 'image_manager.dart';

class _ImageManagerDialogs {
  static Future<void> permissionDialogBuilder(
    BuildContext context, {
    AlertDialog? permissionDialog,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return permissionDialog ??
            AlertDialog(
              title: const Text('İzin Gerekiyor'),
              content: const Text(
                'Bu eylem için izin vermelisiniz ...',
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Kapat'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('İzin Ver'),
                  onPressed: () async {
                    await openAppSettings();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
      },
    );
  }

  static void _progressDialogue(BuildContext context, {Widget? loadingWidget}) {
    //set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: loadingWidget ??
          SizedBox(
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(onWillPop: () async => false, child: alert);
      },
    );
  }

  static Future<_ImageLocation?> _showModalSheet(
    BuildContext context, {
    String? gallery,
    String? camera,
  }) async {
    _ImageLocation? result;
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: Text(gallery ?? 'Galeri'),
                  onTap: () {
                    result = _ImageLocation.gallery;
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text(camera ?? 'Kamera'),
                  onTap: () {
                    result = _ImageLocation.camera;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }).whenComplete(() => result);
    return result;
  }
}
