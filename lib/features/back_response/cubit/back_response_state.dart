part of 'back_response_cubit.dart';

enum BackResponseStatus { initial, inProgress, failure, success }

class BackResponseState extends Equatable {
  const BackResponseState([this.status = BackResponseStatus.initial]);

  final BackResponseStatus status;

  @override
  List<Object> get props => [status];
}
