import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:helperr/data_layer/model/schedule.dart';
import 'package:helperr/features/edit_set/cubit/edit_set_cubit.dart';

import 'schedules_page_view.dart';

class SchedulesPage extends StatelessWidget {
  const SchedulesPage({Key key, this.initialValue = const {}, this.onChanged})
      : super(key: key);

  final Set<Schedule> initialValue;
  final void Function(Set<Schedule> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSetCubit(initialValue),
      child: SchedulesPageView(onChanged: onChanged),
    );
  }
}
