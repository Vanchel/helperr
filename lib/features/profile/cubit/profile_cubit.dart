import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;

import '../../../data_layer/model/worker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({@required int userId})
      : assert(userId != null),
        _userId = userId,
        super(const ProfileInitial());

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
}
