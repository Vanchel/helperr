import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/vacancy.dart';
import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;

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
    await _wrapper(() => server.addVacancy(vacancy));
  }

  Future<void> updateVacancy(Vacancy vacancy) async {
    await _wrapper(() => server.updateVacancy(vacancy));
  }

  Future<void> deleteVacancy(int vacancyId) async {
    await _wrapper(() => server.deleteVacancy(vacancyId));
  }
}
