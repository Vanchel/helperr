import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../repository/detailed_response_repository.dart';
import '../../../data_layer/model/detailed_response.dart';

part 'response_listing_state.dart';

class ResponseListingCubit extends Cubit<ResponseListingState> {
  ResponseListingCubit({
    @required DetailedResponseRepository repository,
    @required int userId,
  })  : assert(repository != null),
        assert(userId != null),
        _repository = repository,
        _userId = userId,
        super(ResponsesFetchInProgress());

  final DetailedResponseRepository _repository;
  final int _userId;

  Future<void> fetchPage({String pageUri}) async {
    try {
      emit(const ResponsesFetchInProgress());
      final result = await _repository.fetchPage(pageUri, _userId);
      final newState = ResponsesFetchSuccess(
        nextPageUri: result.next,
        itemList: result.results,
      );
      emit(newState);
    } catch (e) {
      emit(ResponsesFetchFailure(error: e));
    }
  }
}
