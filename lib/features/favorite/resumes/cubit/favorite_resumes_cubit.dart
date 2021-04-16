import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/data_provider/regular_api_client.dart';
import 'package:helperr/data_layer/model/truncated_resume.dart';

part 'favorite_resumes_state.dart';

class FavoriteResumesCubit extends Cubit<FavoriteResumesState> {
  FavoriteResumesCubit() : super(const ResumesFetchInProgressState());

  Future<void> fetchPage([String pageUri]) async {
    try {
      emit(ResumesFetchInProgressState());
      final result = await RegularApiClient.fetchFavoriteResumes(pageUri);
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
