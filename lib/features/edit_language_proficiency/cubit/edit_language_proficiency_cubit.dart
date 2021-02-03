import 'package:bloc/bloc.dart';
import 'package:helperr/data_layer/model/models.dart';

class EditLanguageProficiencyCubit extends Cubit<LanguageProficiency> {
  EditLanguageProficiencyCubit(LanguageProficiency initialValue)
      : super(initialValue);

  void changeLanguageProficiency(LanguageProficiency proficiency) {
    emit(proficiency);
  }
}
