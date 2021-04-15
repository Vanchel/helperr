import '../../../data_layer/model/detailed_response_result.dart';
import '../../../data_layer/data_provider/regular_api_client.dart';

abstract class DetailedResponseRepository {
  Future<DetailedResponseResult> fetchPage(String pageUri, int userId);
}

class WorkerInboxRepository implements DetailedResponseRepository {
  @override
  Future<DetailedResponseResult> fetchPage(String pageUri, int userId) async {
    return await RegularApiClient.fetchResumeWorkerResponses(pageUri, userId);
  }
}

class WorkerOutboxRepository implements DetailedResponseRepository {
  @override
  Future<DetailedResponseResult> fetchPage(String pageUri, int userId) async {
    return await RegularApiClient.fetchVacancyWorkerResponses(pageUri, userId);
  }
}

class EmployerInboxRepository implements DetailedResponseRepository {
  @override
  Future<DetailedResponseResult> fetchPage(String pageUri, int userId) async {
    return await RegularApiClient.fetchVacancyEmployerResponses(
        pageUri, userId);
  }
}

class EmployerOutboxRepository implements DetailedResponseRepository {
  @override
  Future<DetailedResponseResult> fetchPage(String pageUri, int userId) async {
    return await RegularApiClient.fetchResumeEmployerResponses(pageUri, userId);
  }
}
