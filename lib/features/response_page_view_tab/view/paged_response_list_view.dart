import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../cubit/response_listing_cubit.dart';
import '../widget/error_screens/empty_response_list_indicator.dart';
import '../../../data_layer/model/detailed_response.dart';
import '../../../widgets/error_screen.dart';

typedef BuilderDelegate = Widget Function(
  BuildContext context,
  DetailedResponse response,
);

class PagedResponseListView extends StatefulWidget {
  const PagedResponseListView({
    Key key,
    @required this.builder,
  }) : super(key: key);

  final BuilderDelegate builder;

  @override
  _PagedResponseListViewState createState() => _PagedResponseListViewState();
}

class _PagedResponseListViewState extends State<PagedResponseListView> {
  final _pagingController =
      PagingController<String, DetailedResponse>(firstPageKey: null);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      final cubit = BlocProvider.of<ResponseListingCubit>(context);
      cubit.fetchPage(pageUri: pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResponseListingCubit, ResponseListingState>(
      listener: (context, state) {
        if (state is ResponsesFetchSuccess) {
          (state.nextPageUri != null)
              ? _pagingController.appendPage(state.itemList, state.nextPageUri)
              : _pagingController.appendLastPage(state.itemList);
        } else if (state is ResponsesFetchFailure) {
          _pagingController.error = state.error;
        }
      },
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView.separated(
          builderDelegate: PagedChildBuilderDelegate<DetailedResponse>(
            itemBuilder: (context, response, index) =>
                widget.builder(context, response),
            firstPageErrorIndicatorBuilder: (context) => ErrorScreen(
              onRetry: () => _pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (context) =>
                EmptyResponseListIndicator(),
          ),
          pagingController: _pagingController,
          separatorBuilder: (context, index) => const Divider(height: 1),
        ),
      ),
    );
  }
}
