import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:helperr/data_layer/model/vacancy_search_options.dart';
import 'package:helperr/data_layer/model/truncated_vacancy.dart';
import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;

part 'vacancy_listing_state.dart';

class VacancyListingCubit extends Cubit<VacancyListingState> {
  VacancyListingCubit({@required this.searchOptions})
      : super(const VacancyListingState());

  final VacancySearchOptions searchOptions;

  // TODO: подумать над объединением в один метод
  // Future<void> fetchInitial(VacancySearchOptions options) async {
  //   try {
  //     final result = await server.fetchVacanciesWithOptions(options);
  //     final newState = VacancyListingState(
  //       error: null,
  //       nextPageUri: result.next,
  //       itemList: result.results,
  //     );
  //     emit(newState);
  //   } catch (e) {
  //     final newState = VacancyListingState(
  //       error: e,
  //       nextPageUri: null,
  //       itemList: null,
  //     );
  //     emit(newState);
  //   }
  // }

  // Future<void> fetchPage(String pageUri) async {
  //   try {
  //     final result = await server.fetchVacanciesWithPage(pageUri);
  //     final newState = VacancyListingState(
  //       error: null,
  //       nextPageUri: result.next,
  //       itemList: result.results,
  //     );
  //     emit(newState);
  //   } catch (e) {
  //     final newState = VacancyListingState(
  //       error: e,
  //       nextPageUri: state.nextPageUri,
  //       itemList: state.itemList,
  //     );
  //     emit(newState);
  //   }
  // }

  Future<void> fetchPage(String pageUri) async {
    try {
      final result = (pageUri != null)
          ? await server.fetchVacanciesWithPage(pageUri)
          : await server.fetchVacanciesWithOptions(searchOptions);
      final newState = VacancyListingState(
        error: null,
        nextPageUri: result.next,
        itemList: result.results,
      );
      emit(newState);
      print('стейт я добавил, а ты его слушаешь?');
    } catch (e) {
      final newState = VacancyListingState(
        error: e,
        nextPageUri: state.nextPageUri,
        itemList: state.itemList,
      );
      emit(newState);
      print('стейт я добавил, а ты его слушаешь?');
    }
  }
}
