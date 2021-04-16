import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/favorite/widgets/empty_screen/empty_favorites_indicator.dart';
import 'package:helperr/features/search/resumes_search/widget/truncated_resume_card.dart';
import 'package:helperr/widgets/error_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../cubit/favorite_resumes_cubit.dart';
import '../../../../data_layer/model/truncated_resume.dart';

class FavoriteResumesView extends StatefulWidget {
  const FavoriteResumesView({Key key}) : super(key: key);

  @override
  _FavoriteResumesViewState createState() => _FavoriteResumesViewState();
}

class _FavoriteResumesViewState extends State<FavoriteResumesView> {
  final _pagingController =
      PagingController<String, TruncatedResume>(firstPageKey: null);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      final cubit = BlocProvider.of<FavoriteResumesCubit>(context);
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
    return BlocListener<FavoriteResumesCubit, FavoriteResumesState>(
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
            itemBuilder: (context, resume, index) =>
                TruncatedResumeCard(resume: resume),
            firstPageErrorIndicatorBuilder: (context) =>
                ErrorScreen(onRetry: () => _pagingController.refresh()),
            noItemsFoundIndicatorBuilder: (context) =>
                EmptyFavoritesIndicator(),
          ),
          pagingController: _pagingController,
          padding: const EdgeInsets.all(12.0),
          separatorBuilder: (context, index) => const SizedBox(height: 12.0),
        ),
      ),
    );
  }
}
