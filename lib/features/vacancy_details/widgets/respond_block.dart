import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/vacancy.dart';
import 'package:helperr/features/response/cubit/responded_cubit.dart';

import 'respond_block_view.dart';

class RespondBlock extends StatelessWidget {
  const RespondBlock({
    Key key,
    @required this.responded,
    @required this.vacancy,
    @required this.onResponded,
  }) : super(key: key);

  final bool responded;
  final Vacancy vacancy;
  final VoidCallback onResponded;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RespondedCubit(responded: responded),
      child: RespondBlockView(
        vacancy: vacancy,
        onResponded: onResponded,
      ),
    );
  }
}
