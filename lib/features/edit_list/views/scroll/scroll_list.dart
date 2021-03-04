import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'scroll_view.dart';
import '../../cubit/edit_list_cubit.dart';
import '../../../../data_layer/model/scroll.dart';

class ScrollsList extends StatelessWidget {
  const ScrollsList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<Scroll> initialValue;
  final void Function(List<Scroll> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditListCubit(initialValue),
      child: ScrollsView(onChanged: onChanged),
    );
  }
}
