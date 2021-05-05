import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/widgets/error_screen/error_indicator.dart';
import 'package:helperr/widgets/error_screen/no_search_results_indicator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../widget/truncated_vacancy_card.dart';

import '../cubit/vacancy_listing_cubit.dart';
import '../../../../data_layer/model/truncated_vacancy.dart';

class PagedVacancyListView extends StatefulWidget {
  const PagedVacancyListView({Key key}) : super(key: key);

  @override
  _PagedVacancyListViewState createState() => _PagedVacancyListViewState();
}

class _PagedVacancyListViewState extends State<PagedVacancyListView> {
  final _pagingController =
      PagingController<String, TruncatedVacancy>(firstPageKey: null);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      final cubit = BlocProvider.of<VacancyListingCubit>(context);
      cubit.fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VacancyListingCubit, VacancyListingState>(
      listener: (context, state) {
        if (state is VacanciesFetchSuccessState) {
          (state.nextPageUri != null)
              ? _pagingController.appendPage(state.itemList, state.nextPageUri)
              : _pagingController.appendLastPage(state.itemList);
        } else if (state is VacanciesFetchFailureState) {
          _pagingController.error = state.error;
        }
      },
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView.separated(
          builderDelegate: PagedChildBuilderDelegate<TruncatedVacancy>(
            itemBuilder: (context, vacancy, index) => TruncatedVacancyCard(
              vacancy: vacancy,
            ),
            firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
              error: _pagingController.error,
              onTryAgain: () => _pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (context) =>
                NoSearchResultsIndicator(),
          ),
          pagingController: _pagingController,
          padding: const EdgeInsets.all(12.0),
          separatorBuilder: (context, index) => const SizedBox(
            height: 12.0,
          ),
        ),
      ),
    );
  }
}
