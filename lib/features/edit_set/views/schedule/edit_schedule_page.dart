import 'package:flutter/material.dart';
import 'package:helperr/data_layer/model/schedule.dart';
import 'package:helperr/constants.dart' as c;
import 'package:helperr/data_layer/model/weekday.dart';
import 'package:helperr/widgets/custom_back_button.dart';
import 'package:intl/intl.dart';

class EditSchedulePage extends StatefulWidget {
  EditSchedulePage({
    Key key,
    @required this.onSave,
    @required this.schedule,
  }) : super(key: key);

  final Function(Schedule) onSave;
  final Schedule schedule;

  @override
  _EditSchedulePageState createState() => _EditSchedulePageState();
}

class _EditSchedulePageState extends State<EditSchedulePage> {
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  String _weekday(Weekday day) => Intl.select(day, {
        Weekday.monday: 'Понедельник',
        Weekday.tuesday: 'Вторник',
        Weekday.wednesday: 'Среда',
        Weekday.thursday: 'Четверг',
        Weekday.friday: 'Пятница',
        Weekday.saturday: 'Суббота',
        Weekday.sunday: 'Воскресенье',
      });

  Future<void> _changeTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    TimeOfDay initialTime = TimeOfDay(
      hour: int.parse(controller.text.split(':')[0]),
      minute: int.parse(controller.text.split(':')[1]),
    );

    final newTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
          initialEntryMode: TimePickerEntryMode.input,
        ) ??
        initialTime;

    controller.text = DateFormat('HH:mm')
        .format(DateTime(0, 0, 0, newTime.hour, newTime.minute));
  }

  @override
  void initState() {
    super.initState();
    _startTimeController.text = widget.schedule.startTime;
    _endTimeController.text = widget.schedule.endTime;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    const textInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)),
    );

    final saveButton = IconButton(
      icon: const Icon(Icons.check_rounded),
      splashRadius: c.iconButtonSplashRadius,
      onPressed: () {
        final editedSchedule = widget.schedule.copyWith(
          startTime: _startTimeController.text,
          endTime: _endTimeController.text,
        );
        widget.onSave(editedSchedule);

        Navigator.pop(context);
      },
    );

    final startTimeInput = TextFormField(
      controller: _startTimeController,
      enableInteractiveSelection: false,
      focusNode: AlwaysDisabledFocusNode(),
      style: TextStyle(color: themeData.disabledColor),
      decoration: InputDecoration(
        labelText: 'Начало рабочего дня',
        helperText: '',
        border: textInputBorder,
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: 6.0),
          child: IconButton(
            icon: const Icon(Icons.timer_rounded),
            splashRadius: c.iconButtonSplashRadius,
            onPressed: () async => _changeTime(context, _startTimeController),
          ),
        ),
      ),
    );

    final endTimeInput = TextFormField(
      controller: _endTimeController,
      enableInteractiveSelection: false,
      focusNode: AlwaysDisabledFocusNode(),
      style: TextStyle(color: themeData.disabledColor),
      decoration: InputDecoration(
        labelText: 'Конец рабочего дня',
        helperText: '',
        border: textInputBorder,
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: 6.0),
          child: IconButton(
            icon: const Icon(Icons.timer_rounded),
            splashRadius: c.iconButtonSplashRadius,
            onPressed: () async => _changeTime(context, _endTimeController),
          ),
        ),
      ),
    );

    final commonPrompt = Text(
      'Вы можете указать предпочтительный интервал рабочих часов для '
      'конкретного дня недели.',
      style: themeData.textTheme.caption,
    );

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(_weekday(widget.schedule.day)),
        actions: [saveButton],
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(c.scaffoldBodyPadding),
          children: [
            startTimeInput,
            const SizedBox(height: c.defaultMargin),
            endTimeInput,
            const Divider(),
            commonPrompt,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
