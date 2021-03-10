import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;
import '../model/models.dart';

final String _baseUrl = 'job-flow.ru';

String _accessToken = '';
String _refreshToken = '';

Future<Worker> fetchWorker(int userId) async {
  final response = await http.get(
    Uri.http(_baseUrl, 'api/workers/$userId'),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    return workerFromJson(utf8.decode(response.body.runes.toList()));
  } else {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to fetch worker');
  }
}

Future<void> updateWorker(Worker worker) async {
  final body = utf8.encode(workerToJson(worker));

  final response = await http.put(
    Uri.http(_baseUrl, 'api/workers/${worker.userId}'),
    body: body,
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode != 200) {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to update worker profile');
  }
}

Future<List<Resume>> fetchResumes(int userId) async {
  final response = await http.get(
    Uri.http(_baseUrl, 'api/cv/user/$userId'),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    final decodedResponse = utf8.decode(response.body.runes.toList());
    final resumesList = (json.decode(decodedResponse) as List)
        .map((str) => Resume.fromJson(str))
        .toList();
    return resumesList;
  } else {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to fetch resumes');
  }
}

Future<void> addResume(Resume resume) async {
  final body = utf8.encode(resumeToJson(resume));
  final response = await http.post(
    Uri.http(_baseUrl, 'api/cv/'),
    body: body,
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode != 201) {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to add resume');
  }
}

Future<void> updateResume(Resume resume) async {
  final body = utf8.encode(resumeToJson(resume));
  final response = await http.put(
    Uri.http(_baseUrl, 'api/cv/${resume.id}'),
    body: body,
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode != 201) {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to update resume');
  }
}

Future<void> deleteResume(int resumeId) async {
  final response = await http.delete(
    Uri.http(_baseUrl, 'api/cv/$resumeId'),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode != 200) {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to delete resume');
  }
}

Future<Employer> fetchEmployer(int userId) async {
  final response = await http.get(
    Uri.http(_baseUrl, 'api/employers/$userId'),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    return employerFromJson(utf8.decode(response.body.runes.toList()));
  } else {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to fetch employer');
  }
}

Future<void> updateEmployer(Employer employer) async {
  final body = utf8.encode(employerToJson(employer));

  final response = await http.put(
    Uri.http(_baseUrl, 'api/employers/${employer.userId}'),
    body: body,
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode != 200) {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to update employer profile');
  }
}

Future<List<Vacancy>> fetchVacancies(int userId) async {
  final response = await http.get(
    Uri.http(_baseUrl, 'api/vacancy/user/$userId'),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    final decodedResponse = utf8.decode(response.body.runes.toList());
    final vacanciesList = (json.decode(decodedResponse) as List)
        .map((str) => Vacancy.fromJson(str))
        .toList();
    return vacanciesList;
  } else {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to fetch vacancies');
  }
}

Future<void> addVacancy(Vacancy vacancy) async {
  final body = utf8.encode(vacancyToJson(vacancy));
  final response = await http.post(
    Uri.http(_baseUrl, 'api/vacancy/'),
    body: body,
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode != 201) {
    print(response.statusCode);
    print(response.reasonPhrase);
    throw Exception('Failed to add vacancy');
  }
}

Future<void> updateVacancy(Vacancy vacancy) async {
  final body = utf8.encode(vacancyToJson(vacancy));
  final response = await http.put(
    Uri.http(_baseUrl, 'api/vacancy/${vacancy.id}'),
    body: body,
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode != 201) {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to update vacancy');
  }
}

Future<void> deleteVacancy(int vacancyId) async {
  final response = await http.delete(
    Uri.http(
      _baseUrl,
      'api/vacancy/$vacancyId',
    ),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode != 200) {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to delete vacancy');
  }
}

Future<User> login(String email, String password) async {
  final data = {'email': email, 'password': password};
  final body = utf8.encode(json.encode(data));

  final response = await http.post(
    Uri.http(_baseUrl, 'api/auth/login/'),
    body: body,
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseMap =
        json.decode(utf8.decode(response.body.runes.toList()));
    _accessToken = responseMap['access_token'];
    _refreshToken = responseMap['refresh_token'];

    print(responseMap['user'].runtimeType);
    print(responseMap['user']);

    User user = User.fromJson(responseMap['user']);
    print(user);
    return user;

    //return userFromJson(utf8.decode(response.body.runes.toList()));
  } else {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to login');
  }
}

// for some reason, the request cannot be completed when sending encoded UTF8
Future<User> register(
    String name, String email, String password, UserType userType) async {
  final user = {
    'name': name,
    'email': email,
    'password': password,
    'user_type': userTypeToJson(userType)
  };

  final response = await http.post(
    Uri.http(_baseUrl, 'api/register/'),
    body: json.encode(user),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  if (response.statusCode == 201) {
    return userFromJson(response.body);
  } else {
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to register');
  }
}
