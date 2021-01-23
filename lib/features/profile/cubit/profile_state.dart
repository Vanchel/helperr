part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoadInProgress extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  ProfileLoadSuccess(this.worker);

  final Worker worker;

  @override
  List<Object> get props => [worker];
}

class ProfileLoadFailure extends ProfileState {}
