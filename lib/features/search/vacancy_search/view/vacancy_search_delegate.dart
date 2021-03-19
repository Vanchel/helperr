import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/search/vacancy_search/cubit/search_cubit.dart';

import '../../../../data_layer/model/vacancy_search_options.dart';
import 'vacancy_filter_page.dart';
import 'vacancies_page.dart';

class VacancySearch extends SearchDelegate<Widget> {
  static const List<String> fooSuggestions = [
    'Работа в сфере услуг',
    'Работа на складах',
    'Работа в ресторанах',
    'Работа в сфере бытовых услуг',
    'Подработка',
    'Работа в строительстве',
    'Работа на транспорте',
    'Удаленная работа',
    'Работа в сфере доставки',
    'Работа в сфере продаж',
    'Работа на производстве',
    'Работа в сфере безопасности',
    'Домашний персонал',
    'Работа в сфере финансов',
    'Работа в медицине',
    'Работа в недвижимости',
    'Работа в сфере IT',
    'Работа в сфере HR',
    'Работа для руководителей',
    'Индустрия красоты',
    'Работа в страховании',
    'Работа в сфере дизайна',
    'Работа в маркетинге',
    'Работа в юриспруденции',
    'Работа в агропроме',
  ];

  VacancySearchOptions searchOptions;

  @override
  String get searchFieldLabel => 'Поиск';

  @override
  List<Widget> buildActions(BuildContext context) {
    Widget clearButton;
    if (query.isNotEmpty) {
      clearButton = IconButton(
        icon: const Icon(Icons.clear_rounded),
        splashRadius: 24.0,
        onPressed: () => query = '',
      );
    } else {
      clearButton = const SizedBox.shrink();
    }

    final onSaveFilters = (VacancySearchOptions options) {
      searchOptions = options;
      showResults(context);
    };

    final filtersButton = IconButton(
      icon: const Icon(Icons.tune_rounded),
      splashRadius: 24.0,
      tooltip: 'Фильтры',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VacancyFilterPage(query: query, onSave: onSaveFilters),
          ),
        );
      },
    );

    return [clearButton, filtersButton];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: 24.0,
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final options = searchOptions ?? VacancySearchOptions(searchPhrase: query);
    return BlocProvider(
      create: (context) =>
          VacancySearchCubit(searchOptions: options)..fetchResults(),
      child: VacanciesPage(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final matchingSugestions = fooSuggestions
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .take(5)
        .toList();

    return ListView.builder(
      itemCount: matchingSugestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            query = matchingSugestions[index];
            showResults(context);
          },
          leading: const Icon(Icons.search_rounded),
          title: Text(matchingSugestions[index]),
        );
      },
    );
  }
}
