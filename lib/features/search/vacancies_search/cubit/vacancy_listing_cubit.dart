import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:helperr/data_layer/model/vacancy_search_options.dart';
import 'package:helperr/data_layer/model/truncated_vacancy.dart';
import 'package:helperr/data_layer/data_provider/regular_api_client.dart';

part 'vacancy_listing_state.dart';

class VacancyListingCubit extends Cubit<VacancyListingState> {
  VacancyListingCubit({@required this.searchOptions})
      : super(const VacanciesFetchInProgressState());

  final VacancySearchOptions searchOptions;

  Future<void> fetchPage(String pageUri) async {
    try {
      emit(VacanciesFetchInProgressState());
      final result = (pageUri != null)
          ? await RegularApiClient.fetchVacanciesWithPage(pageUri)
          : await RegularApiClient.fetchVacanciesWithOptions(searchOptions);
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
