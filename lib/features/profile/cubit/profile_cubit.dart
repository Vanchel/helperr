import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/user.dart';
import 'package:helperr/data_layer/model/worker_info.dart';
import 'package:helperr/features/profile/repository/worker_profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({@required User user})
      : assert(user != null),
        _user = user,
        super(ProfileLoadInProgress());

  final User _user;

  Future<void> loadProfile() async {
    try {
      final workerInfo = await WokerProfileRepository.getWorkerInfo(_user.id);
      emit(ProfileLoadSuccess(workerInfo));
    } catch (_) {
      emit(ProfileLoadFailure());
    }
  }
}
