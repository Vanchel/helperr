import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/data_layer/data_provider/regular_api_client.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> saveProfile(Worker worker) async {
    emit(ProfileSaveInProgress());
    try {
      await RegularApiClient.updateWorker(worker);
      emit(ProfileSaveSuccess());
    } catch (_) {
      emit(ProfileSaveFailure());
    }
  }
}
