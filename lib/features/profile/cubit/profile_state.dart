part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded(this.worker);

  final Worker worker;

  @override
  List<Object> get props => [worker];
}

class ProfileFailedLoading extends ProfileState {
  const ProfileFailedLoading();
}
