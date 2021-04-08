import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'back_response_view.dart';
import '../cubit/back_response_cubit.dart';
import '../repository/back_response_repository.dart';
import '../../../data_layer/model/response_state.dart';
import '../../../data_layer/model/response.dart';

class BackResponsePage extends StatelessWidget {
  const BackResponsePage({
    Key key,
    @required this.repository,
    @required this.response,
    @required this.onSave,
  }) : super(key: key);

  final BackResponseRepository repository;
  final Response response;
  final void Function(ResponseState) onSave;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BackResponseCubit(repository),
      child: BackResponseView(
        initialResponse: response,
        onSave: onSave,
      ),
    );
  }
}
