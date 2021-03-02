import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/employer_info.dart';
import 'package:helperr/features/profile/repository/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({@required int id})
      : assert(id != null),
        _id = id,
        super(ProfileLoadInProgress());

  final int _id;

  Future<void> loadProfile() async {
    try {
      final employerInfo = await ProfileRepository.getEmployerInfo(_id);
      emit(ProfileLoadSuccess(employerInfo));
    } catch (_) {
      emit(ProfileLoadFailure());
    }
  }
}
