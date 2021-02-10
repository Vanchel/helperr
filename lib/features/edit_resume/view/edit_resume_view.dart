import 'package:flutter/material.dart';
import 'package:helperr/data_layer/model/resume.dart';

class EditResumeView extends StatefulWidget {
  EditResumeView({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.resume,
  }) : super(key: key);

  final VoidCallback onSave;
  final bool isEditing;
  final Resume resume;

  @override
  _EditResumeViewState createState() => _EditResumeViewState();
}

class _EditResumeViewState extends State<EditResumeView> {
  @override
  // TODO: start from here
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Пока не готово')),
      body: Center(child: Text('Ты думал, тут что-то будет?')),
    );
  }
}
