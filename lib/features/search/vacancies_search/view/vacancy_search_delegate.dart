import 'package:flutter/material.dart';

import '../../../../data_layer/model/vacancy_search_options.dart';
import 'vacancy_filter_page.dart';
import 'vacancies_search_result_page.dart';

class VacancySearchDelegate extends SearchDelegate<Widget> {
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
    return VacanciesSearchResultPage(searchOptions: options);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
