import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../widget/vacancy_card.dart';
import '../cubit/vacancy_listing_cubit.dart';
import '../../../data_layer/model/truncated_vacancy.dart';

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
    _pagingController.addPageRequestListener((pageKey) {
      final cubit = BlocProvider.of<VacancyListingCubit>(context);
      cubit.fetchPage(pageKey);
    });
    super.initState();
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
        print('новый стейт пришел');
        (state.nextPageUri != null)
            ? _pagingController.appendPage(state.itemList, state.nextPageUri)
            : _pagingController.appendLastPage(state.itemList);
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
            noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(),
          ),
          pagingController: _pagingController,
          padding: const EdgeInsets.all(12),
          separatorBuilder: (context, index) => const SizedBox(
            height: 12,
          ),
        ),
      ),
    );
  }
}

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    @required this.error,
    this.onTryAgain,
    Key key,
  })  : assert(error != null),
        super(key: key);

  final dynamic error;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Это первая страница, которая не загрузилась: $error'),
            TextButton(onPressed: onTryAgain, child: Text('Попробовать снова')),
          ],
        ),
      ),
    );
  }
}

class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Этот экран говорит вам, что сервер вернул пустой список'),
      ),
    );
  }
}
