import 'package:bloc/bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';

class EditExperienceTypeCubit extends Cubit<ExperienceType> {
  EditExperienceTypeCubit(ExperienceType initialValue) : super(initialValue);

  void changeExperienceType(ExperienceType type) {
    emit(type);
  }
}
