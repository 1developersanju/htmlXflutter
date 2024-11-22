
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String?> getImagePath(File image) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String newPath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    await image.copy(newPath);
    return newPath;
  }
}
