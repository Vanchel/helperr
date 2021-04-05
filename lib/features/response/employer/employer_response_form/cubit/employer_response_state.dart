part of 'employer_response_cubit.dart';

abstract class EmployerResponseState extends Equatable {
  const EmployerResponseState();

  @override
  List<Object> get props => [];
}

class EmployerResponseInitial extends EmployerResponseState {}

class EmployerResponseInProgress extends EmployerResponseState {}

class EmployerResponseFailure extends EmployerResponseState {}

class EmployerResponseSuccess extends EmployerResponseState {}
