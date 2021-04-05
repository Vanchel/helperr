import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data_layer/model/response.dart';
import '../../../../../data_layer/data_provider/helperr_server.dart' as server;

part 'worker_response_state.dart';

class WorkerResponseCubit extends Cubit<WorkerResponseState> {
  WorkerResponseCubit() : super(WorkerResponseInitial());

  Future<void> addResponse(Response response) async {
    try {
      emit(WorkerResponseInProgress());
      await server.addVacancyResponse(response);
      emit(WorkerResponseSuccess());
    } catch (_) {
      emit(WorkerResponseFailure());
    }
  }
}
