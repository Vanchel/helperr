part of 'resume_details_loading_cubit.dart';

abstract class ResumeDetailsLoadingState extends Equatable {
  const ResumeDetailsLoadingState();

  @override
  List<Object> get props => [];
}

class ResumeDetailsLoadingInitial extends ResumeDetailsLoadingState {}

class ResumeLoadInProgress extends ResumeDetailsLoadingState {}

class ResumeLoadSuccess extends ResumeDetailsLoadingState {
  const ResumeLoadSuccess(this.resume);

  final Resume resume;

  @override
  String toString() => 'Resume state for id ${resume.id}';

  @override
  List<Object> get props => [resume];
}

class ResumeLoadFailure extends ResumeDetailsLoadingState {
  const ResumeLoadFailure(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}
