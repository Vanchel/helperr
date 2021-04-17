import 'package:flutter/material.dart';
import 'package:helperr/widgets/custom_back_button.dart';

import '../points_input/points_input_widget.dart';
import '../../../../data_layer/model/scroll.dart';
import '../../../../constants.dart' as constants;

class EditScrollPage extends StatefulWidget {
  EditScrollPage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.scroll,
  }) : super(key: key);

  final Function(Scroll) onSave;
  final bool isEditing;
  final Scroll scroll;

  @override
  _EditScrollPageState createState() => _EditScrollPageState();
}

class _EditScrollPageState extends State<EditScrollPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title;
  String _subtitle;
  List<String> _points;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)));

    final saveButton = IconButton(
      icon: const Icon(Icons.check_rounded),
      splashRadius: 24.0,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();

          final editedScroll = Scroll(
            title: _title,
            subtitle: _subtitle,
            points: _points,
          );
          widget.onSave(editedScroll);

          Navigator.pop(context);
        }
      },
    );

    final titleInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.scroll.title : '',
        autofocus: !widget.isEditing,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Заголовок',
          hintText: 'Укажите заколовок перечня',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _title = newValue,
        validator: (value) {
          if (value.isEmpty) {
            return 'Поле не дожно быть пустым.';
          }
          return null;
        },
      ),
    );

    final subtitleInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.scroll.subtitle : '',
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Подзаголовок',
          hintText: 'Пояснение к заголовку',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _subtitle = newValue,
      ),
    );

    final pointsInput = PointsInput(
      initialValue: widget.isEditing ? widget.scroll.points : [],
      onChanged: (newValue) => _points = newValue,
      labelText: 'Добавить пункт',
      hintText: 'Пункт',
    );

    final divider = const Divider();

    final commonPrompt = Container(
      child: Text(
        'Вы можете указать в описании вакансии некоторое сведения, которые '
        'удобнее представить в виде списка. Например, требования к кандидату '
        'или условия работы.',
        style: themeData.textTheme.caption,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(
          widget.isEditing ? 'Изменить перечень' : 'Добавить перечень',
        ),
        actions: [saveButton],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(constants.scaffoldBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleInput,
              subtitleInput,
              pointsInput,
              divider,
              commonPrompt,
            ],
          ),
        ),
      ),
    );
  }
}
