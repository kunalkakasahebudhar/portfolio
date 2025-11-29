import 'package:url_launcher/url_launcher.dart';

Future<void> downloadCV() async {
  // On mobile, we can't easily "download" an asset to the filesystem without copying it first.
  // However, for now, we'll try to launch it, which might open it if it's a remote URL.
  // Since it's a local asset, this might fail on mobile, but the user issue is specific to web.
  // A proper mobile implementation would involve path_provider and open_file.
  final Uri url = Uri.parse('assets/resume/kunalCV.pdf');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
