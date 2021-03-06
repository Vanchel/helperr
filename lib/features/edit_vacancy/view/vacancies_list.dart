import 'package:flutter/material.dart';

import 'edit_vacancy_page.dart';
import '../../../data_layer/model/vacancy.dart';
import '../../../widgets/list_action_header.dart';
import '../../../constants.dart' as constants;

class VacanciesList extends StatelessWidget {
  const VacanciesList(this.vacancies, {Key key, @required this.onChanged})
      : assert(vacancies != null),
        super(key: key);

  final List<Vacancy> vacancies;
  final VoidCallback onChanged;

  Widget _buildVacancyCard(BuildContext context, Vacancy vacancy) {
    final themeData = Theme.of(context);

    final onEdit = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditVacancyPage(
            onSave: onChanged,
            isEditing: true,
            vacancy: vacancy,
          ),
        ),
      );
    };

    final String salaryText = (vacancy.salary != constants.salaryNotSpecified)
        ? '${vacancy.salary} руб.'
        : 'з/п не указана';

    final List<String> displayedTags = vacancy.tags.take(3).toList();
    if (vacancy.tags.length > 3) {
      displayedTags.add('...');
    }

    Widget description;
    if (vacancy.leading.isNotEmpty) {
      description = Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          vacancy.leading,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      description = const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue,
            child: ListTile(
              title: Text(
                vacancy.vacancyName,
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
          description,
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
          builder: (context) => EditVacancyPage(
            onSave: onChanged,
            isEditing: false,
          ),
        ),
      );
    };

    final header = ListActionHeader(
      'Ваши вакансии',
      actionLabel: 'Новая вакансия',
      action: onAdd,
    );

    return Column(
      children: List.generate(
        vacancies.length,
        (index) => _buildVacancyCard(context, vacancies[index]),
      ).toList()
        ..insert(0, header),
    );
  }
}
