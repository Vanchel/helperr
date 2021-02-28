import 'package:intl/intl.dart';

DateTime dateFromJson(String str) {
  try {
    return DateTime.parse(str);
  } catch (_) {
    return null;
  }
}

String dateToJson(DateTime date) {
  if (date != null) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
  return '';
}
