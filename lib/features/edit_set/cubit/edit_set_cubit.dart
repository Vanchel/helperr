import 'package:bloc/bloc.dart';

class EditSetCubit<T> extends Cubit<Set<T>> {
  EditSetCubit(Set<T> initialValue) : super(initialValue);

  void addValue(T value) => emit(Set.of(state)..add(value));

  void deleteValue(T value) => emit(Set.of(state)..remove(value));
}
