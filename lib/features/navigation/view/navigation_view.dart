import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/navigation/navigation.dart';
import 'package:helperr/features/profile/profile_page.dart';
import 'package:helperr/features/search/vacancy_search/view/vacancy_search_delegate.dart';
import 'package:helperr/features/settings/view/settings_page.dart';

class NavigationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        PreferredSizeWidget appBar;
        if (state == 0) {
          appBar = AppBar(
            title: const Text('Поиск'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded),
                splashRadius: 24.0,
                onPressed: () {
                  showSearch(context: context, delegate: VacancySearch());
                },
              ),
            ],
          );
        } else if (state == 1) {
          appBar = AppBar(title: const Text('В процессе разработки'));
        } else if (state == 2) {
          appBar = AppBar(
            title: const Text('Профиль'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_rounded),
                splashRadius: 24.0,
                onPressed: () => Navigator.push(context, SettingsPage.route()),
              ),
            ],
          );
        } else {
          appBar = null;
        }

        Widget body;
        if (state == 0) {
          body = ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('Элемент #$index'),
                  subtitle: Text('Описание тут есть'),
                ),
              );
            },
          );
        } else if (state == 1) {
          body = Container(
            child: Center(
              child: Text('В процессе разработки'),
            ),
          );
        } else if (state == 2) {
          body = ProfilePage();
        }

        Widget bottomNavigationBar = BottomNavigationBar(
          currentIndex: state,
          onTap: (value) => context.read<NavigationCubit>().selectPage(value),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Поиск',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'Избранное',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Профиль',
            ),
          ],
        );

        return Scaffold(
          appBar: appBar,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
        );
      },
    );
  }
}
