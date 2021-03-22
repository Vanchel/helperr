import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/vacancy_listing_cubit.dart';
import '../view/paged_vacancy_list_view.dart';
import '../../../data_layer/model/vacancy_search_options.dart';

class VacanciesSearchResultPage extends StatelessWidget {
  const VacanciesSearchResultPage({
    Key key,
    @required this.searchOptions,
  }) : super(key: key);

  final VacancySearchOptions searchOptions;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VacancyListingCubit(searchOptions: searchOptions),
      child: PagedVacancyListView(),
    );
  }
}
