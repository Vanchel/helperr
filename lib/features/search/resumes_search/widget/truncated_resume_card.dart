import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/truncated_resume.dart';
import 'package:helperr/features/search/resumes_search/widget/truncated_resume_card_view.dart';

import '../../cubit/card_actions_cubit.dart';

class TruncatedResumeCard extends StatelessWidget {
  const TruncatedResumeCard({Key key, @required this.resume}) : super(key: key);

  final TruncatedResume resume;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardActionsCubit(
        responded: resume.gotResponsed,
        favorited: resume.favorited,
      ),
      child: TruncatedResumeCardView(resume: resume),
    );
  }
}
