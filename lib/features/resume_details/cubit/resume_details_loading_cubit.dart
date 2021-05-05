import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/models.dart';

import '../../../data_layer/data_provider/regular_api_client.dart';

part 'resume_details_loading_state.dart';

class ResumeDetailsLoadingCubit extends Cubit<ResumeDetailsLoadingState> {
  ResumeDetailsLoadingCubit(int resumeId)
      : assert(resumeId != null),
        _resumeId = resumeId,
        super(ResumeDetailsLoadingInitial());

  final int _resumeId;

  Future<void> loadResume() async {
    try {
      emit(ResumeLoadInProgress());
      final resume = await RegularApiClient.fetchResume(_resumeId);
      emit(ResumeLoadSuccess(resume));
    } catch (e) {
      emit(ResumeLoadFailure(e));
    }
  }
}
