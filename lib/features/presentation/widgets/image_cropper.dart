import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';


class AppImageCropper {
  Future<CroppedFile?> getCroppedImage(PickedFile file,BuildContext context) async {
    return ImageCropper().cropImage(
      compressQuality: 70,
      sourcePath: file.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor:  colors(context).primaryColor,
            toolbarWidgetColor: colors(context).whiteColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );
  }
}
