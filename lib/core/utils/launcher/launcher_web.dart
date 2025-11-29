import 'dart:html' as html;

void downloadCV() {
  final anchor = html.AnchorElement(href: 'assets/resume/kunalCV.pdf')
    ..target = 'blank'
    ..download = 'Kunal_Udhar_CV.pdf';

  html.document.body?.children.add(anchor);
  anchor.click();
  html.document.body?.children.remove(anchor);
}
