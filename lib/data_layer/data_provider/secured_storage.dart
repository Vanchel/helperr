import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> readRefreshToken() async {
  final storage = new FlutterSecureStorage();
  return await storage.read(key: 'refresh_token');
}

Future<void> writeRefreshToken(String jwt) async {
  final storage = new FlutterSecureStorage();
  await storage.write(key: 'refresh_token', value: jwt);
}

Future<void> deleteRefreshToken() async {
  final storage = new FlutterSecureStorage();
  await storage.delete(key: 'refresh_token');
}

Future<String> readAccessToken() async {
  final storage = new FlutterSecureStorage();
  return await storage.read(key: 'access_token');
}

Future<void> writeAccessToken(String jwt) async {
  final storage = new FlutterSecureStorage();
  await storage.write(key: 'access_token', value: jwt);
}

Future<void> deleteAccessToken() async {
  final storage = new FlutterSecureStorage();
  await storage.delete(key: 'access_token');
}
