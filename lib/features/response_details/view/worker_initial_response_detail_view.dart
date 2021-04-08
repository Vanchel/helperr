import 'package:flutter/material.dart';
import 'package:helperr/features/back_response/repository/back_response_repository.dart';
import 'package:helperr/features/back_response/view/back_response_page.dart';

import '../../../data_layer/model/detailed_response.dart';
import '../../../data_layer/model/response.dart';
import '../../../data_layer/model/response_state.dart';
import '../../../constants.dart' as c;

class WorkerInitialResponseDetailView extends StatelessWidget {
  const WorkerInitialResponseDetailView({
    Key key,
    @required this.response,
    @required this.onChange,
    this.isRespondable = false,
  }) : super(key: key);

  final DetailedResponse response;
  final VoidCallback onChange;
  final bool isRespondable;

  bool get _isTrulyRespondable =>
      isRespondable &&
      response.state != ResponseState.accepted &&
      response.state != ResponseState.declined;

  void toBackResponse(BuildContext context, ResponseState state) {
    final newResponse = Response.fromDetailed(response).copyWith(state: state);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BackResponsePage(
          repository: WorkerInitialResponseRepository(),
          response: newResponse,
          onSave: () {},
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
      title: Text('Отклик'),
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

    Widget respondBackBlock;
    if (_isTrulyRespondable) {
      respondBackBlock = Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            // Text(
            //   'Вы можете послать обратный отклик и принять или отклонить '
            //   'предложение, нажав на одну из кнопок ниже.',
            //   style: textTheme.caption,
            // ),
            // const SizedBox(height: c.defaultMargin),
            Wrap(
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
            ),
          ],
        ),
      );
    } else {
      respondBackBlock = const SizedBox.shrink();
    }

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
