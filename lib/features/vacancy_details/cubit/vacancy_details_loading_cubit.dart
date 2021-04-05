import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/models.dart';

import '../../../data_layer/data_provider/helperr_server.dart' as server;

part 'vacancy_details_loading_state.dart';

class VacancyDetailsLoadingCubit extends Cubit<VacancyDetailsLoadingState> {
  VacancyDetailsLoadingCubit(int vacancyId)
      : assert(vacancyId != null),
        _vacancyId = vacancyId,
        super(VacancyDetailsLoadingInitial());

  final int _vacancyId;

  Future<void> loadVacancy() async {
    try {
      emit(VacancyLoadInProgress());
      final vacancy = await server.fetchVacancy(_vacancyId);
      emit(VacancyLoadSuccess(vacancy));
    } catch (_) {
      emit(VacancyLoadFailure());
    }
  }
}
