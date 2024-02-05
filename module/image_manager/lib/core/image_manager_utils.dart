part of 'image_manager.dart';

class _Utils {
  static List<XFile> _fixImageCount(List<XFile> result, int maxImageCount) {
    if (maxImageCount < result.length && maxImageCount > 0) {
      result = result.sublist(0, maxImageCount);
    }

    return result;
  }

  static bool _isBiggerThan(XFile? photo, double mbSize) {
    try {
      if (photo != null) {
        File x = File(photo.path);
        int sizeInBytes = x.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);

        debugPrint("Image size ---> $sizeInMb mb");
        if (sizeInMb > mbSize) {
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static bool _checkType(List<String> types, XFile photo) {
    try {
      String? mimeStr = lookupMimeType(photo.path);
      if (mimeStr != null) {
        List<String> fileType = mimeStr.split('/');
        debugPrint('File type -------> $fileType');
        if (types.contains(fileType.last)) {
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static List<XFile> _checkMultiType(List<String> types, List<XFile> photos) {
    List<XFile> acceptedImages = [];

    try {
      for (var element in photos) {
        String? mimeStr = lookupMimeType(element.path);
        if (mimeStr != null) {
          List<String> fileType = mimeStr.split('/');
          debugPrint('File type -------> $fileType');
          if (types.contains(fileType.last)) {
            acceptedImages.add(element);
          }
        }
      }
      return acceptedImages;
    } catch (e) {
      debugPrint(e.toString());
      return acceptedImages;
    }
  }

  static double _checkVideoSize(XFile video) {
    File x = File(video.path);
    int sizeInBytes = x.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    debugPrint("Video size -----> $sizeInMb mb");
    return sizeInMb;
  }

  static List<String> _checkMultiMbSize(List<XFile> result, double max) {
    List<String> exceedImages = [];
    for (var element in result) {
      File x = File(element.path);
      int sizeInBytes = x.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);

      debugPrint("Image size ---> $sizeInMb mb");
      if (sizeInMb > max) {
        exceedImages.add(x.path);
      }
    }
    return exceedImages;
  }
}
