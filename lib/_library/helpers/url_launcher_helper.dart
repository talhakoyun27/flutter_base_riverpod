import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static final UrlLauncherHelper _instance = UrlLauncherHelper._init();
  UrlLauncherHelper._init();

  factory UrlLauncherHelper() {
    return _instance;
  }

  Future<void> launchLinkUrl({required String url}) async {
    Uri uri = Uri.parse(url);
    bool isCanLaunch = await canLaunchUrl(uri);
    if (isCanLaunch) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchPhone({required String phone}) async {
    Uri uri = Uri(scheme: "tel", path: "+9${phone.trim().replaceAll(" ", "")}");
    bool isCanLaunch = await canLaunchUrl(uri);
    if (isCanLaunch) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $phone';
    }
  }
}
