import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../model/models.dart';

class AuthenticationApiClient {
  static const String _baseUrl = 'job-flow.ru';
  static const _headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  static const String _refreshTokenKey = 'refresh_token';

  final http.Client httpClient;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  DateTime _expirationDate;

  String _accessToken;
  String get accessToken => _accessToken;

  Timer _timer;

  AuthenticationApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<void> _verifyToken(String token) async {
    final data = {'token': token};
    final body = utf8.encode(json.encode(data));

    var response = await httpClient.post(
      Uri.http(_baseUrl, 'api/auth/token/verify/'),
      body: body,
      headers: _headers,
    );

    if (response.statusCode != 200) {
      print(response.statusCode);
      print(response.body);
      throw Exception('Token has not pass verification');
    }
  }

  Future<void> _refreshToken(String token) async {
    final data = {'refresh': token};
    final body = utf8.encode(json.encode(data));

    final response = await httpClient.post(
      Uri.http(_baseUrl, 'api/auth/token/refresh/'),
      body: body,
      headers: _headers,
    );

    if (response.statusCode != 200) {
      print(response.statusCode);
      print(response.body);
      throw Exception('Could not get a new pair of tokens');
    }

    final refreshResult =
        tokenRefreshResultFromJson(utf8.decode(response.body.runes.toList()));

    storage.write(key: _refreshTokenKey, value: refreshResult.refresh);
    _accessToken = refreshResult.access;
    _expirationDate = refreshResult.accessTokenExpiration;

    final seconds = _expirationDate.difference(DateTime.now()).inSeconds - 10;
    print('Next refresh is going to be in $seconds seconds');
    _timer = Timer(
      Duration(seconds: seconds),
      () => _refreshToken(refreshResult.refresh),
    );
  }

  Future<User> _getAuthenticatedUser(String token) async {
    final publicPart = TokenPublicPart.parse(token);

    final response = await http.get(
      Uri.http(_baseUrl, 'api/users/${publicPart.userId}'),
      headers: _headers,
    );

    if (response.statusCode != 200) {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to fetch user');
    }

    return userFromJson(utf8.decode(response.body.runes.toList()));
  }

  Future<User> login(String email, String password) async {
    final data = {'email': email, 'password': password};
    final body = utf8.encode(json.encode(data));

    final response = await http.post(
      Uri.http(_baseUrl, 'api/auth/login/'),
      body: body,
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseMap =
          json.decode(utf8.decode(response.body.runes.toList()));

      await _refreshToken(responseMap['refresh_token']);

      return User.fromJson(responseMap['user']);
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to login');
    }
  }

  // for some reason, the request cannot be completed when sending encoded UTF8
  Future<User> register(
    String name,
    String email,
    String password,
    UserType userType,
  ) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'user_type': userTypeToJson(userType)
    };
    final body = json.encode(data);

    final response = await http.post(
      Uri.http(_baseUrl, 'api/register/'),
      body: body,
      headers: _headers,
    );

    if (response.statusCode == 201) {
      return await login(email, password);
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to register');
    }
  }

  Future<void> logout() async {
    _timer?.cancel();
    print(
        'Next refresh that was going to be in ${_expirationDate.difference(DateTime.now()).inSeconds} is canceled');
    _accessToken = null;
    _expirationDate = null;
    storage.delete(key: _refreshTokenKey);
  }

  Future<User> loginAuto() async {
    final refreshToken = await storage.read(key: _refreshTokenKey);
    if (refreshToken == null) {
      throw Exception('No refresh token found');
    }

    await _verifyToken(refreshToken);
    final user = await _getAuthenticatedUser(refreshToken);
    await _refreshToken(refreshToken);

    return user;
  }
}
