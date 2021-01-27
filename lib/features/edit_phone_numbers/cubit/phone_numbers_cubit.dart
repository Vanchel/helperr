import 'package:bloc/bloc.dart';

class PhoneNumbersCubit extends Cubit<List<String>> {
  PhoneNumbersCubit([phoneNumbers = const []]) : super(phoneNumbers);

  void addNumber(String phoneNumber) {
    emit(List.of(state)..add(phoneNumber));
  }

  void deleteNumber(String phoneNumber) {
    emit(List.of(state)..remove(phoneNumber));
  }
}
