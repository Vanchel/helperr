import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatelessWidget {
  const DateInput({Key key, this.initialValue, this.onValidate, this.labelText})
      : super(key: key);

  final DateTime initialValue;
  final Function(DateTime newValue) onValidate;
  final String labelText;

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
          if (onValidate != null) {
            onValidate(null);
          }
          return null;
        }

        final formattedString = value.split('.').reversed.join();
        if (onValidate != null) {
          onValidate(DateTime.parse(formattedString));
        }
        return null;
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
