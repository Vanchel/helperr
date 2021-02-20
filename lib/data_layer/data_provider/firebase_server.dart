import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> getUserProfileAvatarUrl(int userId) async {
  final ref = FirebaseStorage.instance.ref('user-avatar$userId');
  final url = await ref.getDownloadURL().catchError((e) => '');

  return url;
}

Future<String> getUserProfileBackgroundUrl(int userId) async {
  final ref = FirebaseStorage.instance.ref('user-personal-background$userId');
  final url = await ref.getDownloadURL().catchError((e) => '');

  return url;
}

Future<void> updateProfileAvatarImage(int userId, String filePath) async {
  final file = File(filePath);
  final ref = FirebaseStorage.instance.ref('user-avatar$userId');

  ref.putFile(file).catchError((e) => print(e));

  // try {
  //   ref.putFile(file);
  // } on Exception catch (e) {
  //   print(e);
  // }
}

Future<void> updateProfileBackgroundImage(int userId, String filePath) async {
  final file = File(filePath);
  final ref = FirebaseStorage.instance.ref('user-personal-background$userId');

  ref.putFile(file).catchError((e) => print(e));
}
