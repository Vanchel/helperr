import 'package:flutter/material.dart';
import 'package:helperr/features/favorite/widgets/favorite_button/view/favorite_button.dart';
import 'package:helperr/features/response/employer/view/employer_response_loading_page.dart';
import 'package:helperr/features/resume_details/view/resume_details_page.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../data_layer/model/truncated_resume.dart';

class TruncatedResumeCard extends StatelessWidget {
  const TruncatedResumeCard({
    Key key,
    @required this.resume,
  })  : assert(resume != null),
        super(key: key);

  final TruncatedResume resume;

  String get _formattedPubDate =>
      DateFormat('dd.MM.yyyy').format(resume.pubDate);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final ImageProvider image = resume.photoUrl.isNotEmpty
        ? NetworkImage(resume.photoUrl)
        : AssetImage('assets/avatar.png');

    final header = ListTile(
      leading: ClipOval(
        child: FadeInImage(
          fit: BoxFit.cover,
          width: 40,
          height: 40,
          image: image,
          placeholder: MemoryImage(kTransparentImage),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              resume.vacancyName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text((resume.salary != -1)
              ? '${resume.salary} руб.'
              : 'з/п не указана'),
        ],
      ),
      subtitle: Text(
        resume.workerName,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );

    Widget description;
    if (resume.about?.isNotEmpty ?? false) {
      description = Container(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          resume.about,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: textTheme.bodyText2.copyWith(color: Colors.black54),
        ),
      );
    } else {
      description = const SizedBox.shrink();
    }

    final footer = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(child: const SizedBox.shrink()),
          Text(_formattedPubDate, style: textTheme.caption),
        ],
      ),
    );

    final divider = const Divider();

    final onNotImplemented = () {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: const Text('Функция еще не реализована!'),
        ));
    };

    final onRespond = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployerResponsePage(
            onSave: () {},
            resumeId: resume.id,
            workerId: resume.workerId,
          ),
        ),
      );
    };

    final actions = ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      layoutBehavior: ButtonBarLayoutBehavior.constrained,
      children: [
        TextButton(
          onPressed: resume.gotResponsed ? null : onRespond,
          child: Text('Пригласить'.toUpperCase()),
        ),
        FavoriteButton(id: resume.id, isInFavorite: resume.favorited),
      ],
    );

    final onCardTap = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResumeDetailsPage(
            resumeName: resume.vacancyName,
            resumeId: resume.id,
          ),
        ),
      );
    };

    return Card(
      margin: const EdgeInsets.all(0.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onCardTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            header,
            description,
            footer,
            divider,
            actions,
          ],
        ),
      ),
    );
  }
}
