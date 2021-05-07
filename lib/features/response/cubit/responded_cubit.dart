import 'package:bloc/bloc.dart';

class RespondedCubit extends Cubit<bool> {
  RespondedCubit({bool responded}) : super(responded ?? false);

  void respond() => emit(true);
}
