import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data_layer/model/resume.dart';
import '../../../../data_layer/data_provider/helperr_server.dart' as server;

part 'load_resumes_state.dart';

class LoadResumesCubit extends Cubit<LoadResumesState> {
  LoadResumesCubit(int userId)
      : assert(userId != null),
        _userId = userId,
        super(ResumesLoadInProgress());

  final int _userId;

  Future<void> loadResumes() async {
    try {
      emit(ResumesLoadInProgress());
      final resumes = await server.fetchResumes(_userId);
      emit(ResumesLoadSuccess(resumes));
    } catch (_) {
      emit(ResumesLoadFailure());
    }
  }
}
