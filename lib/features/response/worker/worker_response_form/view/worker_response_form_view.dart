import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/widgets/custom_back_button.dart';

import '../cubit/worker_response_cubit.dart';
import '../../../../../constants.dart' as c;
import '../../../../../data_layer/model/response.dart';
import '../../../../../data_layer/model/resume.dart';
import '../../../../../features/edit_single_value/views/resume/select_resume.dart';

class WorkerResponseFormView extends StatefulWidget {
  WorkerResponseFormView({
    Key key,
    @required this.onSave,
    @required this.vacancyId,
    @required this.employerId,
    @required this.resumes,
  }) : super(key: key);

  final VoidCallback onSave;
  final int vacancyId;
  final int employerId;
  final List<Resume> resumes;

  @override
  _WorkerResponseFormViewState createState() => _WorkerResponseFormViewState();
}

class _WorkerResponseFormViewState extends State<WorkerResponseFormView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Resume _selectedResume;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)));

    final resumeInput = SelectResume(
      resumes: widget.resumes,
      onChanged: (newValue) => _selectedResume = newValue,
    );

    final messageInput = TextFormField(
      keyboardType: TextInputType.multiline,
      maxLength: 400,
      minLines: 4,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: 'Сопроводительное письмо',
        hintText: 'Уж я-то вам точно пригожусь.',
        helperText: '',
        border: textInputBorder,
      ),
      onSaved: (newValue) => _message = newValue,
    );

    final commonPrompt = Text(
      'После того, как Вы откликнетесь на вакансию, '
      'работодатель сможет рассмотреть Вашу кандидатуру и прислать '
      'ответный отклик на указанное резюме.',
      style: textTheme.caption,
    );

    final onSubmitPressed = () {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        final workerResponse = Response(
          vacancyId: widget.vacancyId,
          employerId: widget.employerId,
          resumeId: _selectedResume.id,
          workerId: _selectedResume.userId,
          message: _message,
        );
        context.read<WorkerResponseCubit>().addResponse(workerResponse);
      }
    };

    final progressIndicator =
        BlocBuilder<WorkerResponseCubit, WorkerResponseState>(
      builder: (context, state) {
        return (state is WorkerResponseInProgress)
            ? const LinearProgressIndicator()
            : const SizedBox.shrink();
      },
    );

    final submitButton = BlocBuilder<WorkerResponseCubit, WorkerResponseState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.check_rounded),
          splashRadius: c.iconButtonSplashRadius,
          onPressed:
              !(state is WorkerResponseInProgress) ? onSubmitPressed : null,
        );
      },
    );

    final appBar = AppBar(
      leading: const CustomBackButton(),
      title: const Text('Откликнуться'),
      actions: [submitButton],
      bottom: PreferredSize(
        child: progressIndicator,
        preferredSize: const Size.fromHeight(4.0),
      ),
    );

    final listener = (BuildContext context, WorkerResponseState state) {
      if (state is WorkerResponseFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: Colors.black54,
              content: Text('Не удалось отправить отклик'),
            ),
          );
      } else if (state is WorkerResponseSuccess) {
        widget.onSave();
        Navigator.pop(context);
      }
    };

    return Scaffold(
      appBar: appBar,
      body: BlocListener<WorkerResponseCubit, WorkerResponseState>(
        listener: listener,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(c.scaffoldBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                resumeInput,
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
