import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/employer_response_cubit.dart';
import '../../../../../constants.dart' as c;
import '../../../../../data_layer/model/response.dart';
import '../../../../../data_layer/model/vacancy.dart';
import '../../../../edit_single_value/views/vacancy/select_vacancy.dart';

class EmployerResponseFormView extends StatefulWidget {
  EmployerResponseFormView({
    Key key,
    @required this.onSave,
    @required this.resumeId,
    @required this.workerId,
    @required this.vacancies,
  }) : super(key: key);

  final VoidCallback onSave;
  final int resumeId;
  final int workerId;
  final List<Vacancy> vacancies;

  @override
  _EmployerResponseFormViewState createState() =>
      _EmployerResponseFormViewState();
}

class _EmployerResponseFormViewState extends State<EmployerResponseFormView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Vacancy _selectedVacancy;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)));

    final vacancyInput = SelectVacancy(
      vacancies: widget.vacancies,
      onChanged: (newValue) => _selectedVacancy = newValue,
    );

    final messageInput = TextFormField(
      keyboardType: TextInputType.multiline,
      maxLength: 400,
      minLines: 4,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: 'Сопроводительное письмо',
        hintText: 'Мы считаем, что Вы нам подходите.',
        helperText: '',
        border: textInputBorder,
      ),
      onSaved: (newValue) => _message = newValue,
    );

    final commonPrompt = Text(
      'После того, как Вы предложите соискателю вакансию, '
      'он сможет рассмотреть Ваше предложение и прислать '
      'ответный отклик на указанную вакансию.',
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

        final employerResponse = Response(
          vacancyId: _selectedVacancy.id,
          employerId: _selectedVacancy.userId,
          resumeId: widget.resumeId,
          workerId: widget.workerId,
          message: _message,
        );
        context.read<EmployerResponseCubit>().addResponse(employerResponse);
      }
    };

    final progressIndicator =
        BlocBuilder<EmployerResponseCubit, EmployerResponseState>(
      builder: (context, state) {
        return (state is EmployerResponseInProgress)
            ? const LinearProgressIndicator()
            : const SizedBox.shrink();
      },
    );

    final submitButton =
        BlocBuilder<EmployerResponseCubit, EmployerResponseState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.check_rounded),
          splashRadius: c.iconButtonSplashRadius,
          onPressed:
              !(state is EmployerResponseInProgress) ? onSubmitPressed : null,
        );
      },
    );

    final appBar = AppBar(
      leading: backButton,
      title: const Text('Пригласить'),
      actions: [submitButton],
      bottom: PreferredSize(
        child: progressIndicator,
        preferredSize: const Size.fromHeight(4.0),
      ),
    );

    final listener = (BuildContext context, EmployerResponseState state) {
      if (state is EmployerResponseFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: Colors.black54,
              content: Text('Не удалось отправить приглашение'),
            ),
          );
      } else if (state is EmployerResponseSuccess) {
        widget.onSave();
        Navigator.pop(context);
      }
    };

    return Scaffold(
      appBar: appBar,
      body: BlocListener<EmployerResponseCubit, EmployerResponseState>(
        listener: listener,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(c.scaffoldBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                vacancyInput,
                const SizedBox(height: c.defaultMargin),
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
