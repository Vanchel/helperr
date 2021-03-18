import 'package:flutter/material.dart';

import 'package:helperr/data_layer/model/truncated_vacancy.dart';
import 'package:helperr/features/search/vacancy_search/widget/vacancy_card.dart';

class VacanciesPage extends StatelessWidget {
  const VacanciesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fooData = [
      TruncatedVacancy(vacancyName: 'Уборщик', employerName: 'Наниматель'),
      TruncatedVacancy(vacancyName: 'Охранник', employerName: 'Наниматель'),
      TruncatedVacancy(vacancyName: 'Повар', employerName: 'Наниматель'),
      TruncatedVacancy(vacancyName: 'Столяр', employerName: 'Наниматель'),
      TruncatedVacancy(vacancyName: 'Маляр', employerName: 'Наниматель'),
    ];

    return ListView.builder(
      itemCount: fooData.length,
      itemBuilder: (context, index) =>
          TruncatedVacancyCard(vacancy: fooData[index]),
    );
  }
}
