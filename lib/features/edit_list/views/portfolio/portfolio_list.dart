import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'portfolio_view.dart';
import '../../cubit/edit_cubit.dart';
import '../../../../data_layer/model/resume.dart';

class PortfolioList extends StatelessWidget {
  const PortfolioList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<Portfolio> initialValue;
  final void Function(List<Portfolio> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditListCubit(initialValue),
      child: PortfolioView(onChanged: onChanged),
    );
  }
}
