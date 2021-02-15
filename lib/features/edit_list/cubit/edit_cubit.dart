import 'package:bloc/bloc.dart';

class EditListCubit<T> extends Cubit<List<T>> {
  EditListCubit(List<T> initialValue) : super(initialValue);

  void addValue(T value) => emit(List.of(state)..add(value));

  void editValue(T editedValue, int index) =>
      emit(List.of(state)..[index] = editedValue);

  void deleteValue(int valueIndex) =>
      emit(List.of(state)..removeAt(valueIndex));
}
