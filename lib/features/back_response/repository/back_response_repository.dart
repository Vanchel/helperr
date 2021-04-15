import '../../../data_layer/model/response.dart';
import '../../../data_layer/model/response_state.dart';
import '../../../data_layer/data_provider/regular_api_client.dart';

abstract class BackResponseRepository {
  Future<void> respond(Response response);
}

class WorkerInitialResponseRepository implements BackResponseRepository {
  const WorkerInitialResponseRepository();

  @override
  Future<void> respond(Response response) async {
    await Future.wait([
      RegularApiClient.updateVacancyResponseState(
          response.id, ResponseState.viewed),
      RegularApiClient.addResumeResponse(response),
    ]);
  }
}

class EmployerInitialResponseRepository implements BackResponseRepository {
  const EmployerInitialResponseRepository();

  @override
  Future<void> respond(Response response) async {
    await Future.wait([
      RegularApiClient.updateResumeResponseState(
          response.id, ResponseState.viewed),
      RegularApiClient.addVacancyResponse(response),
    ]);
  }
}
