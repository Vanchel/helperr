import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/navigation/navigation.dart';
import 'package:helperr/features/profile/profile.dart';

class NavigationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (context, state) {
          switch (state.index) {
            case 2:
              return ProfilePage();
              break;
            default:
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
            showSelectedLabels: false,
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
