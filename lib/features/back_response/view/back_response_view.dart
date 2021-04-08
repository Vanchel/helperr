import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/constants.dart' as c;

import '../cubit/back_response_cubit.dart';
import '../../../data_layer/model/response.dart';
import '../../../data_layer/model/response_state.dart';

class BackResponseView extends StatefulWidget {
  BackResponseView({
    Key key,
    @required this.initialResponse,
    @required this.onSave,
  }) : super(key: key);

  final Response initialResponse;
  final void Function(ResponseState) onSave;

  @override
  _BackResponseViewState createState() => _BackResponseViewState();
}

class _BackResponseViewState extends State<BackResponseView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _message = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)));

    final messageInput = TextFormField(
      keyboardType: TextInputType.multiline,
      maxLength: 400,
      minLines: 4,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: 'Сопроводительное письмо',
        hintText: 'Очень интересное предложение.',
        helperText: '',
        border: textInputBorder,
      ),
      onSaved: (newValue) => _message = newValue,
    );

    final commonPrompt = Text(
      'Вы можете приложить к ответному отклику сопроводительное письмо. '
      'Имейте в виду: после отправки ответа отклик будет считаться '
      'завершенным. Так что изложите собеседнику в письме всю информацию, '
      'которую считаете нужной (например, способ дальнейшего общения).',
      style: textTheme.caption,
    );

    final backButton = IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: c.iconButtonSplashRadius,
      onPressed: () => Navigator.pop(context),
    );

    final onSubmitPressed = () {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        final backResponse = widget.initialResponse.copyWith(message: _message);
        context.read<BackResponseCubit>().respond(backResponse);
      }
    };

    final progressIndicator = BlocBuilder<BackResponseCubit, BackResponseState>(
      builder: (context, state) {
        return (state.status == BackResponseStatus.inProgress)
            ? const LinearProgressIndicator()
            : const SizedBox.shrink();
      },
    );

    final submitButton = BlocBuilder<BackResponseCubit, BackResponseState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.check_rounded),
          splashRadius: c.iconButtonSplashRadius,
          onPressed: !(state.status == BackResponseStatus.inProgress)
              ? onSubmitPressed
              : null,
        );
      },
    );

    final appBar = AppBar(
      leading: backButton,
      title: const Text('Ответ'),
      actions: [submitButton],
      bottom: PreferredSize(
        child: progressIndicator,
        preferredSize: const Size.fromHeight(4.0),
      ),
    );

    final listener = (BuildContext context, BackResponseState state) {
      if (state.status == BackResponseStatus.failure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: Colors.black54,
              content: Text('Не удалось отправить ответный отклик'),
            ),
          );
      } else if (state.status == BackResponseStatus.success) {
        widget.onSave(widget.initialResponse.state);
        Navigator.pop(context);
      }
    };

    return Scaffold(
      appBar: appBar,
      body: BlocListener<BackResponseCubit, BackResponseState>(
        listener: listener,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(c.scaffoldBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                messageInput,
                const Divider(),
                commonPrompt,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
