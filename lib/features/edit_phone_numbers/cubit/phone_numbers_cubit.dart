import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'phone_numbers_state.dart';

class PhoneNumbersCubit extends Cubit<PhoneNumbersState> {
  PhoneNumbersCubit([phoneNumbers = const []])
      : super(PhoneNumbersState(phoneNumbers));

  addNumber(String phoneNumber) {
    emit(PhoneNumbersState(state.phoneNumbers..add(phoneNumber)));
  }

  deleteNumber(String phoneNumber) {
    emit(PhoneNumbersState(state.phoneNumbers..remove(phoneNumber)));
  }
}
