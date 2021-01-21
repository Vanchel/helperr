import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:meta/meta.dart';

import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({@required int userId})
      : assert(userId != null),
        _userId = userId,
        super(EditProfileInitial());

  final _userId;

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    try {
      final worker = await server.fetchWorker(_userId);
      emit(ProfileLoaded(worker));
    } on Exception {
      emit(const ProfileFailedLoading());
    }
  }

  Future<void> saveProfile(Worker worker) async {
    try {
      server.updateWorker(worker);
      emit(const ProfileSuccessSaving());
    } on Exception {
      emit(const ProfileFailedSaving());
    }
  }
}
