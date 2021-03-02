part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class ProfileSaveInProgress extends EditProfileState {}

class ProfileSaveSuccess extends EditProfileState {}

class ProfileSaveFailure extends EditProfileState {}
