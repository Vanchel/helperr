import 'package:intl/intl.dart';

DateTime dateFromJson(String str) {
  return DateTime.tryParse(str);
}

String dateToJson(DateTime date) {
  if (date != null) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
  return '';
}
