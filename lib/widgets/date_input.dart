import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatelessWidget {
  const DateInput({
    Key key,
    this.initialValue,
    this.validator,
    this.onValidate,
    this.labelText,
  }) : super(key: key);

  final DateTime initialValue;
  final String Function(DateTime) validator;
  final Function(DateTime newValue) onValidate;
  final String labelText;

  String _performValidation(DateTime date) {
    final result = validator?.call(date);
    if (onValidate != null && result == null) {
      onValidate(null);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate;
    if (initialValue != null) {
      formattedDate = DateFormat('dd.MM.yyyy').format(initialValue);
    } else {
      formattedDate = '';
    }

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)));

    final datePicker = Container(
      margin: const EdgeInsets.only(right: 6.0),
      child: IconButton(
        icon: const Icon(Icons.calendar_today_rounded),
        splashRadius: 24.0,
        onPressed: null,
      ),
    );

    final validator = (value) {
      try {
        if (value == '') {
          return _performValidation(null);
        }

        final formattedString = value.split('.').reversed.join();
        final finalDate = DateTime.parse(formattedString);

        return _performValidation(finalDate);
      } catch (_) {
        return 'Неверный формат даты.';
      }
    };

    return TextFormField(
      initialValue: formattedDate,
      keyboardType: TextInputType.datetime,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: 'дд.мм.гггг',
        helperText: '',
        border: textInputBorder,
        suffixIcon: datePicker,
      ),
    );
  }
}
