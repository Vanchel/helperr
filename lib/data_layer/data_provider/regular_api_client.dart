import 'dart:convert';

import 'dart:io';
import 'dart:convert' show utf8;
import 'package:http/http.dart' as http;

import '../model/models.dart';

class RegularApiClient {
  static const _baseUrl = 'job-flow.ru';

  static http.Client httpClient;
  static String Function() getAuthToken;
  static void Function() onUnauthorized;

  static Map<String, String> get _headers => {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: getAuthToken(),
      };

  // **********************************************************
  static void _handleError(int statusCode, String errorMessage) {
    if (statusCode >= 200 && statusCode < 300) return;

    if (statusCode == 401 || statusCode == 403) {
      onUnauthorized();
    }
    throw Exception(errorMessage);
  }

  static Future<void> updateVacancyResponseState(
      int responseId, ResponseState newState) async {
    final body = {
      'id': responseId,
      'state': responseStateToJson(newState),
    };

    final response = await httpClient.put(
      Uri.http(_baseUrl, 'api/vacancy/response/'),
      body: json.encode(body),
      headers: _headers,
    );
    _handleError(
        response.statusCode, 'Failed to update vacancy response state');
  }

  static Future<void> updateResumeResponseState(
      int responseId, ResponseState newState) async {
    final body = {
      'id': responseId,
      'state': responseStateToJson(newState),
    };

    final response = await httpClient.put(
      Uri.http(_baseUrl, 'api/cv/response/'),
      body: json.encode(body),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to update resume response state');
  }

  static Future<DetailedResponseResult> fetchVacancyWorkerResponses(
      String pageUri, int userId) async {
    final uri = (pageUri?.isNotEmpty ?? false)
        ? Uri.parse(pageUri)
        : Uri.http(_baseUrl, 'api/vacancy/response/worker/$userId');

    final response = await httpClient.get(uri, headers: _headers);
    _handleError(
        response.statusCode, 'Failed to fetch vacancy responses for worker');

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return detailedResponseResultFromJson(decodedResponse);
  }

  static Future<DetailedResponseResult> fetchVacancyEmployerResponses(
      String pageUri, int userId) async {
    final uri = (pageUri?.isNotEmpty ?? false)
        ? Uri.parse(pageUri)
        : Uri.http(_baseUrl, 'api/vacancy/response/employer/$userId');

    final response = await httpClient.get(uri, headers: _headers);
    _handleError(
        response.statusCode, 'Failed to fetch vacancy responses for employer');

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return detailedResponseResultFromJson(decodedResponse);
  }

  static Future<DetailedResponseResult> fetchResumeWorkerResponses(
      String pageUri, int userId) async {
    final uri = (pageUri?.isNotEmpty ?? false)
        ? Uri.parse(pageUri)
        : Uri.http(_baseUrl, 'api/cv/response/worker/$userId');

    final response = await httpClient.get(uri, headers: _headers);
    _handleError(
        response.statusCode, 'Failed to fetch resume responses for worker');

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return detailedResponseResultFromJson(decodedResponse);
  }

  static Future<DetailedResponseResult> fetchResumeEmployerResponses(
      String pageUri, int userId) async {
    final uri = (pageUri?.isNotEmpty ?? false)
        ? Uri.parse(pageUri)
        : Uri.http(_baseUrl, 'api/cv/response/employer/$userId');

    final response = await httpClient.get(uri, headers: _headers);
    _handleError(
        response.statusCode, 'Failed to fetch resume responses for employer');

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return detailedResponseResultFromJson(decodedResponse);
  }

  static Future<void> addVacancyResponse(Response vacancyResponse) async {
    final response = await httpClient.post(
      Uri.http(_baseUrl, 'api/vacancy/response/'),
      body: utf8.encode(responseToJson(vacancyResponse)),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to add vacancy response');
  }

  static Future<void> addResumeResponse(Response vacancyResponse) async {
    final response = await httpClient.post(
      Uri.http(_baseUrl, 'api/cv/response/'),
      body: utf8.encode(responseToJson(vacancyResponse)),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to add resume response');
  }

  static Future<Vacancy> fetchVacancy(int id) async {
    final response = await httpClient.get(
      Uri.http(_baseUrl, 'api/vacancy/$id'),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to fetch vacancy');

    return vacancyFromJson(utf8.decode(response.body.runes.toList()));
  }

  static Future<Resume> fetchResume(int id) async {
    final response = await httpClient.get(
      Uri.http(_baseUrl, 'api/cv/$id'),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to fetch resume');

    return resumeFromJson(utf8.decode(response.body.runes.toList()));
  }

  static Future<VacancySearchResult> fetchVacanciesWithOptions(
      VacancySearchOptions options) async {
    final response = await httpClient.get(
      Uri.http(_baseUrl, 'api/vacancy/search/', options.toJson()),
      headers: _headers,
    );
    _handleError(
        response.statusCode, 'Failed to fetch search results for vacancies');

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return vacancySearchResultFromJson(decodedResponse);
  }

  static Future<VacancySearchResult> fetchVacanciesWithPage(
      String pageUri) async {
    final response = await httpClient.get(
      Uri.parse(pageUri),
      headers: _headers,
    );
    _handleError(
        response.statusCode, 'Failed to fetch search results for vacancies');

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return vacancySearchResultFromJson(decodedResponse);
  }

  static Future<ResumeSearchResult> fetchResumesWithOptions(
      ResumeSearchOptions options) async {
    final response = await httpClient.get(
      Uri.http(_baseUrl, 'api/cv/search/', options.toJson()),
      headers: _headers,
    );
    _handleError(
        response.statusCode, 'Failed to fetch search results for resumes');

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return resumeSearchResultFromJson(decodedResponse);
  }

  static Future<ResumeSearchResult> fetchResumesWithPage(String pageUri) async {
    final response = await httpClient.get(
      Uri.parse(pageUri),
      headers: _headers,
    );
    _handleError(
        response.statusCode, 'Failed to fetch search results for resumes');

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return resumeSearchResultFromJson(decodedResponse);
  }

  static Future<Worker> fetchWorker(int userId) async {
    final response = await httpClient.get(
      Uri.http(_baseUrl, 'api/workers/$userId'),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to fetch worker');

    return workerFromJson(utf8.decode(response.body.runes.toList()));
  }

  static Future<void> updateWorker(Worker worker) async {
    final body = utf8.encode(workerToJson(worker));

    final response = await httpClient.put(
      Uri.http(_baseUrl, 'api/workers/${worker.userId}'),
      body: body,
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to update worker profile');
  }

  static Future<List<Resume>> fetchResumes(int userId) async {
    final response = await httpClient.get(
      Uri.http(_baseUrl, 'api/cv/user/$userId'),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to fetch resumes');

    final decodedResponse = utf8.decode(response.body.runes.toList());
    final resumesList = (json.decode(decodedResponse) as List)
        .map((str) => Resume.fromJson(str))
        .toList();
    return resumesList;
  }

  static Future<void> addResume(Resume resume) async {
    final body = utf8.encode(resumeToJson(resume));
    final response = await httpClient.post(
      Uri.http(_baseUrl, 'api/cv/'),
      body: body,
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to add resume');
  }

  static Future<void> updateResume(Resume resume) async {
    final body = utf8.encode(resumeToJson(resume));
    final response = await httpClient.put(
      Uri.http(_baseUrl, 'api/cv/${resume.id}'),
      body: body,
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to update resume');
  }

  static Future<void> deleteResume(int resumeId) async {
    final response = await httpClient.delete(
      Uri.http(_baseUrl, 'api/cv/$resumeId'),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to delete resume');
  }

  static Future<Employer> fetchEmployer(int userId) async {
    final response = await httpClient.get(
      Uri.http(_baseUrl, 'api/employers/$userId'),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to fetch employer');

    return employerFromJson(utf8.decode(response.body.runes.toList()));
  }

  static Future<void> updateEmployer(Employer employer) async {
    final body = utf8.encode(employerToJson(employer));

    final response = await httpClient.put(
      Uri.http(_baseUrl, 'api/employers/${employer.userId}'),
      body: body,
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to update employer profile');
  }

  static Future<List<Vacancy>> fetchVacancies(int userId) async {
    final response = await httpClient.get(
      Uri.http(_baseUrl, 'api/vacancy/user/$userId'),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to fetch vacancies');

    final decodedResponse = utf8.decode(response.body.runes.toList());
    final vacanciesList = (json.decode(decodedResponse) as List)
        .map((str) => Vacancy.fromJson(str))
        .toList();
    return vacanciesList;
  }

  static Future<void> addVacancy(Vacancy vacancy) async {
    final body = utf8.encode(vacancyToJson(vacancy));
    final response = await httpClient.post(
      Uri.http(_baseUrl, 'api/vacancy/'),
      body: body,
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to add vacancy');
  }

  static Future<void> updateVacancy(Vacancy vacancy) async {
    final body = utf8.encode(vacancyToJson(vacancy));
    final response = await httpClient.put(
      Uri.http(_baseUrl, 'api/vacancy/${vacancy.id}'),
      body: body,
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to update vacancy');
  }

  static Future<void> deleteVacancy(int vacancyId) async {
    final response = await httpClient.delete(
      Uri.http(_baseUrl, 'api/vacancy/$vacancyId'),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to delete vacancy');
  }

  static Future<User> getUser(int userId) async {
    final response = await httpClient.get(
      Uri.http(_baseUrl, 'api/users/$userId'),
      headers: _headers,
    );
    _handleError(response.statusCode, 'Failed to fetch user');

    return userFromJson(utf8.decode(response.body.runes.toList()));
  }
}
