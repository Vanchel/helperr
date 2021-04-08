import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/back_response_repository.dart';
import '../../../data_layer/model/response.dart';

part 'back_response_state.dart';

class BackResponseCubit extends Cubit<BackResponseState> {
  BackResponseCubit(this.repository) : super(BackResponseState());

  final BackResponseRepository repository;

  Future<void> respond(Response response) async {
    try {
      emit(const BackResponseState(BackResponseStatus.inProgress));
      await repository.respond(response);
      emit(const BackResponseState(BackResponseStatus.success));
    } catch (_) {
      emit(const BackResponseState(BackResponseStatus.failure));
    }
  }
}
