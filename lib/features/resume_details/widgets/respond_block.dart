import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/resume.dart';
import 'package:helperr/features/response/cubit/responded_cubit.dart';

import 'respond_block_view.dart';

class RespondBlock extends StatelessWidget {
  const RespondBlock({
    Key key,
    this.responded,
    this.resume,
  }) : super(key: key);

  final bool responded;
  final Resume resume;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RespondedCubit(responded: responded),
      child: RespondBlockView(resume: resume),
    );
  }
}
