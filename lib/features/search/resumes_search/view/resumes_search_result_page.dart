import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/resume_listing_cubit.dart';
import 'paged_resume_list_view.dart';
import '../../../../data_layer/model/resume_search_options.dart';

class ResumesSearchResultPage extends StatelessWidget {
  const ResumesSearchResultPage({
    Key key,
    @required this.searchOptions,
  }) : super(key: key);

  final ResumeSearchOptions searchOptions;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResumeListingCubit(searchOptions: searchOptions),
      child: PagedResumeListView(),
    );
  }
}
