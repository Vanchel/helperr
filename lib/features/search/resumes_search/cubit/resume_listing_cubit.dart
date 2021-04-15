import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:helperr/data_layer/model/resume_search_options.dart';
import 'package:helperr/data_layer/model/truncated_resume.dart';
import 'package:helperr/data_layer/data_provider/regular_api_client.dart';

part 'resume_listing_state.dart';

class ResumeListingCubit extends Cubit<ResumeListingState> {
  ResumeListingCubit({@required this.searchOptions})
      : super(const ResumesFetchInProgressState());

  final ResumeSearchOptions searchOptions;

  Future<void> fetchPage(String pageUri) async {
    try {
      emit(ResumesFetchInProgressState());
      final result = (pageUri != null)
          ? await RegularApiClient.fetchResumesWithPage(pageUri)
          : await RegularApiClient.fetchResumesWithOptions(searchOptions);
      final newState = ResumesFetchSuccessState(
        nextPageUri: result.next,
        itemList: result.results,
      );
      emit(newState);
    } catch (e) {
      final newState = ResumesFetchFailureState(error: e);
      emit(newState);
    }
  }
}
