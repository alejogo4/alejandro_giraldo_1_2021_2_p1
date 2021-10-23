import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future launchUrl({required String url}) async {
    if (await canLaunch(url)) {
      launch(url);
    }
  }
}
