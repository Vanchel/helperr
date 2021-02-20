import 'package:flutter/material.dart';
import 'package:helperr/data_layer/model/models.dart';
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
    this.region,
    this.country,
  }) : super(key: key);

  final int userId;
  final String name;
  final String description;
  final String backgroundUrl;
  final String avatarUrl;
  final DateTime dateOfBirth;
  final Gender sex;
  final String region;
  final String country;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    // final ImageProvider backgroundImage = backgroundUrl.isNotEmpty
    //     ? NetworkImage(backgroundUrl)
    //     : const AssetImage('assets/background.png');

    // final ImageProvider avatarImage = avatarUrl.isNotEmpty
    //     ? NetworkImage(avatarUrl)
    //     : const AssetImage('assets/avatar.jpg');

    // Offset _lastTap;

    // final avatarWidget = Container(
    //   // decoration: const BoxDecoration(
    //   //   shape: BoxShape.circle,
    //   //   boxShadow: [
    //   //     BoxShadow(color: Colors.black26, spreadRadius: 1.0, blurRadius: 2.0),
    //   //   ],
    //   // ),
    //   child: CircleAvatar(
    //     radius: 40.0,
    //     backgroundImage: avatarImage,
    //     child: Material(
    //       color: Colors.transparent,
    //       clipBehavior: Clip.antiAlias,
    //       shape: const CircleBorder(),
    //       child: InkWell(
    //         onTapDown: (details) => _lastTap = details.globalPosition,
    //         onTap: () {
    //           showImageMenu(context, _lastTap);
    //         },
    //       ),
    //     ),
    //   ),
    // );

    // final Widget headWidget = Material(
    //   child: Ink.image(
    //     image: backgroundImage,
    //     fit: BoxFit.cover,
    //     child: InkWell(
    //       onTapDown: (details) => _lastTap = details.globalPosition,
    //       onTap: () {
    //         showImageMenu(context, _lastTap);
    //       },
    //       child: Container(
    //         alignment: Alignment.centerLeft,
    //         padding: const EdgeInsets.all(16.0),
    //         child: avatarWidget,
    //       ),
    //     ),
    //   ),
    // );

    Widget nameWidget;
    if (name != null) {
      nameWidget = Container(
        child: Text(name, style: themeData.textTheme.headline6),
      );
    } else {
      nameWidget = const SizedBox.shrink();
    }

    Widget regionWidget;
    if (region?.isNotEmpty ?? false) {
      regionWidget = Container(
        margin: const EdgeInsets.only(top: 4.0),
        child: Text(region, style: themeData.textTheme.caption),
      );
    } else {
      regionWidget = const SizedBox.shrink();
    }

    Widget descriptionWidget;
    if (description?.isNotEmpty ?? false) {
      descriptionWidget = Container(
        margin: const EdgeInsets.only(top: 16.0),
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
          AvatarHeader(userId),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameWidget,
                regionWidget,
                descriptionWidget,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
