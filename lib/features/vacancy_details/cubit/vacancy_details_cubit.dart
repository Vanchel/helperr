import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/models.dart';

import '../../../data_layer/data_provider/helperr_server.dart' as server;

part 'vacancy_details_state.dart';

class VacancyDetailsCubit extends Cubit<VacancyDetailsState> {
  VacancyDetailsCubit(vacancyId)
      : assert(vacancyId != null),
        _vacancyId = vacancyId,
        super(VacancyDetailsInitial());

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
