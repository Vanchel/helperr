part of 'load_resumes_cubit.dart';

abstract class LoadResumesState extends Equatable {
  const LoadResumesState();

  @override
  List<Object> get props => [];
}

class ResumesLoadInProgress extends LoadResumesState {}

class ResumesLoadFailure extends LoadResumesState {
  const ResumesLoadFailure(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}

class ResumesLoadSuccess extends LoadResumesState {
  const ResumesLoadSuccess(this.resumes);

  final List<Resume> resumes;

  @override
  String toString() => 'Successfully loaded ${resumes.length} resumes';

  @override
  List<Object> get props => [resumes];
}
