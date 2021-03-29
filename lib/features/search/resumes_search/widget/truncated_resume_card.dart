import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data_layer/model/truncated_resume.dart';
import '../../../../data_layer/data_provider/firebase_server.dart' as storage;

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

    final header = ListTile(
      leading: CircleAvatar(
        foregroundImage: resume.photoUrl.isNotEmpty
            ? NetworkImage(resume.photoUrl)
            : AssetImage('assets/avatar.png'),
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
        resume.vacancyName,
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
          Expanded(
            child: Text(
              resume.address.name,
              style: textTheme.caption,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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

    final actions = ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      layoutBehavior: ButtonBarLayoutBehavior.constrained,
      children: [
        TextButton(
          onPressed: onNotImplemented,
          child: Text('Откликнуться'.toUpperCase()),
        ),
        IconButton(
          icon: const Icon(Icons.favorite_outline_rounded),
          color: Colors.black38,
          splashRadius: 24.0,
          onPressed: onNotImplemented,
        )
      ],
    );

    return Card(
      margin: const EdgeInsets.all(0.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
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
