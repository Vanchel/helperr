import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/models.dart';
import '../cubit/profile_cubit.dart';
import '../profile.dart';

class ProfileView extends StatelessWidget {
  bool _isPropValid(String prop) {
    return prop != null && prop != '';
  }

  Widget _buildWorkerProfile(BuildContext context, Worker worker) {
    final themeData = Theme.of(context);

    final ImageProvider _background = (_isPropValid(worker.profileBackground))
        ? NetworkImage(worker.profileBackground)
        : AssetImage('assets/background.png');

    final ImageProvider _avatar = (_isPropValid(worker.photoUrl))
        ? NetworkImage(worker.photoUrl)
        : AssetImage('assets/avatar.jpg');

    final String _name = (_isPropValid(worker.name)) ? worker.name : 'No name';

    Widget _aboutText;
    if (_isPropValid(worker.about)) {
      _aboutText = Text(
        worker.about,
        maxLines: 5,
        style: themeData.textTheme.caption,
      );
    } else {
      _aboutText = const SizedBox.shrink();
    }

    Widget _dateOfBirthString;
    if (_isPropValid(worker.birthday)) {
      _dateOfBirthString = Row(
        children: [
          const Icon(Icons.cake_rounded),
          Text(worker.birthday),
        ],
      );
    } else {
      _dateOfBirthString = const SizedBox.shrink();
    }

    // add cz
    Widget _locationString;
    if (_isPropValid(worker.city)) {
      _locationString = Row(
        children: [
          const Icon(Icons.apartment_rounded),
          Text(worker.city),
        ],
      );
    } else {
      _locationString = const SizedBox.shrink();
    }

    ExpansionPanelList _otherInfo = ExpansionPanelList(
      children: [
        ExpansionPanel(
          headerBuilder: (context, isExpanded) =>
              const ListTile(title: Text('Образование')),
          body: ListView.builder(
            itemCount: worker.education.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(worker.education[index].profession),
                subtitle: Text(worker.education[index].university), // + years
              );
            },
          ),
        ),
        ExpansionPanel(
          headerBuilder: (context, isExpanded) =>
              const ListTile(title: Text('Опыт работы')),
          body: ListView.builder(
            itemCount: worker.exp.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(worker.exp[index].position), // + company
                subtitle: Text(worker.exp[index].type), // + years
              );
            },
          ),
        ),
      ],
    );

    return Column(
      children: [
        Card(
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _background,
                    fit: BoxFit.cover,
                  ),
                ),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: _avatar,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _name,
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
              _aboutText,
              _dateOfBirthString,
              _locationString,
              //_otherInfo,
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
            return _buildWorkerProfile(context, state.worker);
          } else {
            // if (state is ProfileFailedLoading)
            return Center(child: onErr);
          }
        },
      ),
    );
  }
}
