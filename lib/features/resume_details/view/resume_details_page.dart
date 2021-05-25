import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'resume_details_view.dart';
import '../cubit/resume_details_loading_cubit.dart';

class ResumeDetailsPage extends StatelessWidget {
  const ResumeDetailsPage({
    Key key,
    @required this.resumeName,
    @required this.resumeId,
    @required this.onRespond,
    @required this.onFavoriteChanged,
  })  : assert(resumeName != null),
        assert(resumeId != null),
        super(key: key);

  final String resumeName;
  final int resumeId;
  final VoidCallback onRespond;
  final void Function(bool) onFavoriteChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResumeDetailsLoadingCubit(resumeId)..loadResume(),
      child: ResumeDetailsView(
        resumeName: resumeName,
        onRespond: onRespond,
        onFavoriteChanged: onFavoriteChanged,
      ),
    );
  }
}
