import 'dart:convert';

import 'dart:io';
import 'dart:convert' show utf8;
import 'package:helperr/data_layer/model/resume_favorite_result.dart';
import 'package:helperr/data_layer/model/vacancy_favorite_result.dart';
import 'package:http/http.dart' as http;

import '../model/models.dart';

class RegularApiClient {
  static const _baseUrl = 'job-flow.ru';

  static http.Client httpClient;
  static String Function() getAuthToken;
  static void Function() onUnauthorized;
  static Future<void> Function() updateTokens;

  static Map<String, String> get _headers => {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: getAuthToken(),
      };

  static Future<http.Response> _requestAuthorized(
      Future<http.Response> Function() callback, String errorMessage) async {
    final response = await callback();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    }
    if (response.statusCode != 401 && response.statusCode != 403) {
      throw Exception(errorMessage);
    }

    await updateTokens();
    final newResponse = await callback();
    if (newResponse.statusCode >= 200 && newResponse.statusCode < 300) {
      return newResponse;
    }
    if (newResponse.statusCode != 401 && response.statusCode != 403) {
      throw Exception(errorMessage);
    }

    onUnauthorized();
    return null;
  }

  static Future<VacancyFavoriteResult> fetchFavoriteVacancies(
      String pageUri) async {
    final uri = (pageUri?.isNotEmpty ?? false)
        ? Uri.parse(pageUri)
        : Uri.http(_baseUrl, 'api/favorites/vacancy');

    final response = await _requestAuthorized(
      () async => await httpClient.get(uri, headers: _headers),
      'Failed to fetch favorite vacancies',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return vacancyFavoriteResultFromJson(decodedResponse);
  }

  static Future<ResumeFavoriteResult> fetchFavoriteResumes(
      String pageUri) async {
    final uri = (pageUri?.isNotEmpty ?? false)
        ? Uri.parse(pageUri)
        : Uri.http(_baseUrl, 'api/favorites/cv');

    final response = await _requestAuthorized(
      () async => await httpClient.get(uri, headers: _headers),
      'Failed to fetch favorite resumes',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return resumeFavoriteResultFromJson(decodedResponse);
  }

  static Future<void> addFavoriteVacancy(int vacancyId) async {
    final data = {'item_id': vacancyId};
    final body = utf8.encode(json.encode(data));

    await _requestAuthorized(
      () async => await httpClient.post(
        Uri.http(_baseUrl, 'api/favorites/vacancy/'),
        body: body,
        headers: _headers,
      ),
      'Failed to add vacancy to favorite',
    );
  }

  static Future<void> deleteFavoriteVacancy(int vacancyId) async {
    await _requestAuthorized(
      () async => await httpClient.delete(
        Uri.http(_baseUrl, 'api/favorites/vacancy/$vacancyId'),
        headers: _headers,
      ),
      'Failed to remove vacancy from favorite',
    );
  }

  static Future<void> addFavoriteResume(int resumeId) async {
    final data = {'item_id': resumeId};
    final body = utf8.encode(json.encode(data));

    await _requestAuthorized(
      () async => await httpClient.post(
        Uri.http(_baseUrl, 'api/favorites/cv/'),
        body: body,
        headers: _headers,
      ),
      'Failed to add resume to favorite',
    );
  }

  static Future<void> deleteFavoriteResume(int resumeId) async {
    await _requestAuthorized(
      () async => await httpClient.delete(
        Uri.http(_baseUrl, 'api/favorites/cv/$resumeId'),
        headers: _headers,
      ),
      'Failed to remove resume from favorite',
    );
  }

  static Future<void> updateVacancyResponseState(
      int responseId, ResponseState newState) async {
    final body = {
      'id': responseId,
      'state': responseStateToJson(newState),
    };

    await _requestAuthorized(
      () async => await httpClient.put(
        Uri.http(_baseUrl, 'api/vacancy/response/'),
        body: json.encode(body),
        headers: _headers,
      ),
      'Failed to update vacancy response state',
    );
  }

  static Future<void> updateResumeResponseState(
      int responseId, ResponseState newState) async {
    final body = {
      'id': responseId,
      'state': responseStateToJson(newState),
    };

    await _requestAuthorized(
      () async => await httpClient.put(
        Uri.http(_baseUrl, 'api/cv/response/'),
        body: json.encode(body),
        headers: _headers,
      ),
      'Failed to update resume response state',
    );
  }

  static Future<DetailedResponseResult> fetchVacancyWorkerResponses(
      String pageUri, int userId) async {
    final uri = (pageUri?.isNotEmpty ?? false)
        ? Uri.parse(pageUri)
        : Uri.http(_baseUrl, 'api/vacancy/response/worker/$userId');

    final response = await _requestAuthorized(
      () async => await httpClient.get(uri, headers: _headers),
      'Failed to fetch vacancy responses for worker',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return detailedResponseResultFromJson(decodedResponse);
  }

  static Future<DetailedResponseResult> fetchVacancyEmployerResponses(
      String pageUri, int userId) async {
    final uri = (pageUri?.isNotEmpty ?? false)
        ? Uri.parse(pageUri)
        : Uri.http(_baseUrl, 'api/vacancy/response/employer/$userId');

    final response = await _requestAuthorized(
      () async => await httpClient.get(uri, headers: _headers),
      'Failed to fetch vacancy responses for employer',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return detailedResponseResultFromJson(decodedResponse);
  }

  static Future<DetailedResponseResult> fetchResumeWorkerResponses(
      String pageUri, int userId) async {
    final uri = (pageUri?.isNotEmpty ?? false)
        ? Uri.parse(pageUri)
        : Uri.http(_baseUrl, 'api/cv/response/worker/$userId');

    final response = await _requestAuthorized(
      () async => await httpClient.get(uri, headers: _headers),
      'Failed to fetch resume responses for worker',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return detailedResponseResultFromJson(decodedResponse);
  }

  static Future<DetailedResponseResult> fetchResumeEmployerResponses(
      String pageUri, int userId) async {
    final uri = (pageUri?.isNotEmpty ?? false)
        ? Uri.parse(pageUri)
        : Uri.http(_baseUrl, 'api/cv/response/employer/$userId');

    final response = await _requestAuthorized(
      () async => await httpClient.get(uri, headers: _headers),
      'Failed to fetch resume responses for employer',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return detailedResponseResultFromJson(decodedResponse);
  }

  static Future<void> addVacancyResponse(Response vacancyResponse) async {
    await _requestAuthorized(
      () async => await httpClient.post(
        Uri.http(_baseUrl, 'api/vacancy/response/'),
        body: utf8.encode(responseToJson(vacancyResponse)),
        headers: _headers,
      ),
      'Failed to add vacancy response',
    );
  }

  static Future<void> addResumeResponse(Response resumeResponse) async {
    await _requestAuthorized(
      () async => await httpClient.post(
        Uri.http(_baseUrl, 'api/cv/response/'),
        body: utf8.encode(responseToJson(resumeResponse)),
        headers: _headers,
      ),
      'Failed to add resume response',
    );
  }

  static Future<Vacancy> fetchVacancy(int id) async {
    final response = await _requestAuthorized(
      () async => await httpClient.get(
        Uri.http(_baseUrl, 'api/vacancy/$id'),
        headers: _headers,
      ),
      'Failed to fetch vacancy',
    );

    return vacancyFromJson(utf8.decode(response.body.runes.toList()));
  }

  static Future<Resume> fetchResume(int id) async {
    final response = await _requestAuthorized(
      () async => await httpClient.get(
        Uri.http(_baseUrl, 'api/cv/$id'),
        headers: _headers,
      ),
      'Failed to fetch resume',
    );

    return resumeFromJson(utf8.decode(response.body.runes.toList()));
  }

  static Future<VacancySearchResult> fetchVacanciesWithOptions(
      VacancySearchOptions options) async {
    final response = await _requestAuthorized(
      () async => await httpClient.get(
        Uri.http(_baseUrl, 'api/vacancy/search/', options.toJson()),
        headers: _headers,
      ),
      'Failed to fetch search results for vacancies',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return vacancySearchResultFromJson(decodedResponse);
  }

  static Future<VacancySearchResult> fetchVacanciesWithPage(
      String pageUri) async {
    final response = await _requestAuthorized(
      () async => await httpClient.get(
        Uri.parse(pageUri),
        headers: _headers,
      ),
      'Failed to fetch search results for vacancies',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return vacancySearchResultFromJson(decodedResponse);
  }

  static Future<ResumeSearchResult> fetchResumesWithOptions(
      ResumeSearchOptions options) async {
    final response = await _requestAuthorized(
      () async => await httpClient.get(
        Uri.http(_baseUrl, 'api/cv/search/', options.toJson()),
        headers: _headers,
      ),
      'Failed to fetch search results for resumes',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return resumeSearchResultFromJson(decodedResponse);
  }

  static Future<ResumeSearchResult> fetchResumesWithPage(String pageUri) async {
    final response = await _requestAuthorized(
      () async => await httpClient.get(
        Uri.parse(pageUri),
        headers: _headers,
      ),
      'Failed to fetch search results for resumes',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    return resumeSearchResultFromJson(decodedResponse);
  }

  static Future<Worker> fetchWorker(int userId) async {
    final response = await _requestAuthorized(
      () async => await httpClient.get(
        Uri.http(_baseUrl, 'api/workers/$userId'),
        headers: _headers,
      ),
      'Failed to fetch worker',
    );

    return workerFromJson(utf8.decode(response.body.runes.toList()));
  }

  static Future<void> updateWorker(Worker worker) async {
    final body = utf8.encode(workerToJson(worker));

    await _requestAuthorized(
      () async => await httpClient.put(
        Uri.http(_baseUrl, 'api/workers/${worker.userId}'),
        body: body,
        headers: _headers,
      ),
      'Failed to update worker profile',
    );
  }

  static Future<List<Resume>> fetchResumes(int userId) async {
    final response = await _requestAuthorized(
      () async => await httpClient.get(
        Uri.http(_baseUrl, 'api/cv/user/$userId'),
        headers: _headers,
      ),
      'Failed to fetch resumes',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    final resumesList = (json.decode(decodedResponse) as List)
        .map((str) => Resume.fromJson(str))
        .toList();
    return resumesList;
  }

  static Future<void> addResume(Resume resume) async {
    final body = utf8.encode(resumeToJson(resume));

    await _requestAuthorized(
      () async => await httpClient.post(
        Uri.http(_baseUrl, 'api/cv/'),
        body: body,
        headers: _headers,
      ),
      'Failed to add resume',
    );
  }

  static Future<void> updateResume(Resume resume) async {
    final body = utf8.encode(resumeToJson(resume));

    await _requestAuthorized(
      () async => await httpClient.put(
        Uri.http(_baseUrl, 'api/cv/${resume.id}'),
        body: body,
        headers: _headers,
      ),
      'Failed to update resume',
    );
  }

  static Future<void> deleteResume(int resumeId) async {
    await _requestAuthorized(
      () async => await httpClient.delete(
        Uri.http(_baseUrl, 'api/cv/$resumeId'),
        headers: _headers,
      ),
      'Failed to delete resume',
    );
  }

  static Future<Employer> fetchEmployer(int userId) async {
    final response = await _requestAuthorized(
      () async => await httpClient.get(
        Uri.http(_baseUrl, 'api/employers/$userId'),
        headers: _headers,
      ),
      'Failed to fetch employer',
    );

    return employerFromJson(utf8.decode(response.body.runes.toList()));
  }

  static Future<void> updateEmployer(Employer employer) async {
    final body = utf8.encode(employerToJson(employer));

    await _requestAuthorized(
      () async => await httpClient.put(
        Uri.http(_baseUrl, 'api/employers/${employer.userId}'),
        body: body,
        headers: _headers,
      ),
      'Failed to update employer profile',
    );
  }

  static Future<List<Vacancy>> fetchVacancies(int userId) async {
    final response = await _requestAuthorized(
      () async => await httpClient.get(
        Uri.http(_baseUrl, 'api/vacancy/user/$userId'),
        headers: _headers,
      ),
      'Failed to fetch vacancies',
    );

    final decodedResponse = utf8.decode(response.body.runes.toList());
    final vacanciesList = (json.decode(decodedResponse) as List)
        .map((str) => Vacancy.fromJson(str))
        .toList();
    return vacanciesList;
  }

  static Future<void> addVacancy(Vacancy vacancy) async {
    final body = utf8.encode(vacancyToJson(vacancy));

    await _requestAuthorized(
      () async => await httpClient.post(
        Uri.http(_baseUrl, 'api/vacancy/'),
        body: body,
        headers: _headers,
      ),
      'Failed to add vacancy',
    );
  }

  static Future<void> updateVacancy(Vacancy vacancy) async {
    final body = utf8.encode(vacancyToJson(vacancy));

    await _requestAuthorized(
      () async => await httpClient.put(
        Uri.http(_baseUrl, 'api/vacancy/${vacancy.id}'),
        body: body,
        headers: _headers,
      ),
      'Failed to update vacancy',
    );
  }

  static Future<void> deleteVacancy(int vacancyId) async {
    await _requestAuthorized(
      () async => await httpClient.delete(
        Uri.http(_baseUrl, 'api/vacancy/$vacancyId'),
        headers: _headers,
      ),
      'Failed to delete vacancy',
    );
  }

  static Future<User> getUser(int userId) async {
    final response = await _requestAuthorized(
      () async => await httpClient.get(
        Uri.http(_baseUrl, 'api/users/$userId'),
        headers: _headers,
      ),
      'Failed to fetch user',
    );

    return userFromJson(utf8.decode(response.body.runes.toList()));
  }
}
