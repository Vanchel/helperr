import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:helperr/data_layer/model/resume_search_options.dart';
import 'package:helperr/data_layer/model/truncated_resume.dart';
import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;

part 'resume_listing_state.dart';

class ResumeListingCubit extends Cubit<ResumeListingState> {
  ResumeListingCubit({@required this.searchOptions})
      : super(const ResumesFetchInProgressState());

  final ResumeSearchOptions searchOptions;

  Future<void> fetchPage(String pageUri) async {
    try {
      emit(ResumesFetchInProgressState());
      final result = (pageUri != null)
          ? await server.fetchResumesWithPage(pageUri)
          : await server.fetchResumesWithOptions(searchOptions);
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
