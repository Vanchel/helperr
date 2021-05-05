import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/search/vacancies_search/widget/truncated_vacancy_card.dart';
import 'package:helperr/widgets/error_screen/error_indicator.dart';
import 'package:helperr/widgets/error_screen/no_favorites_indicator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../cubit/favorite_vacancies_cubit.dart';
import '../../../../data_layer/model/truncated_vacancy.dart';

class FavoriteVacanciesView extends StatefulWidget {
  const FavoriteVacanciesView({Key key}) : super(key: key);

  @override
  _FavoriteVacanciesViewState createState() => _FavoriteVacanciesViewState();
}

class _FavoriteVacanciesViewState extends State<FavoriteVacanciesView> {
  final _pagingController =
      PagingController<String, TruncatedVacancy>(firstPageKey: null);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      final cubit = BlocProvider.of<FavoriteVacanciesCubit>(context);
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
    return BlocListener<FavoriteVacanciesCubit, FavoriteVacanciesState>(
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
            itemBuilder: (context, vacancy, index) =>
                TruncatedVacancyCard(vacancy: vacancy),
            firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
              error: _pagingController.error,
              onTryAgain: () => _pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (context) => NoFavoritesIndicator(),
          ),
          pagingController: _pagingController,
          padding: const EdgeInsets.all(12.0),
          separatorBuilder: (context, index) => const SizedBox(height: 12.0),
        ),
      ),
    );
  }
}
