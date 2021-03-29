import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
    this.header,
    this.name,
    this.description,
    this.address,
    this.onEdit,
  }) : super(key: key);

  final Widget header;
  final String name;
  final String description;
  final String address;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    final headerTile = ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      title: Text(
        name ?? '?Имя?',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: themeData.textTheme.headline6,
      ),
      subtitle: (address?.isNotEmpty ?? false)
          ? Text(
              address,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
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
          header,
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
