part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoadInProgress extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  ProfileLoadSuccess(this.employerInfo);

  final EmployerInfo employerInfo;

  @override
  List<Object> get props => [employerInfo];
}

class ProfileLoadFailure extends ProfileState {}
