import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'model/image_option.dart';

Future<ImageOption> showImageMenu(
  BuildContext context,
  bool isSet,
  Offset offset,
) async {
  final RenderBox overlay = context.findRenderObject();

  const cameraOption = PopupMenuItem(
    value: ImageOption.camera,
    child: ListTile(
      leading: Icon(Icons.photo_camera_rounded),
      title: Text('Сделать фото'),
    ),
  );

  const galleryOption = PopupMenuItem(
    value: ImageOption.gallery,
    child: ListTile(
      leading: Icon(Icons.photo_library_rounded),
      title: Text('Выбрать из галереи'),
    ),
  );

  final deleteOption = PopupMenuItem(
    value: ImageOption.delete,
    enabled: isSet,
    child: ListTile(
      leading: Icon(Icons.delete_rounded),
      title: Text('Удалить'),
    ),
  );

  final selectedOption = await showMenu(
    context: context,
    position: RelativeRect.fromRect(
      offset & const Size.square(40.0),
      Offset.zero & overlay.size,
    ),
    items: <PopupMenuEntry<ImageOption>>[
      cameraOption,
      galleryOption,
      deleteOption,
    ],
  );

  return selectedOption;
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
  );

  return image;
}

Future<File> prepareFile(ImageOption option) async {
  assert(option == ImageOption.camera || option == ImageOption.gallery);

  PickedFile pickedImage;
  if (option == ImageOption.camera) {
    pickedImage = await _pickImage(ImageSource.camera);
  } else {
    pickedImage = await _pickImage(ImageSource.gallery);
  }
  if (pickedImage == null) return null;
  final croppedImage = await _cropImage(pickedImage.path);
  if (croppedImage == null) return null;

  return croppedImage;
}
