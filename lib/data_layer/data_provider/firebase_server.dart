import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> getAvatarUrl(int userId) async {
  final ref = FirebaseStorage.instance.ref('user-avatar$userId');

  try {
    return await ref.getDownloadURL();
  } catch (e) {
    return '';
  }
}

Future<String> getBackgroundUrl(int userId) async {
  final ref = FirebaseStorage.instance.ref('user-personal-background$userId');

  try {
    return await ref.getDownloadURL();
  } catch (e) {
    return '';
  }
}

Future<String> updateProfileAvatarImage(int userId, String filePath) async {
  try {
    final file = File(filePath);

    final ref = FirebaseStorage.instance.ref('user-avatar$userId');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  } catch (_) {
    return '';
  }
}

Future<String> updateProfileBackgroundImage(int userId, String filePath) async {
  try {
    final file = File(filePath);

    final ref = FirebaseStorage.instance.ref('user-personal-background$userId');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  } catch (_) {
    return '';
  }
}

Future<void> deleteProfileAvatarImage(int userId) async {
  final ref = FirebaseStorage.instance.ref('user-avatar$userId');

  await ref.delete();
}

Future<void> deleteProfileBackgroundImage(int userId) async {
  final ref = FirebaseStorage.instance.ref('user-personal-background$userId');

  await ref.delete();
}
