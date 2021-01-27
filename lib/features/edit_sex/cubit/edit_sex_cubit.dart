import 'package:bloc/bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';

class EditSexCubit extends Cubit<Gender> {
  EditSexCubit(Gender initialValue) : super(initialValue);

  void changeSex(Gender gender) {
    emit(gender);
  }
}
