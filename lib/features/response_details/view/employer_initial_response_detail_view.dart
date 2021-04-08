import 'package:flutter/material.dart';

import '../../../data_layer/model/detailed_response.dart';
import '../../../data_layer/model/response_state.dart';
import '../../../constants.dart' as c;

class EmployerInitialResponseDetailView extends StatelessWidget {
  const EmployerInitialResponseDetailView({
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final appBar = AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        splashRadius: c.iconButtonSplashRadius,
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('Приглашение'),
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
            Text(
              'Вы можете послать обратный отклик и принять или отклонить '
              'предложение, нажав на кнопку ниже.',
              style: textTheme.caption,
            ),
            const SizedBox(height: c.defaultMargin),
            ElevatedButton(
              child: const Text('Откликнуться'),
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text('Ну хоть что-то'),
                  ));
              },
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
