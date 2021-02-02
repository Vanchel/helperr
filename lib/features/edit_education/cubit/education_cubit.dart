import 'package:bloc/bloc.dart';
import 'package:helperr/data_layer/model/models.dart';

class EducationCubit extends Cubit<List<Education>> {
  EducationCubit([educations = const []]) : super(educations);

  void addEducation(Education education) {
    emit(List.of(state)..add(education));
  }

  void editEducation(Education editedEducation, int index) {
    emit(List.of(state)..[index] = editedEducation);
  }

  void deleteEducation(int educationIndex) {
    emit(List.of(state)..removeAt(educationIndex));
  }
}
