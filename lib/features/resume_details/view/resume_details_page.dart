import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'resume_details_view.dart';
import '../cubit/resume_details_loading_cubit.dart';

class ResumeDetailsPage extends StatelessWidget {
  const ResumeDetailsPage({
    Key key,
    // TODO: уточнить подробнее, а лучше вынести этот кусочек с ифнормацией
    // о профиле в отдельный виджет
    @required this.resumeName,
    @required this.resumeId,
    this.isResponded = false,
    this.isInFavorite = false,
  })  : assert(resumeName != null),
        assert(resumeId != null),
        assert(isResponded != null),
        assert(isInFavorite != null),
        super(key: key);

  final String resumeName;
  final int resumeId;
  final bool isResponded;
  final bool isInFavorite;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResumeDetailsLoadingCubit(resumeId)..loadResume(),
      child: ResumeDetailsView(
        resumeName: resumeName,
        isResponded: isResponded,
        isInFavorite: isInFavorite,
      ),
    );
  }
}
