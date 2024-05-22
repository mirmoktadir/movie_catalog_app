import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../config/theme/light_theme_colors.dart';

class CustomImagePicker {
  Rx<File?> pickedImage = Rx<File?>(null);

  /// Pick Image From Gallery
  Future getImageFromGallery() async {
    var galleryImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (galleryImage != null) {
      pickedImage.value = cropImage(File(galleryImage.path));
      // pickedImage.value = File(galleryImage.path);   "If we don't want to use cropped image"
    } else {
      return;
    }
  }

  /// Pick Image From  Camera
  Future getImageFromCamera() async {
    var cameraImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (cameraImage != null) {
      //pickedImage.value = cropImage(File(galleryImage.path)); "If we want to use cropped image "
      pickedImage.value = File(cameraImage.path);
    } else {
      return;
    }
  }

  /// Crop Image
  cropImage(File croppedImage) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: croppedImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.circle,
      compressQuality: 50,
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: LightThemeColors.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      imageCache.clear();
      pickedImage.value = File(croppedFile.path);
    }
  }
}
