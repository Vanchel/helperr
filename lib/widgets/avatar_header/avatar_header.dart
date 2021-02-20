import 'package:flutter/material.dart';
import 'package:helperr/data_layer/data_provider/firebase_server.dart'
    as firebase_server;

import 'image_menu.dart';

class AvatarHeader extends StatelessWidget {
  const AvatarHeader(this.userId, {Key key})
      : assert(userId != null),
        super(key: key);

  final int userId;

  @override
  Widget build(BuildContext context) {
    //final avatarImage = FutureBuilder(builder: );

    // final ImageProvider backgroundImage = backgroundUrl.isNotEmpty
    //     ? NetworkImage(backgroundUrl)
    //     : const AssetImage('assets/background.png');

    // final ImageProvider avatarImage = avatarUrl.isNotEmpty
    //     ? NetworkImage(avatarUrl)
    //     : const AssetImage('assets/avatar.jpg');

    Offset _lastTap;

    // final avatarWidget = Container(
    //   child: CircleAvatar(
    //     radius: 40.0,
    //     backgroundImage: const AssetImage('assets/avatar.jpg'),
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

    final avatarWidget = Container(
      child: FutureBuilder(
        future: firebase_server.getUserProfileAvatarUrl(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final ImageProvider avatarImage = snapshot.data.isNotEmpty
                // replace network image with something more consistent
                ? NetworkImage(snapshot.data)
                : const AssetImage('assets/avatar.jpg');

            return CircleAvatar(
              radius: 40.0,
              backgroundImage: avatarImage,
              child: Material(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                shape: const CircleBorder(),
                child: InkWell(
                  onTapDown: (details) => _lastTap = details.globalPosition,
                  onTap: () {
                    showImageMenu(context, _lastTap);
                  },
                ),
              ),
            );
          } else {
            return CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.green,
            );
          }
        },
      ),
    );

    // return Material(
    //   child: Ink.image(
    //     image: const AssetImage('assets/background.png'),
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

    return FutureBuilder(
      future: firebase_server.getUserProfileBackgroundUrl(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final ImageProvider backgroundImage = snapshot.data.isNotEmpty
              ? NetworkImage(snapshot.data)
              : const AssetImage('assets/background.png');

          return Material(
            child: Ink.image(
              image: backgroundImage,
              fit: BoxFit.cover,
              child: InkWell(
                onTapDown: (details) => _lastTap = details.globalPosition,
                onTap: () {
                  showImageMenu(context, _lastTap);
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16.0),
                  child: avatarWidget,
                ),
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.centerLeft,
            color: Colors.green[900],
            padding: const EdgeInsets.all(16.0),
            child: avatarWidget,
          );
        }
      },
    );
  }
}
