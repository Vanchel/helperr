import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/resume.dart';
import 'package:helperr/features/edit_portfolio/cubit/portfolio_cubit.dart';
import 'package:helperr/features/edit_portfolio/view/portfolio_view.dart';

class PortfolioList extends StatelessWidget {
  const PortfolioList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<Portfolio> initialValue;
  final Function(List<Portfolio> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PortfolioCubit(initialValue),
      child: PortfolioView(onChanged: onChanged),
    );
  }
}
