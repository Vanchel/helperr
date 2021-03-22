import 'package:flutter/material.dart';
import '../../../data_layer/model/truncated_vacancy.dart';

class TruncatedVacancyCard extends StatelessWidget {
  final TruncatedVacancy vacancy;

  const TruncatedVacancyCard({Key key, @required this.vacancy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final header = Container(
      color: Colors.blue,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange,
        ),
        title: Text(
          vacancy.vacancyName,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          vacancy.employerName,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(color: Colors.white54),
        ),
        trailing: Text(
          (vacancy.salary != -1) ? '${vacancy.salary} руб.' : 'з/п не указана',
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    );

    final footer = ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: Text('Откликнуться'.toUpperCase()),
        ),
        IconButton(
          icon: const Icon(Icons.favorite_outline_rounded),
          color: Colors.black38,
          splashRadius: 24.0,
          onPressed: () {},
        )
      ],
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          header,
          // Container(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     'Это текст-"рыба", часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной "рыбой" для текстов на латинице с начала XVI века. В то время некий безымянный печатник создал большую коллекцию размеров и форм шрифтов, используя Lorem Ipsum для распечатки образцов. Lorem Ipsum не только',
          //     style: themeData.textTheme.caption,
          //     overflow: TextOverflow.ellipsis,
          //     maxLines: 2,
          //   ),
          // ),
          footer,
        ],
      ),
    );
  }
}
