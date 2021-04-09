import '../../../data_layer/model/response.dart';
import '../../../data_layer/model/response_state.dart';
import '../../../data_layer/data_provider/helperr_server.dart' as server;

abstract class BackResponseRepository {
  Future<void> respond(Response response);
}

class WorkerInitialResponseRepository implements BackResponseRepository {
  const WorkerInitialResponseRepository();

  @override
  Future<void> respond(Response response) async {
    await Future.wait([
      server.updateVacancyResponseState(response.id, ResponseState.viewed),
      server.addResumeResponse(response),
    ]);
  }
}

class EmployerInitialResponseRepository implements BackResponseRepository {
  const EmployerInitialResponseRepository();

  @override
  Future<void> respond(Response response) async {
    await Future.wait([
      server.updateResumeResponseState(response.id, ResponseState.viewed),
      server.addVacancyResponse(response),
    ]);
  }
}