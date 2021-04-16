import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/data_provider/regular_api_client.dart';
import 'package:helperr/data_layer/model/truncated_vacancy.dart';

part 'favorite_vacancies_state.dart';

class FavoriteVacanciesCubit extends Cubit<FavoriteVacanciesState> {
  FavoriteVacanciesCubit() : super(const VacanciesFetchInProgressState());

  Future<void> fetchPage([String pageUri]) async {
    try {
      emit(VacanciesFetchInProgressState());
      final result = await RegularApiClient.fetchFavoriteVacancies(pageUri);
      final newState = VacanciesFetchSuccessState(
        nextPageUri: result.next,
        itemList: result.results,
      );
      emit(newState);
    } catch (e) {
      final newState = VacanciesFetchFailureState(error: e);
      emit(newState);
    }
  }
}
