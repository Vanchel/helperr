part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoadInProgress extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  ProfileLoadSuccess(this.workerInfo);

  final WorkerInfo workerInfo;

  @override
  List<Object> get props => [workerInfo];
}

class ProfileLoadFailure extends ProfileState {
  ProfileLoadFailure(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}
