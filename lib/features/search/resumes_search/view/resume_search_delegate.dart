import 'package:flutter/material.dart';

import '../../../../data_layer/model/resume_search_options.dart';
import 'resume_filter_page.dart';
import 'resumes_search_result_page.dart';

class ResumeSearchDelegate extends SearchDelegate<Widget> {
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
    final options = searchOptions ?? ResumeSearchOptions(searchPhrase: query);
    return ResumesSearchResultPage(searchOptions: options);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
