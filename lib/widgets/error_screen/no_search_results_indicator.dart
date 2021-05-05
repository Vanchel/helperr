import 'package:flutter/cupertino.dart';
import 'exception_indicator.dart';

class NoSearchResultsIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const ExceptionIndicator(
        title: 'Слишком много фильтров',
        message: 'Мы не смогли подобрать результаты, '
            'соответствующие указанным Вами параметрам.',
        assetName: 'assets/no-search-results.svg',
      );
}
