import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/resume.dart';
import 'package:helperr/data_layer/data_provider/regular_api_client.dart';

part 'edit_resume_state.dart';

class EditResumeCubit extends Cubit<EditResumeState> {
  EditResumeCubit() : super(EditResumeInitial());

  Future<void> _wrapper(Future<void> Function() callback) async {
    emit(ResumeChangeInProgress());
    try {
      await callback();
      emit(ResumeChangeSuccess());
    } catch (_) {
      emit(ResumeChangeFailure());
    }
  }

  Future<void> addResume(Resume resume) async {
    await _wrapper(() => RegularApiClient.addResume(resume));
  }

  Future<void> updateResume(Resume resume) async {
    await _wrapper(() => RegularApiClient.updateResume(resume));
  }

  Future<void> deleteResume(int resumeId) async {
    await _wrapper(() => RegularApiClient.deleteResume(resumeId));
  }
}
