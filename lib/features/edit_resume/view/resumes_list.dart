import 'package:flutter/material.dart';

import 'edit_resume_page.dart';
import '../../../data_layer/model/resume.dart';
import '../../../widgets/list_action_header.dart';
import '../../../constants.dart' as c;

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

    final String salaryText = (resume.salary != c.salaryNotSpecified)
        ? '${resume.salary} руб.'
        : 'з/п не указана';

    final List<String> displayedTags = resume.tags.take(3).toList();
    if (resume.tags.length > 3) {
      displayedTags.add('...');
    }

    Widget description;
    if (resume.about.isNotEmpty) {
      description = Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          resume.about,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: themeData.textTheme.bodyText2
              .copyWith(color: themeData.textTheme.caption.color),
        ),
      );
    } else {
      description = const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: themeData.primaryColor,
            child: ListTile(
              title: Text(
                resume.vacancyName,
                style: themeData.textTheme.headline6
                    .copyWith(color: themeData.colorScheme.onPrimary),
              ),
              subtitle: Text(
                salaryText,
                style: TextStyle(
                  color: themeData.colorScheme.onPrimary.withOpacity(0.54),
                ),
              ),
              trailing: Material(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                shape: const CircleBorder(),
                child: IconButton(
                  icon: Icon(
                    Icons.edit_rounded,
                    color: themeData.colorScheme.onPrimary,
                  ),
                  splashRadius: c.iconButtonSplashRadius,
                  onPressed: onEdit,
                ),
              ),
            ),
          ),
          description,
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Wrap(
              spacing: c.defaultMargin,
              runSpacing: c.defaultMargin,
              children: [
                for (String tag in displayedTags)
                  Chip(
                    label: Text(tag),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )
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

    final header = ListAddHeader(
      'Ваши резюме',
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
