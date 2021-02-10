part of 'edit_resume_cubit.dart';

abstract class EditResumeState extends Equatable {
  const EditResumeState();

  @override
  List<Object> get props => [];
}

class EditResumeInitial extends EditResumeState {}

class ResumeChangeInProgress extends EditResumeState {}

class ResumeChangeSuccess extends EditResumeState {}

class ResumeChangeFailure extends EditResumeState {}
