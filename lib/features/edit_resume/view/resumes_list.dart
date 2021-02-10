import 'package:flutter/material.dart';
import 'package:helperr/data_layer/model/resume.dart';
import 'package:helperr/features/edit_resume/view/edit_resume_page.dart';
import 'package:helperr/widgets/list_action_header.dart';

class ResumesList extends StatelessWidget {
  const ResumesList(this.resumes, {Key key, @required this.onChanged})
      : assert(resumes != null),
        super(key: key);

  final List<Resume> resumes;
  // вызвать перезегрузку профиля с сервера
  final VoidCallback onChanged;

  Widget _buildResumeCard(BuildContext context, Resume resume) {
    final onEdit = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditResumePage(
            onSave: onChanged,
            isEditing: true,
            resume: resume,
          ),
        ),
      );
    };

    return Card(
      child: ListTile(
        title: Text(resume.vacancyName),
        subtitle: Text(resume.salary.toString()),
        trailing: IconButton(
          icon: const Icon(Icons.edit_rounded),
          splashRadius: 24.0,
          onPressed: onEdit,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final onAdd = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditResumePage(
            onSave: onChanged,
            isEditing: false,
          ),
        ),
      );
    };

    final header = ListActionHeader(
      'Ваши резюме',
      actionLabel: 'Новое резюме',
      action: onAdd,
    );

    return Column(
      children: List.generate(
        resumes.length,
        (index) => _buildResumeCard(context, resumes[index]),
      ).toList()
        ..insert(0, header),
    );
  }
}
