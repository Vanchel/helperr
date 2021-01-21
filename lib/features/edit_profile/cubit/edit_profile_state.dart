part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {
  const EditProfileInitial();
}

class ProfileLoading extends EditProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends EditProfileState {
  const ProfileLoaded(this.worker);

  final Worker worker;

  @override
  List<Object> get props => [worker];
}

// maybe these should be in a separate bloc
class ProfileFailedSaving extends EditProfileState {
  const ProfileFailedSaving();
}

class ProfileSuccessSaving extends EditProfileState {
  const ProfileSuccessSaving();
}
// ***

class ProfileFailedLoading extends EditProfileState {
  const ProfileFailedLoading();
}
