import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/navigation/navigation.dart';
import 'package:helperr/features/profile/profile_page.dart';
import 'package:helperr/features/settings/view/settings_page.dart';

class NavigationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileViewAppBar = AppBar(
      title: const Text('Профиль'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_rounded),
          splashRadius: 24.0,
          onPressed: () => Navigator.push(context, SettingsPage.route()),
        ),
      ],
    );

    return Scaffold(
      appBar: PreferredSize(
        // not the ideal solution but lets think of it later
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<NavigationCubit, NavigationState>(
          buildWhen: (previous, current) => previous.index != current.index,
          builder: (context, state) {
            if (state.index == 2) {
              return profileViewAppBar;
            } else {
              return AppBar(title: const Text('В процессе разработки'));
            }
          },
        ),
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (context, state) {
          if (state.index == 2) {
            return ProfilePage();
          } else {
            return Container(
              child: const Center(
                child: Text('В процессе разработки'),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
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
        },
      ),
    );
  }
}
