import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;
import '../model/models.dart';

final String _baseUrl = 'http://job-flow.ru/api';

Future<Worker> fetchWorker(int userId) async {
  final response = await http.get('$_baseUrl/workers/$userId');

  if (response.statusCode == 200) {
    return workerFromJson(utf8.decode(response.body.runes.toList()));
  } else {
    throw Exception('failed to fetch worker');
  }
}

Future<void> updateWorker(Worker worker) async {
  final body = utf8.encode(workerToJson(worker));

  final response =
      await http.put('$_baseUrl/workers/${worker.userId}', body: body);

  if (response.statusCode != 200)
    throw Exception('Failed to update worker profile');
}

Future<List<Resume>> fetchResumes(int userId) async {
  final response = await http.get('$_baseUrl/cv/$userId');

  if (response.statusCode == 200) {
    final decodedResponse = utf8.decode(response.body.runes.toList());
    final resumesList = (json.decode(decodedResponse) as List)
        .map((str) => Resume.fromJson(str))
        .toList();
    return resumesList;
  } else {
    throw Exception('Failed to fetch resumes');
  }
}

// not yet tested
Future<void> addResume(Resume resume) async {
  final body = utf8.encode(resumeToJson(resume));
  final response = await http.post('$_baseUrl/cv', body: body);

  if (response.statusCode != 200) {
    throw Exception('Failed to add resume');
  }
}

// not yet tested
Future<void> updateResume(Resume resume) async {
  final body = utf8.encode(resumeToJson(resume));
  final response = await http.put('$_baseUrl/cv/${resume.id}', body: body);

  if (response.statusCode != 200) {
    throw Exception('Failed to update resume');
  }
}

// not yet tested
Future<void> deleteResume(int resumeId) async {
  final response = await http.delete('$_baseUrl/cv/$resumeId');

  if (response.statusCode != 200) {
    throw Exception('Failed to delete resume');
  }
}

Future<User> login(String email, String password) async {
  final data = {'email': email, 'password': password};
  final body = utf8.encode(json.encode(data));

  final response = await http.post('$_baseUrl/login', body: body);

  if (response.statusCode == 200) {
    return userFromJson(utf8.decode(response.body.runes.toList()));
  } else {
    throw Exception('failed to login');
  }
}

// for some reason, the request cannot be completed when sending encoded UTF8
Future<User> register(
    String name, String email, String password, String userType) async {
  final user = {
    'name': name,
    'email': email,
    'password': password,
    'user_type': userType
  };
  final profile = {
    "user_id": 0,
    "name": name,
    "mailing": true,
    "language": [],
    "birthday": "",
    "gender": "",
    "city": "",
    "phone": [],
    "about": "",
    "social_links": [],
    "education": [],
    "exp": [],
    "cz": "",
    "profile_link": "",
    "photo_url": "",
    "profile_background": ""
  };

  final body =
      '{"user": ${json.encode(user)}, "worker": ${json.encode(profile)}}';

  final response = await http.post('$_baseUrl/register', body: body);

  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception('failed to register');
  }
}
