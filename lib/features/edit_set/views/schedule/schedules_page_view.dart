import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:helperr/data_layer/model/schedule.dart';
import 'package:helperr/data_layer/model/weekday.dart';
import 'package:helperr/features/edit_set/cubit/edit_set_cubit.dart';
import 'package:helperr/widgets/custom_back_button.dart';
import 'package:helperr/constants.dart' as c;
import 'package:intl/intl.dart';

import 'edit_schedule_page.dart';

class SchedulesPageView extends StatelessWidget {
  const SchedulesPageView({Key key, @required this.onChanged})
      : super(key: key);

  final void Function(Set<Schedule> newValue) onChanged;

  String _weekday(Weekday day) => Intl.select(day, {
        Weekday.monday: 'Понедельник',
        Weekday.tuesday: 'Вторник',
        Weekday.wednesday: 'Среда',
        Weekday.thursday: 'Четверг',
        Weekday.friday: 'Пятница',
        Weekday.saturday: 'Суббота',
        Weekday.sunday: 'Воскресенье',
      });

  @override
  Widget build(BuildContext context) {
    final saveButton = IconButton(
      icon: const Icon(Icons.check_rounded),
      splashRadius: c.iconButtonSplashRadius,
      onPressed: () {
        onChanged(context.read<EditSetCubit<Schedule>>().state);
        Navigator.pop(context);
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Настроить график'),
        actions: [saveButton],
      ),
      body: BlocBuilder<EditSetCubit<Schedule>, Set<Schedule>>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              final day = weekdayFromInt(index);
              final schedule = state.firstWhere(
                (element) => element.day == day,
                orElse: () => null,
              );

              final subtitle = (schedule != null)
                  ? '${schedule.startTime}-${schedule.endTime}'
                  : 'не указано';

              Widget trailing;
              if (schedule != null) {
                trailing = IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  splashRadius: c.iconButtonSplashRadius,
                  tooltip: 'Очистить',
                  onPressed: () => context
                      .read<EditSetCubit<Schedule>>()
                      .deleteValue(schedule),
                );
              }

              return ListTile(
                title: Text(_weekday(day)),
                subtitle: Text(subtitle),
                trailing: trailing,
                onTap: () {
                  final editedSchedule = (schedule != null)
                      ? schedule
                      : Schedule(
                          day: day,
                          startTime: '00:00',
                          endTime: '00:00',
                        );

                  final onSave = (schedule != null)
                      ? (value) => context
                          .read<EditSetCubit<Schedule>>()
                          .replaceValue(schedule, value)
                      : (value) => context
                          .read<EditSetCubit<Schedule>>()
                          .addValue(value);

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EditSchedulePage(
                        schedule: editedSchedule,
                        onSave: onSave,
                      );
                    },
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
