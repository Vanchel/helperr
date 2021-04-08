import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detailed_response_list_item_view.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/detailed_response.dart';
import '../../../../data_layer/model/user_type.dart';

class DetailedResponseListItem extends StatelessWidget {
  const DetailedResponseListItem({
    Key key,
    this.response,
    this.sender,
  }) : super(key: key);

  final DetailedResponse response;
  final UserType sender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSingleValueCubit(response.state),
      child: DetailedResponseListItemView(
        response: response,
        sender: sender,
      ),
    );
  }
}
