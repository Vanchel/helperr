import 'package:bloc/bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';

class EditEducationTypeCubit extends Cubit<EducationType> {
  EditEducationTypeCubit(EducationType initialValue) : super(initialValue);

  void changeEducationType(EducationType type) {
    emit(type);
  }
}
