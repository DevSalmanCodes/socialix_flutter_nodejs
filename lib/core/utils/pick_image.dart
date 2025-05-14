import 'package:image_picker/image_picker.dart';

Future<String?> pickImage() async {
  final pickedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  if (pickedImage == null) return null;
  return pickedImage.path;
}
