import 'package:clean_framework/clean_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher extends ExternalDependency {
  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
