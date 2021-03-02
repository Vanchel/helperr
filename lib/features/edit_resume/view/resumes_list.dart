import 'package:flutter/material.dart';
import 'package:helperr/data_layer/model/models.dart';
import 'package:helperr/data_layer/model/resume.dart';
import 'package:helperr/features/edit_resume/view/edit_resume_page.dart';
import 'package:helperr/widgets/list_action_header.dart';

class ResumesList extends StatelessWidget {
  const ResumesList(this.resumes, {Key key, @required this.onChanged})
      : assert(resumes != null),
        super(key: key);

  final List<Resume> resumes;
  final VoidCallback onChanged;

  Widget _buildResumeCard(BuildContext context, Resume resume) {
    final themeData = Theme.of(context);

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

    final String salaryText =
        (resume.salary != null) ? '${resume.salary} руб.' : 'з/п не указана';

    final List<String> displayedTags = resume.tags.take(3).toList();
    if (resume.tags.length > 3) {
      displayedTags.add('...');
    }

    return Card(
      margin: const EdgeInsets.all(0.0),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue,
            child: ListTile(
              title: Text(
                resume.vacancyName,
                style:
                    themeData.textTheme.headline6.copyWith(color: Colors.white),
              ),
              subtitle: Text(
                salaryText,
                style: themeData.textTheme.bodyText2
                    .copyWith(color: Colors.white70),
              ),
              trailing: Material(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.edit_rounded),
                  color: Colors.white70,
                  splashRadius: 24.0,
                  onPressed: onEdit,
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              resume.about,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 4.0,
              children: [
                for (String tag in displayedTags) Chip(label: Text(tag))
              ],
            ),
          ),
        ],
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
