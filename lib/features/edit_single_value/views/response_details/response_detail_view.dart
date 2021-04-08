import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/back_response/repository/back_response_repository.dart';
import 'package:helperr/features/back_response/view/back_response_page.dart';

import '../../../../data_layer/model/models.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/detailed_response.dart';
import '../../../../data_layer/model/response.dart';
import '../../../../data_layer/model/response_state.dart';
import '../../../../data_layer/model/user_type.dart';
import '../../../../data_layer/repository/authentication_repository.dart';
import '../../../../constants.dart' as c;

class ResponseDetailView extends StatelessWidget {
  const ResponseDetailView({
    Key key,
    @required this.response,
    @required this.sender,
    @required this.onChange,
  })  : repository = (sender == UserType.employer)
            ? const EmployerInitialResponseRepository()
            : const WorkerInitialResponseRepository(),
        super(key: key);

  final DetailedResponse response;
  final UserType sender;
  final void Function(ResponseState) onChange;
  final BackResponseRepository repository;

  bool _isRespondable(BuildContext context) {
    final userType =
        RepositoryProvider.of<AuthenticationRepository>(context).user.userType;

    return userType != sender;
  }

  void toBackResponse(BuildContext context, ResponseState state) {
    final newResponse = Response.fromDetailed(response).copyWith(state: state);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BackResponsePage(
          repository: repository,
          response: newResponse,
          onSave: onChange,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final appBar = AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        splashRadius: c.iconButtonSplashRadius,
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(sender == UserType.employer ? 'Приглашение' : 'Отклик'),
    );

    final responseFrom = Row(
      children: [
        Expanded(
          child: Text(
            'От:',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // should be text button or smth one day
        Text(response.workerName),
      ],
    );

    final responseFor = Row(
      children: [
        Expanded(
          child: Text(
            'На:',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // should be text button or smth one day
        Text(response.vacancyName),
      ],
    );

    final spacer = const SizedBox(height: c.defaultMargin);

    Widget attachedMessage;
    if (response.message?.isNotEmpty ?? false) {
      attachedMessage = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Приложенное письмо:', style: textTheme.bodyText1),
          Text(response.message),
        ],
      );
    }

    // refactor this?
    Widget footer;
    if (_isRespondable(context)) {
      footer = BlocBuilder<EditSingleValueCubit<ResponseState>, ResponseState>(
        builder: (context, state) {
          if (state == ResponseState.sent) {
            return Wrap(
              alignment: WrapAlignment.end,
              spacing: c.defaultMargin,
              runSpacing: c.defaultMargin,
              children: [
                OutlinedButton(
                  child: Text('Отклонить'.toUpperCase()),
                  onPressed: () =>
                      toBackResponse(context, ResponseState.declined),
                ),
                ElevatedButton(
                  child: Text('Принять'.toUpperCase()),
                  onPressed: () =>
                      toBackResponse(context, ResponseState.accepted),
                ),
              ],
            );
          } else if (state == ResponseState.accepted) {
            return Text(
              'Собеседник принял Ваше предложение. Обмен откликами завершен.',
              style: textTheme.caption,
            );
          } else if (state == ResponseState.declined) {
            return Text(
              'Собеседник отказался от Вашего предложения. Обмен откликами '
              'завершен.',
              style: textTheme.caption,
            );
          } else {
            return Text(
              'Вы уже дали ответ на это предложение.',
              style: textTheme.caption,
            );
          }
        },
      );
    } else {
      footer = BlocBuilder<EditSingleValueCubit<ResponseState>, ResponseState>(
        builder: (context, state) {
          if (state == ResponseState.sent) {
            return Text(
              'Собеседник пока не дал ответа.',
              style: textTheme.caption,
            );
          } else if (state == ResponseState.accepted) {
            return Text(
              'Вы ответили согласием на это предложение.',
              style: textTheme.caption,
            );
          } else if (state == ResponseState.declined) {
            return Text(
              'Вы ответили отказом на это предложение.',
              style: textTheme.caption,
            );
          } else {
            return Text(
              'Собеседник уже дал ответ на Ваше предложение. Проверьте '
              'вкладку "Входящие".',
              style: textTheme.caption,
            );
          }
        },
      );
    }

    final respondBackBlock = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        footer,
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(c.scaffoldBodyPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            responseFrom,
            spacer,
            responseFor,
            spacer,
            attachedMessage,
            respondBackBlock,
          ],
        ),
      ),
    );
  }
}
