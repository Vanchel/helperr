import 'package:flutter/material.dart';
import 'package:helperr/data_layer/model/gender.dart';
import 'package:helperr/widgets/avatar_header/avatar_header.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
    this.userId,
    this.name,
    this.description,
    this.backgroundUrl,
    this.avatarUrl,
    this.dateOfBirth,
    this.sex,
    this.address,
    this.country,
    this.onEdit,
    this.onImageChanged,
  }) : super(key: key);

  final int userId;
  final String name;
  final String description;
  final String backgroundUrl;
  final String avatarUrl;
  final DateTime dateOfBirth;
  final Gender sex;
  final String address;
  final String country;
  final VoidCallback onEdit;
  final VoidCallback onImageChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    final headerTile = ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      title: Text(name ?? '?Имя?', style: themeData.textTheme.headline6),
      subtitle: (address?.isNotEmpty ?? false) ? Text(address) : null,
      trailing: IconButton(
        icon: Icon(Icons.edit_rounded),
        onPressed: onEdit,
        splashRadius: 24.0,
      ),
    );

    Widget descriptionWidget;
    if (description?.isNotEmpty ?? false) {
      descriptionWidget = Container(
        child: Text(description, style: themeData.textTheme.caption),
      );
    } else {
      descriptionWidget = const SizedBox.shrink();
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AvatarHeader(
            userId: userId,
            avatarUrl: avatarUrl,
            backgroundUrl: backgroundUrl,
            onChanged: onImageChanged,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [headerTile, descriptionWidget],
            ),
          ),
        ],
      ),
    );
  }
}
