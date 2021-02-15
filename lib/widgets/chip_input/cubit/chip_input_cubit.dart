import 'package:bloc/bloc.dart';

class ChipInputCubit extends Cubit<List<String>> {
  ChipInputCubit([List<String> chips = const []]) : super(chips);

  void addChip(String chipText) {
    emit(List.of(state)..add(chipText));
  }

  void removeChip(String chipText) {
    emit(List.of(state)..removeWhere((element) => element == chipText));
  }
}
