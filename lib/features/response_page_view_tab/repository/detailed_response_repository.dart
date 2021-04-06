import '../../../data_layer/model/detailed_response_result.dart';
import '../../../data_layer/data_provider/helperr_server.dart' as server;

abstract class DetailedResponseRepository {
  Future<DetailedResponseResult> fetchPage(String pageUri, int userId);
}

class WorkerInboxRepository implements DetailedResponseRepository {
  @override
  Future<DetailedResponseResult> fetchPage(String pageUri, int userId) async {
    return await server.fetchResumeWorkerResponses(pageUri, userId);
  }
}

class WorkerOutboxRepository implements DetailedResponseRepository {
  @override
  Future<DetailedResponseResult> fetchPage(String pageUri, int userId) async {
    return await server.fetchVacancyWorkerResponses(pageUri, userId);
  }
}

class EmployerInboxRepository implements DetailedResponseRepository {
  @override
  Future<DetailedResponseResult> fetchPage(String pageUri, int userId) async {
    return await server.fetchVacancyEmployerResponses(pageUri, userId);
  }
}

class EmployerOutboxRepository implements DetailedResponseRepository {
  @override
  Future<DetailedResponseResult> fetchPage(String pageUri, int userId) async {
    return await server.fetchResumeEmployerResponses(pageUri, userId);
  }
}
