import 'package:bloc/bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';

class ExperienceCubit extends Cubit<List<Exp>> {
  ExperienceCubit([experience = const []]) : super(experience);

  void addExperience(Exp experience) {
    emit(List.of(state)..add(experience));
  }

  void editExperience(Exp editedExperience, int index) {
    emit(List.of(state)..[index] = editedExperience);
  }

  void deleteExperience(int experienceIndex) {
    emit(List.of(state)..removeAt(experienceIndex));
  }
}
