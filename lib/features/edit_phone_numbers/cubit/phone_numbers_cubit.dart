import 'package:bloc/bloc.dart';

class PhoneNumbersCubit extends Cubit<List<String>> {
  PhoneNumbersCubit([phoneNumbers = const []]) : super(phoneNumbers);

  addNumber(String phoneNumber) {
    emit(List.of(state)..add(phoneNumber));
  }

  deleteNumber(String phoneNumber) {
    emit(List.of(state)..remove(phoneNumber));
  }
}
