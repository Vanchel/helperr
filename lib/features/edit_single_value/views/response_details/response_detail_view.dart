import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/back_response/repository/back_response_repository.dart';
import 'package:helperr/features/back_response/view/back_response_page.dart';
import 'package:helperr/widgets/custom_back_button.dart';
import 'package:intl/intl.dart';

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

  String get _formattedPubDate =>
      DateFormat('dd.MM.yyyy, HH:mm').format(response.dateResponse);

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
    final isRespondable =
        RepositoryProvider.of<AuthenticationRepository>(context)
                .user
                .userType !=
            sender;

    final appBar = AppBar(
      leading: const CustomBackButton(),
      title: Text(sender == UserType.employer ? 'Приглашение' : 'Отклик'),
    );

    final headerTitle = Text(
      sender == UserType.employer ? response.vacancyName : response.cvName,
      style: textTheme.headline5,
    );

    final headerSubtitle = Text(
      'В ответ на: ' +
          (sender == UserType.employer
              ? response.cvName
              : response.vacancyName),
      style: textTheme.subtitle2,
    );

    final fromRow = Row(
      children: [
        Expanded(
          child: Text(
            'От',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
        Text(sender == UserType.employer
            ? response.employerName
            : response.workerName),
      ],
    );

    final toRow = Row(
      children: [
        Expanded(
          child: Text(
            'Кому',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
        Text(sender == UserType.employer
            ? response.workerName
            : response.employerName),
      ],
    );

    final dateRow = Row(
      children: [
        Expanded(
          child: Text(
            'Дата',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
        Text(_formattedPubDate),
      ],
    );

    final spacer = const SizedBox(height: c.defaultMargin);

    final divider = const Divider();

    Widget attachedMessage = Text(
      response.message?.isNotEmpty ?? false
          ? response.message
          : '- Сообщение не приркреплено -',
    );

    Widget footer;
    if (isRespondable) {
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

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(c.scaffoldBodyPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            headerTitle,
            spacer,
            headerSubtitle,
            divider,
            fromRow,
            spacer,
            toRow,
            spacer,
            dateRow,
            divider,
            attachedMessage,
            divider,
            footer,
          ],
        ),
      ),
    );
  }
}
