import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/models.dart';

final String _baseUrl = 'http://3.22.99.254';

Future<Worker> fetchWorker(int userId) async {
  final response = await http.get('$_baseUrl/workers/$userId');

  if (response.statusCode == 200) {
    return workerFromJson(response.body);
  } else {
    throw Exception('failed to load user');
  }
}

Future<User> login(String email, String password) async {
  final data = {'email': email, 'password': password};
  final body = json.encode(data);

  final response = await http.post('$_baseUrl/login', body: body);

  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception('failed to login');
  }
}

Future<User> register(
    String name, String email, String password, String userType) async {
  final data = {
    'name': name,
    'email': email,
    'password': password,
    'user_type': userType
  };
  final body = json.encode(data);

  final response = await http.post('$_baseUrl/register', body: body);

  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception('failed to register');
  }
}
