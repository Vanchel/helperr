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

  // String _mapExpTypeToString(ExperienceType type) {
  //   String str;

  //   if (type == ExperienceType.junior) {
  //     str = "начинающий специалист";
  //   } else if (type == ExperienceType.middle) {
  //     str = "специалист";
  //   } else if (type == ExperienceType.senior) {
  //     str = "старший специалист";
  //   } else if (type == ExperienceType.director) {
  //     str = "руководитель";
  //   } else if (type == ExperienceType.seniorDirector) {
  //     str = "старший руководитель";
  //   } else {
  //     str = "стажёр";
  //   }

  //   return str;
  // }

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

    // String dateFormatted;
    // if (resume.pubDate != null) {
    //   dateFormatted = DateFormat('dd.MM.yyyy').format(resume.pubDate);
    // } else {
    //   dateFormatted = 'Ошибка загрузки даты';
    // }

    // String workTypeFormatted =
    //     List.generate(resume.workType.length, (index) => resume.workType[index])
    //         .toList()
    //         .join(', ');

    // return Card(
    //   margin: const EdgeInsets.all(0.0),
    //   clipBehavior: Clip.antiAlias,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         color: Colors.blue[700],
    //         child: ListTile(
    //           title: Text(
    //             resume.vacancyName,
    //             style:
    //                 themeData.textTheme.headline6.copyWith(color: Colors.white),
    //           ),
    //           subtitle: Text(
    //             _mapExpTypeToString(resume.grade),
    //             style:
    //                 themeData.textTheme.bodyText2.copyWith(color: Colors.white),
    //           ),
    //           trailing: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Text(
    //                 salaryText,
    //                 style: themeData.textTheme.subtitle1
    //                     .copyWith(color: Colors.white),
    //               ),
    //               Text(
    //                 dateFormatted,
    //                 style: themeData.textTheme.subtitle2
    //                     .copyWith(color: Colors.white),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       ListTile(
    //         title: Text(resume.industry),
    //         subtitle: Text(workTypeFormatted),
    //         trailing: IconButton(
    //           icon: const Icon(Icons.edit_rounded),
    //           splashRadius: 24.0,
    //           onPressed: onEdit,
    //         ),
    //       ),
    //       Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //           child: Text(resume.about)),
    //       Container(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Wrap(
    //           spacing: 4.0,
    //           children: [
    //             for (String tag in resume.tags) Chip(label: Text(tag))
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );

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
