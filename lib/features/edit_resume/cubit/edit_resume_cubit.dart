import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/resume.dart';
import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;

part 'edit_resume_state.dart';

// here is the place where an actual bloc would look better than cubit
class EditResumeCubit extends Cubit<EditResumeState> {
  EditResumeCubit() : super(EditResumeInitial());

  Future<void> addResume(Resume resume) async {
    // because of this line repeating in every scenario
    // and this whole try/catch too btw
    emit(ResumeChangeInProgress());
    try {
      await server.addResume(resume);
      emit(ResumeChangeSuccess());
    } catch (_) {
      emit(ResumeChangeFailure());
    }
  }

  Future<void> updateResume(Resume resume) async {
    emit(ResumeChangeInProgress());
    try {
      await server.updateResume(resume);
      emit(ResumeChangeSuccess());
    } catch (_) {
      emit(ResumeChangeFailure());
    }
  }

  Future<void> deleteResume(int resumeId) async {
    emit(ResumeChangeInProgress());
    try {
      await server.deleteResume(resumeId);
      emit(ResumeChangeSuccess());
    } catch (_) {
      emit(ResumeChangeFailure());
    }
  }
}
