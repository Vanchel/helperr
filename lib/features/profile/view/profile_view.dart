import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/profile_cubit.dart';
import '../profile.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final card = Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/panda_sad.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: const CircleAvatar(
              radius: 40.0,
              backgroundImage: AssetImage('assets/pear.jpg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Иван Тимашов',
              style: themeData.textTheme.headline6,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: Text('Редактировать профиль'),
            ),
          ),
        ],
      ),
    );

    final onErr = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Произошла ошибка загрузки'),
        TextButton(
          child: const Text('Повторить'),
          onPressed: () => context.read<ProfileCubit>().loadProfile(),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return card;
          } else {
            // if (state is ProfileFailedLoading)
            return Center(child: onErr);
          }
        },
      ),
    );
  }
}
