import 'package:flutter/material.dart';
import 'package:helperr/features/search/vacancy_search/model/resume_search_options.dart';
import 'package:helperr/features/search/vacancy_search/view/filter/resume_filter_page.dart';

class ResumeSearch extends SearchDelegate<Widget> {
  static const List<String> fooSuggestions = [
    'Предложить Вам нечего',
    'Предложить Вам все еще нечего',
  ];

  ResumeSearchOptions searchOptions;

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

    final onSaveFilters = (ResumeSearchOptions options) {
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
                ResumeFilterPage(query: query, onSave: onSaveFilters),
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
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                height: 80,
                color: Colors.blue,
              ),
              ListTile(
                title: Text('$query $index'),
                subtitle: Text('Как раз то, что Вы искали'),
              ),
            ],
          ),
        );
      },
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
