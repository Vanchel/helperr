import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'image_option.dart';
import 'image_type.dart';
import '../../data_layer/data_provider/firebase_server.dart' as fb_server;

Future<void> mapImageOption(
  ImageOption option,
  int userId,
  ImageType type,
  VoidCallback onChanged,
) async {
  Future<void> handleFile(PickedFile file) async {
    if (file == null) return;
    final croppedFile = await _cropImage(file.path);
    if (croppedFile == null) return;

    if (type == ImageType.avatar) {
      await fb_server.updateProfileAvatarImage(userId, croppedFile.path);
    } else if (type == ImageType.background) {
      await fb_server.updateProfileBackgroundImage(userId, croppedFile.path);
    }
  }

  try {
    if (option == ImageOption.camera) {
      final pickedImage = await _pickImage(ImageSource.camera);
      await handleFile(pickedImage);
    } else if (option == ImageOption.gallery) {
      final pickedImage = await _pickImage(ImageSource.gallery);
      await handleFile(pickedImage);
    } else if (option == ImageOption.delete) {
      if (type == ImageType.avatar) {
        await fb_server.deleteProfileAvatarImage(userId);
      } else if (type == ImageType.background) {
        await fb_server.deleteProfileBackgroundImage(userId);
      } else {
        return;
      }
    }
  } catch (e) {
    print(e);
    return;
  }
  if (onChanged != null) {
    onChanged();
  }
}

Future<File> _cropImage(String path) async {
  File croppedFile = await ImageCropper.cropImage(
    sourcePath: path,
    androidUiSettings: const AndroidUiSettings(
      toolbarTitle: 'Редактировать фото',
      toolbarColor: Colors.blue,
      toolbarWidgetColor: Colors.white,
      activeControlsWidgetColor: Colors.blue,
    ),
    iosUiSettings: const IOSUiSettings(title: 'Редактировать фото'),
  );

  return croppedFile;
}

Future<PickedFile> _pickImage(ImageSource source) async {
  final _picker = ImagePicker();
  PickedFile image = await _picker.getImage(
    source: source,
    maxHeight: 650,
    maxWidth: 650,
    imageQuality: 40,
  );

  return image;
}
