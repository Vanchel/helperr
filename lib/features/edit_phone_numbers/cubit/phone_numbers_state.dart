part of 'phone_numbers_cubit.dart';

class PhoneNumbersState extends Equatable {
  const PhoneNumbersState([this.phoneNumbers = const []]);

  final List<String> phoneNumbers;

  @override
  List<Object> get props => [phoneNumbers];
}
