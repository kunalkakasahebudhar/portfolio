import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Future<void> downloadCV() async {
  try {
    // Load the PDF from assets
    final ByteData data = await rootBundle.load(
      'assets/resume/Kunal_Udhar_Resume.pdf',
    );
    final List<int> bytes = data.buffer.asUint8List();

    // Get the downloads directory (or app documents directory)
    Directory? directory;
    if (Platform.isAndroid) {
      // For Android, try to get the downloads directory
      directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        // Fallback to app's external storage directory
        directory = await getExternalStorageDirectory();
      }
    } else if (Platform.isIOS) {
      // For iOS, use the app's documents directory
      directory = await getApplicationDocumentsDirectory();
    } else {
      // For other platforms (desktop), use downloads directory
      directory = await getDownloadsDirectory();
    }

    if (directory == null) {
      throw Exception('Could not find directory to save file');
    }

    // Create the file path
    final String filePath = '${directory.path}/Kunal_Udhar_Resume.pdf';
    final File file = File(filePath);

    // Write the file
    await file.writeAsBytes(bytes);

    // Open the file
    await OpenFile.open(filePath);
  } catch (e) {
    throw Exception('Failed to download CV: $e');
  }
}
