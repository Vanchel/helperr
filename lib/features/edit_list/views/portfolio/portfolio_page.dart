import 'package:flutter/material.dart';
import 'package:helperr/data_layer/model/resume.dart';

class EditPortfolioPage extends StatefulWidget {
  EditPortfolioPage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.portfolio,
  }) : super(key: key);

  final Function(Portfolio) onSave;
  final bool isEditing;
  final Portfolio portfolio;

  @override
  _EditPortfolioPageState createState() => _EditPortfolioPageState();
}

class _EditPortfolioPageState extends State<EditPortfolioPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _sourceLink;
  String _imageLink;

  bool _isValidLink(String str) {
    String pattern =
        r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)));

    final backButton = IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: 24.0,
      onPressed: () => Navigator.pop(context),
    );

    final saveButton = IconButton(
      icon: const Icon(Icons.check_rounded),
      splashRadius: 24.0,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();

          final editedPortfolio = Portfolio(
            sourceLink: _sourceLink,
            imgLink: _imageLink,
          );
          widget.onSave(editedPortfolio);

          Navigator.pop(context);
        }
      },
    );

    final sourceLinkInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.portfolio.sourceLink : '',
        autofocus: !widget.isEditing,
        keyboardType: TextInputType.url,
        decoration: const InputDecoration(
          labelText: 'Ссылка на ресурс',
          hintText: 'https://github.com/profile_name',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _sourceLink = newValue,
        validator: (value) {
          if (value.isEmpty) {
            return 'Поле не дожно быть пустым.';
          }
          if (!_isValidLink(value)) {
            return 'Укажите корректный URL.';
          }
          return null;
        },
      ),
    );

    final imageLinkInput = Container(
      child: TextFormField(
        initialValue: widget.isEditing ? widget.portfolio.imgLink : '',
        autofocus: !widget.isEditing,
        keyboardType: TextInputType.url,
        decoration: const InputDecoration(
          labelText: 'Ссылка на обложку',
          hintText: 'https://i.imgur.com/my_portfolio_cover.png',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _imageLink = newValue,
        validator: (value) {
          if (!_isValidLink(value)) {
            return 'Укажите корректный URL.';
          }
          return null;
        },
      ),
    );

    final divider = const Divider();

    final commonPrompt = Container(
      child: Text(
        'Если у Вас есть аккаунт на каком-либо ресурсе, в большей степени '
        'ориентированном на Вашу профессиональную область, можете указать '
        'ссылку на ваш профиль на этом ресурсе здесь. Так работодатель '
        'сможет узнать больше о Вашей компетенции.\n Также Вы можете '
        'прикрепить ссылку на любую картинку, которая будет выступать '
        'в качестве обложки портфолио.',
        style: themeData.textTheme.caption,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: backButton,
        title: Text(
          widget.isEditing ? 'Изменить портфолио' : 'Добавить портфолио',
        ),
        actions: [saveButton],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sourceLinkInput,
              imageLinkInput,
              divider,
              commonPrompt,
            ],
          ),
        ),
      ),
    );
  }
}
