import 'dart:html' as html;

void downloadCV() {
  // PDF is in web/resume/ folder, so path is relative to build/web/
  final url = 'resume/Kunal_Udhar_Resume.pdf';

  // Create anchor element and trigger download
  html.AnchorElement(href: url)
    ..setAttribute('download', 'Kunal_Udhar_Resume.pdf')
    ..click();
}
