import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data_layer/model/response.dart';
import '../../../../../data_layer/data_provider/regular_api_client.dart';

part 'worker_response_state.dart';

class WorkerResponseCubit extends Cubit<WorkerResponseState> {
  WorkerResponseCubit() : super(WorkerResponseInitial());

  Future<void> addResponse(Response response) async {
    try {
      emit(WorkerResponseInProgress());
      await RegularApiClient.addVacancyResponse(response);
      emit(WorkerResponseSuccess());
    } catch (_) {
      emit(WorkerResponseFailure());
    }
  }
}
