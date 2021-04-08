import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'paged_response_list_view.dart';
import '../cubit/response_listing_cubit.dart';
import '../repository/detailed_response_repository.dart';
import '../../../data_layer/repository/authentication_repository.dart';
import '../../../data_layer/model/user_type.dart';

class PagedResponsePage extends StatelessWidget {
  const PagedResponsePage({
    Key key,
    this.sender,
    this.responseRepository,
  }) : super(key: key);

  final UserType sender;
  final DetailedResponseRepository responseRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResponseListingCubit(
        userId:
            RepositoryProvider.of<AuthenticationRepository>(context).user.id,
        repository: responseRepository,
      ),
      child: PagedResponseListView(sender: sender),
    );
  }
}
