import 'package:bloc/bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';

class LanguagesCubit extends Cubit<List<Language>> {
  LanguagesCubit([languages = const []]) : super(languages);

  void addLanguage(Language language) {
    emit(List.of(state)..add(language));
  }

  void editLanguage(Language editedLanguage, int index) {
    emit(List.of(state)..[index] = editedLanguage);
  }

  void deleteLanguage(int languageIndex) {
    emit(List.of(state)..removeAt(languageIndex));
  }
}
