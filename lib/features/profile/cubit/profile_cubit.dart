import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/user.dart';
import 'package:meta/meta.dart';

import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;

import '../../../data_layer/model/worker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({@required User user})
      : assert(user != null),
        _user = user,
        super(ProfileLoadInProgress());

  final User _user;

  Future<void> loadProfile() async {
    try {
      final worker = await server.fetchWorker(_user.id);
      emit(ProfileLoadSuccess(worker));
    } catch (_) {
      emit(ProfileLoadFailure());
    }
  }
}
