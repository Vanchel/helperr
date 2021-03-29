import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_profile/repository/edit_profile_repository.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> saveProfile(Worker worker) async {
    emit(ProfileSaveInProgress());
    try {
      await EditProfileRepository.saveWorkerProfile(worker);
      emit(ProfileSaveSuccess());
    } catch (_) {
      emit(ProfileSaveFailure());
    }
  }
}
