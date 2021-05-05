part of 'loading_cubit.dart';

abstract class LoadingState<T> extends Equatable {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class LoadingInitial<T> extends LoadingState<T> {
  const LoadingInitial();
}

class LoadInProgress<T> extends LoadingState<T> {
  const LoadInProgress();
}

class LoadFailure<T> extends LoadingState<T> {
  const LoadFailure(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}

class LoadSuccess<T> extends LoadingState<T> {
  const LoadSuccess(this.value);

  final T value;

  @override
  String toString() {
    return 'Value loaded: $value';
  }
}
