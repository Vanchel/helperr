import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/search/vacancy_search/widget/vacancy_card.dart';

import '../cubit/search_cubit.dart';

class VacanciesPage extends StatefulWidget {
  @override
  _VacanciesPageState createState() => _VacanciesPageState();
}

class _VacanciesPageState extends State<VacanciesPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  VacancySearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchCubit = BlocProvider.of<VacancySearchCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VacancySearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SearchFailure) {
          return Center(
            child: Text('не удалось загрузить вакансии'),
          );
        }
        if (state is SearchSuccess) {
          if (state.searchResults.isEmpty) {
            return Center(
              child: Text('нет вакансий'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.searchResults.length
                  ? BottomLoader()
                  : TruncatedVacancyCard(vacancy: state.searchResults[index]);
            },
            itemCount: state.hasReachedMax
                ? state.searchResults.length
                : state.searchResults.length + 1,
            controller: _scrollController,
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _searchCubit.fetchResults();
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
