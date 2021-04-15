import 'package:flutter/material.dart';
import 'package:helperr/features/response/worker/view/worker_response_loading_page.dart';
import 'package:helperr/features/vacancy_details/view/vacancy_details_page.dart';
import 'package:helperr/widgets/favorite_button/view/favorite_button.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../data_layer/model/truncated_vacancy.dart';

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

    final ImageProvider image = vacancy.photoUrl.isNotEmpty
        ? NetworkImage(vacancy.photoUrl)
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
              vacancy.vacancyName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text(
            (vacancy.salary != -1)
                ? '${vacancy.salary} руб.'
                : 'з/п не указана',
          ),
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
        children: [
          Expanded(
            child: Text(
              vacancy.address.name,
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

    final onRespond = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkerResponsePage(
            onSave: () {},
            vacancyId: vacancy.id,
            employerId: vacancy.employerId,
          ),
        ),
      );
    };

    final actions = ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      layoutBehavior: ButtonBarLayoutBehavior.constrained,
      children: [
        TextButton(
          onPressed: vacancy.gotResponsed ? null : onRespond,
          child: Text('Откликнуться'.toUpperCase()),
        ),
        FavoriteButton(id: vacancy.id, isInFavorite: vacancy.favorited),
      ],
    );

    final onCardTap = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VacancyDetailsPage(
            vacancyName: vacancy.vacancyName,
            vacancyId: vacancy.id,
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
