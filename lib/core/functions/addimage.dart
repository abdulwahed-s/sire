import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<File?> uploadImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['svg', 'jpg', 'jpeg', 'png', 'gif'],
    allowMultiple: false,
  );

  if (result != null) {
    String? tempPath = result.files.single.path;
    if (tempPath != null) {
      File tempFile = File(tempPath);


      Directory appDocDir = await getApplicationDocumentsDirectory();
      String newPath = join(appDocDir.path, basename(tempPath));
      File copiedFile = await tempFile.copy(newPath);

      return copiedFile;
    }
  }

  return null;
}
