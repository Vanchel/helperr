import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'loading_state.dart';

class LoadingCubit<T> extends Cubit<LoadingState<T>> {
  LoadingCubit({
    @required Future<T> Function() callback,
  })  : assert(callback != null),
        _callback = callback,
        super(LoadingInitial());

  final Future<T> Function() _callback;

  Future<void> loadValue() async {
    try {
      emit(const LoadInProgress());
      final value = await _callback();
      emit(LoadSuccess(value));
    } catch (e) {
      emit(LoadFailure(e));
    }
  }
}
