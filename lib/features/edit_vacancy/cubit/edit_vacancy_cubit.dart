import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/vacancy.dart';
import 'package:helperr/data_layer/data_provider/regular_api_client.dart';

part 'edit_vacancy_state.dart';

class EditVacancyCubit extends Cubit<EditVacancyState> {
  EditVacancyCubit() : super(EditVacancyInitial());

  Future<void> _wrapper(Future<void> Function() callback) async {
    emit(VacancyChangeInProgress());
    try {
      await callback();
      emit(VacancyChangeSuccess());
    } catch (_) {
      emit(VacancyChangeFailure());
    }
  }

  Future<void> addVacancy(Vacancy vacancy) async {
    await _wrapper(() => RegularApiClient.addVacancy(vacancy));
  }

  Future<void> updateVacancy(Vacancy vacancy) async {
    await _wrapper(() => RegularApiClient.updateVacancy(vacancy));
  }

  Future<void> deleteVacancy(int vacancyId) async {
    await _wrapper(() => RegularApiClient.deleteVacancy(vacancyId));
  }
}
