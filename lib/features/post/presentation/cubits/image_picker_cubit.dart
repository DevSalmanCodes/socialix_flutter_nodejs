import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/core/utils/pick_image.dart';

class ImagePickerCubit extends Cubit<File?> {
  ImagePickerCubit() : super(null);

  Future<void> pickImageFromGallery() async {
    final res = await pickImage();
    if (res != null && res.isNotEmpty) {
      emit(File(res));
    }
  }
}
