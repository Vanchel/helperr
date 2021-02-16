import 'package:bloc/bloc.dart';

class EditSingleValueCubit<T> extends Cubit<T> {
  EditSingleValueCubit(T initialValue) : super(initialValue);

  void changeValue(T value) => emit(value);
}
