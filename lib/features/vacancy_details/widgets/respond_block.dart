import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/vacancy.dart';
import 'package:helperr/features/response/cubit/responded_cubit.dart';

import 'respond_block_view.dart';

class RespondBlock extends StatelessWidget {
  const RespondBlock({
    Key key,
    this.responded,
    this.vacancy,
  }) : super(key: key);

  final bool responded;
  final Vacancy vacancy;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RespondedCubit(responded: responded),
      child: RespondBlockView(vacancy: vacancy),
    );
  }
}
