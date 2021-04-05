import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data_layer/model/response.dart';
import '../../../../../data_layer/data_provider/helperr_server.dart' as server;

part 'employer_response_state.dart';

class EmployerResponseCubit extends Cubit<EmployerResponseState> {
  EmployerResponseCubit() : super(EmployerResponseInitial());

  Future<void> addResponse(Response response) async {
    try {
      emit(EmployerResponseInProgress());
      await server.addResumeResponse(response);
      emit(EmployerResponseSuccess());
    } catch (_) {
      emit(EmployerResponseFailure());
    }
  }
}
