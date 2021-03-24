import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../widget/truncated_resume_card.dart';
import '../../widget/exception_indicators/error_indicator.dart';
import '../../widget/exception_indicators/empty_list_indicator.dart';

import '../cubit/resume_listing_cubit.dart';
import '../../../../data_layer/model/truncated_resume.dart';

class PagedResumeListView extends StatefulWidget {
  const PagedResumeListView({Key key}) : super(key: key);

  @override
  _PagedResumeListViewState createState() => _PagedResumeListViewState();
}

class _PagedResumeListViewState extends State<PagedResumeListView> {
  final _pagingController =
      PagingController<String, TruncatedResume>(firstPageKey: null);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      final cubit = BlocProvider.of<ResumeListingCubit>(context);
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
    return BlocListener<ResumeListingCubit, ResumeListingState>(
      listener: (context, state) {
        if (state is ResumesFetchSuccessState) {
          (state.nextPageUri != null)
              ? _pagingController.appendPage(state.itemList, state.nextPageUri)
              : _pagingController.appendLastPage(state.itemList);
        } else if (state is ResumesFetchFailureState) {
          _pagingController.error = state.error;
        }
      },
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView.separated(
          builderDelegate: PagedChildBuilderDelegate<TruncatedResume>(
            itemBuilder: (context, resume, index) => TruncatedResumeCard(
              resume: resume,
            ),
            firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
              error: _pagingController.error,
              onTryAgain: () => _pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(),
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
