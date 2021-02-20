import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum ImageOption { camera, gallery, crop, delete }

void showImageMenu(BuildContext context, Offset point) {
  final RenderBox overlay = context.findRenderObject();
  showMenu(
    context: context,
    position: RelativeRect.fromRect(
      point & const Size.square(40.0),
      Offset.zero & overlay.size,
    ),
    items: const <PopupMenuEntry<ImageOption>>[
      PopupMenuItem(
        value: ImageOption.camera,
        child: ListTile(
          leading: Icon(Icons.photo_camera_rounded),
          title: Text('Сделать фото'),
        ),
      ),
      PopupMenuItem(
        value: ImageOption.gallery,
        child: ListTile(
          leading: Icon(Icons.photo_library_rounded),
          title: Text('Выбрать из галереи'),
        ),
      ),
      PopupMenuItem(
        value: ImageOption.crop,
        enabled: false,
        child: ListTile(
          leading: Icon(Icons.crop_free_rounded),
          title: Text('Обрезать фотографию'),
        ),
      ),
      PopupMenuItem(
        value: ImageOption.delete,
        enabled: false,
        child: ListTile(
          leading: Icon(Icons.delete_rounded),
          title: Text('Удалить'),
        ),
      ),
    ],
  ).then((value) => _mapImageOptionToAction(value));
}

void _mapImageOptionToAction(ImageOption option) async {
  if (option == ImageOption.camera) {
    if (kIsWeb) {
      print('Функция не поддерживается в мобильной веб-версии.');
      return;
    }
    String path = await _pickImage(ImageSource.camera);
    await _cropImage(path);
  } else if (option == ImageOption.gallery) {
    if (kIsWeb) {
      print('Функция не поддерживается в мобильной веб-версии.');
      return;
    }
    String path = await _pickImage(ImageSource.gallery);
    await _cropImage(path);
  } else if (option == ImageOption.crop) {
    if (kIsWeb) {
      print('Функция не поддерживается в мобильной веб-версии.');
      return;
    }
    //_cropImage();
  } else if (option == ImageOption.delete) {
    _deleteCurrent();
  }
}

// config and style later
Future<void> _cropImage(String path) async {
  File croppedFile = await ImageCropper.cropImage(
    sourcePath: path,
    androidUiSettings: const AndroidUiSettings(
      toolbarTitle: 'Редактировать фото',
      toolbarColor: Colors.blue,
      toolbarWidgetColor: Colors.white,
      activeControlsWidgetColor: Colors.blue,
      //hideBottomControls: true,
    ),
    iosUiSettings: const IOSUiSettings(title: 'Редактировать фото'),
  );
}

Future<String> _pickImage(ImageSource source) async {
  final _picker = ImagePicker();
  PickedFile image = await _picker.getImage(
    source: source,
    maxHeight: 800.0,
    maxWidth: 800.0,
  );

  return image.path;
}

void _deleteCurrent() {
  print('delete');
}
