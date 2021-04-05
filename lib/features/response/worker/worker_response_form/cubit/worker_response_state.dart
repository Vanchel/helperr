part of 'worker_response_cubit.dart';

abstract class WorkerResponseState extends Equatable {
  const WorkerResponseState();

  @override
  List<Object> get props => [];
}

class WorkerResponseInitial extends WorkerResponseState {}

class WorkerResponseInProgress extends WorkerResponseState {}

class WorkerResponseFailure extends WorkerResponseState {}

class WorkerResponseSuccess extends WorkerResponseState {}
