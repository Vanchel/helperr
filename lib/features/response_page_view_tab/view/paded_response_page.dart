import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'paged_response_list_view.dart';
import '../cubit/response_listing_cubit.dart';
import '../repository/detailed_response_repository.dart';
import '../../../data_layer/model/models.dart';

typedef BuilderDelegate = Widget Function(
  BuildContext context,
  DetailedResponse response,
);

class PagedResponsePage extends StatelessWidget {
  const PagedResponsePage({
    Key key,
    this.userId,
    this.responseRepository,
    this.builder,
  }) : super(key: key);

  final int userId;
  final DetailedResponseRepository responseRepository;
  final BuilderDelegate builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResponseListingCubit(
        userId: userId,
        repository: responseRepository,
      ),
      child: PagedResponseListView(builder: builder),
    );
  }
}
