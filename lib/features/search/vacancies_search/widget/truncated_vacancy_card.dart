import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data_layer/model/truncated_vacancy.dart';
import '../../../../data_layer/data_provider/firebase_server.dart' as storage;

class TruncatedVacancyCard extends StatelessWidget {
  const TruncatedVacancyCard({
    Key key,
    @required this.vacancy,
  })  : assert(vacancy != null),
        super(key: key);

  final TruncatedVacancy vacancy;

  String get _formattedPubDate =>
      DateFormat('dd.MM.yyyy').format(vacancy.pubDate);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final header = ListTile(
      leading: FutureBuilder(
        future: storage.getAvatarUrl(vacancy.employerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CircleAvatar(
              foregroundImage: snapshot.data.isNotEmpty
                  ? NetworkImage(snapshot.data)
                  : AssetImage('assets/avatar.png'),
            );
          } else {
            return CircleAvatar();
          }
        },
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              vacancy.vacancyName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text((vacancy.salary != -1)
              ? '${vacancy.salary} руб.'
              : 'з/п не указана'),
        ],
      ),
      subtitle: Text(
        vacancy.employerName,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );

    Widget description;
    if (vacancy.leading?.isNotEmpty ?? false) {
      description = Container(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          vacancy.leading,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(vacancy.address.name, style: textTheme.caption),
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
