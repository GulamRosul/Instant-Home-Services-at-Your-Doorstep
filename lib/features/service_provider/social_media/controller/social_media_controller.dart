import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaController extends GetxController {
  final String facebookUrl = "http://www.facebook.com/kaajbd";
  final String twitterUrl = "https://twitter.com/kaajbd";
  final String youtubeUrl = "https://www.youtube.com/@kaajbdofficial";
  final String instagramUrl = "http://www.instagram.com/kaajbdofficial";

  Future<void> launchSocialUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not launch $url");
    }
  }
}
