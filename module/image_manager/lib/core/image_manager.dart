library image_manager;

import 'package:easy_localization/easy_localization.dart';
import 'package:image_manager/_library/helpers/translation/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_manager.dart';
part 'permission_dialog.dart';
part 'image_manager_utils.dart';

///* ImageManager'da getImage fonksiyonunda alınacak resmin nereden gelmesi gerektiğini belirtmek için kullanılır.
enum _ImageLocation {
  gallery,
  camera,
}

///* Gerekli Android izni:
///     <br/>`<uses-permission android:name="android.permission.CAMERA" />`
///     <br/>`<uses-feature android:name="android.hardware.camera" />`
///
///
///  <!-- Permissions options for the `storage` group -->
///     <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
///     <!-- Read storage permission for Android 12 and lower -->
///     <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
///     <!--
///       Granular media permissions for Android 13 and newer.
///       See https://developer.android.com/about/versions/13/behavior-changes-13#granular-media-permissions
///       for more information.
///     -->
///     <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
///    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
///* Gerekli Ios izinleri:
///    <br/>`<key>NSPhotoLibraryUsageDescription</key>`
///    <br/>`<string>Please grant photo gallery access</string>`
///    <br/>`<key>NSCameraUsageDescription</key>`
///    <br/>`<string>Please grant camera access</string>`
///    <br/>`<key>NSMicrophoneUsageDescription</key>`
///    <br/>`<string>Please grant microphone access</string>`
///* Fonksiyonlarda çıkan alertDialogun tasarımı için alertDialog fieldlarına değer verebilirsiniz.
class ImageManager {
  ///* Kullanıcının galeri yada kameradan resim göndermesini sağlar.
  static Future<XFile?> getImage(
    BuildContext context, {
    String? bottomSheetGalleryName,
    String? bottomSheetCameraName,
    AlertDialog? permissionDialog,
    double maxGalleryImageSizeInMb = 10,
    String? maxGalleryFileSizeMessage,
    List<String>? galleryAcceptedImageTypes,
  }) async {
    try {
      XFile? image;
      _ImageLocation? choice = await _ImageManagerDialogs._showModalSheet(
        context,
        gallery: bottomSheetGalleryName,
        camera: bottomSheetCameraName,
      );
      switch (choice) {
        case _ImageLocation.gallery:
          if (context.mounted) {
            image = await getImageFromGallery(
              context,
              permissionDialog: permissionDialog,
              maxImageSizeInMb: maxGalleryImageSizeInMb,
              acceptedImageTypes: galleryAcceptedImageTypes,
              maxFileSizeMessage: maxGalleryFileSizeMessage,
            );
            return image;
          }
          break;
        case _ImageLocation.camera:
          if (context.mounted) {
            image = await getImageFromCamera(
              context,
              permissionDialog: permissionDialog,
            );
            return image;
          }
        case null:
          return null;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  ///* Kullanıcının fotoğraf çekmesini sağlar.
  static Future<XFile?> getImageFromCamera(
    BuildContext context, {
    AlertDialog? permissionDialog,
    Widget? loadingWidget,
  }) async {
    try {
      bool status = await _PermissionManager.requestPermission(
        Permission.camera,
        context,
        permissionDialog: permissionDialog,
      );
      if (status != true) return null;
      ImagePicker picker = ImagePicker();
      bool pushed = false;
      if (context.mounted) {
        _ImageManagerDialogs._progressDialogue(context,
            loadingWidget: loadingWidget);
        pushed = true;
      }
      XFile? photo =
          await picker.pickImage(source: ImageSource.camera).whenComplete(() {
        if (pushed) {
          Navigator.pop(context);
        }
      });

      return photo;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  ///* Galeriden fotoğraf alır `Future` olarak `null` yada `XFile` döner.
  ///
  ///* `acceptedImageTypes` boş değilse tip kontrolü yapar
  ///
  ///* Örnek `acceptedImageTypes`: ["png", "jpeg"]
  static Future<XFile?> getImageFromGallery(
    BuildContext context, {
    List<String>? acceptedImageTypes,
    AlertDialog? permissionDialog,
    String? maxFileSizeMessage,
    double maxImageSizeInMb = 10,
    Widget? loadingWidget,
    String? acceptedImageTypesMessage,
  }) async {
    try {
      Permission photoPerm = Permission.photos;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          photoPerm = Permission.storage;
        } else {
          photoPerm = Permission.photos;
        }
      }

      if (!context.mounted) return null;

      bool status = await _PermissionManager.requestPermission(
        photoPerm,
        context,
        permissionDialog: permissionDialog,
        loadingWidget: loadingWidget,
      );
      if (status != true) return null;
      ImagePicker picker = ImagePicker();
      bool pushed = false;
      if (context.mounted) {
        _ImageManagerDialogs._progressDialogue(context,
            loadingWidget: loadingWidget);
        pushed = true;
      }
      XFile? photo =
          await picker.pickImage(source: ImageSource.gallery).whenComplete(() {
        if (pushed) {
          Navigator.pop(context);
        }
      });
      bool isExceed = _Utils._isBiggerThan(photo, maxImageSizeInMb);
      if (isExceed) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                maxFileSizeMessage ??
                    "${LocaleKeys.mainText_maxImageSize.tr(context: context)} $maxImageSizeInMb",
              ),
            ),
          );
        }
        debugPrint("Resim $maxImageSizeInMb mb limitini aşıyor !!");
        return null;
      }

      if (acceptedImageTypes != null &&
          acceptedImageTypes.isNotEmpty &&
          photo != null) {
        bool result = _Utils._checkType(acceptedImageTypes, photo);
        if (context.mounted && !result) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                acceptedImageTypesMessage ??
                    "${LocaleKeys.mainText_acceptedFormats.tr(context: context)} ${acceptedImageTypes.join('-')}.",
              ),
            ),
          );
        }
        return result ? photo : null;
      }

      return photo;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  ///* Galeriden birden çok resim çeker
  ///
  ///* `acceptedImageTypes` `null` değilse tip kontrolü yapar
  ///
  ///* Örnek `acceptedImageTypes`: `["png", "jpeg"]`
  ///
  ///* `Default`: Maksimum on resim alır, resimler 10 mb'ı geçemez
  static Future<List<XFile>?> getMultiImageFromGallery(
    BuildContext context, {
    List<String>? acceptedImageTypes,
    AlertDialog? permissionDialog,
    String? maxImageMessage,
    String? maxFileSizeMessage,
    double maxImageSizeInMb = 10,
    int maxImageCount = 10,
    Widget? loadingWidget,
    String? acceptedImageTypesMessage,
  }) async {
    try {
      Permission photoPerm = Permission.photos;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          photoPerm = Permission.storage;
        } else {
          photoPerm = Permission.photos;
        }
      }

      if (!context.mounted) return null;

      bool status = await _PermissionManager.requestPermission(
        photoPerm,
        context,
        permissionDialog: permissionDialog,
        loadingWidget: loadingWidget,
      );
      if (status != true) return null;
      ImagePicker picker = ImagePicker();

      bool pushed = false;
      if (context.mounted) {
        _ImageManagerDialogs._progressDialogue(context,
            loadingWidget: loadingWidget);
        pushed = true;
      }
      List<XFile> images = await picker.pickMultiImage().whenComplete(() {
        if (pushed) {
          Navigator.pop(context);
        }
      });

      List<String> exceedImages = [];
      if (acceptedImageTypes != null &&
          acceptedImageTypes.isNotEmpty &&
          images.isNotEmpty) {
        int beforeCheck = images.length;
        images = _Utils._checkMultiType(acceptedImageTypes, images);
        int afterCheck = images.length;
        if (context.mounted && beforeCheck != afterCheck) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                acceptedImageTypesMessage ??
                    "${LocaleKeys.mainText_acceptedFormats.tr(context: context)} ${acceptedImageTypes.join('-')}.",
              ),
            ),
          );
        }
      }
      exceedImages = _Utils._checkMultiMbSize(images, maxImageSizeInMb);

      if (exceedImages.isNotEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                maxFileSizeMessage == null
                    ? "${LocaleKeys.mainText_maxImageSize.tr(context: context)} $maxImageSizeInMb. ${LocaleKeys.mainText_exceededImageCount.tr(context: context)} ${exceedImages.length}"
                    : "$maxFileSizeMessage ${exceedImages.length}",
              ),
            ),
          );
        }
        debugPrint(
            "Yüksek boyutlu resim sayısı temizlenmeden önce ----> ${images.length}");
        images.removeWhere((element) => exceedImages.contains(element.path));
        debugPrint(
            "Yüksek boyutlu resimler temizlendikten sonra ----> ${images.length}");
      }

      if (images.length > 10) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                maxImageMessage ??
                    "${LocaleKeys.mainText_acceptedImageCount.tr(context: context)} $maxImageCount ",
              ),
            ),
          );
          images = _Utils._fixImageCount(images, maxImageCount);
        }

        return images.isNotEmpty ? images : null;
      }

      return images.isNotEmpty ? images : null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  ///* Kullanıcının galeriden video seçmesini sağlar.
  static Future<XFile?> getVideoFromGallery(
    BuildContext context, {
    AlertDialog? permissionDialog,
    String? maxFileSizeMessage,
    Duration? maxDuration,
    double maxVideoSizeInMb = 10,
    Widget? loadingWidget,
  }) async {
    try {
      Permission videoPerm = Permission.videos;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          videoPerm = Permission.storage;
        } else {
          videoPerm = Permission.videos;
        }
      }

      if (!context.mounted) return null;

      bool status = await _PermissionManager.requestPermission(
        videoPerm,
        context,
        permissionDialog: permissionDialog,
        loadingWidget: loadingWidget,
      );
      if (status != true) return null;
      ImagePicker picker = ImagePicker();
      bool pushed = false;
      if (context.mounted) {
        _ImageManagerDialogs._progressDialogue(context,
            loadingWidget: loadingWidget);
        pushed = true;
      }
      XFile? video = await picker
          .pickVideo(source: ImageSource.gallery, maxDuration: maxDuration)
          .whenComplete(() {
        if (pushed) {
          Navigator.pop(context);
        }
      });

      if (video != null) {
        double sizeInMb = _Utils._checkVideoSize(video);
        if (sizeInMb > maxVideoSizeInMb) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  maxFileSizeMessage ??
                      "${LocaleKeys.mainText_maxVideoSize.tr(context: context)} $maxVideoSizeInMb .",
                ),
              ),
            );
          }
          return null;
        }
      }

      return video;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
