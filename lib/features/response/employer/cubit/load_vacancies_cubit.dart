import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data_layer/model/vacancy.dart';
import '../../../../data_layer/data_provider/regular_api_client.dart';

part 'load_vacancies_state.dart';

class LoadVacanciesCubit extends Cubit<LoadVacanciesState> {
  LoadVacanciesCubit(int userId)
      : assert(userId != null),
        _userId = userId,
        super(VacanciesLoadInProgress());

  final int _userId;

  Future<void> loadVacancies() async {
    try {
      emit(VacanciesLoadInProgress());
      final vacancies = await RegularApiClient.fetchVacancies(_userId);
      emit(VacanciesLoadSuccess(vacancies));
    } catch (e) {
      emit(VacanciesLoadFailure(e));
    }
  }
}
