import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'image_option.dart';
import 'image_type.dart';
import 'image_option_handler.dart';

class AvatarHeader extends StatefulWidget {
  const AvatarHeader({
    Key key,
    this.userId,
    this.avatarUrl = '',
    this.backgroundUrl = '',
    this.onChanged,
  })  : assert(userId != null),
        assert(avatarUrl != null),
        assert(backgroundUrl != null),
        super(key: key);

  final int userId;
  final String avatarUrl;
  final String backgroundUrl;
  final VoidCallback onChanged;

  @override
  _AvatarHeaderState createState() => _AvatarHeaderState();
}

class _AvatarHeaderState extends State<AvatarHeader> {
  static const _avatarRadius = 40.0;
  static const _padding = 16.0;
  static const _duration = Duration(milliseconds: 300);

  Offset _lastTap;

  void _saveTapPosition(TapDownDetails details) {
    _lastTap = details.globalPosition;
  }

  @override
  Widget build(BuildContext context) {
    FadeInImage bgImage;
    if (widget.backgroundUrl.isNotEmpty) {
      bgImage = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: widget.backgroundUrl,
        fit: BoxFit.cover,
        fadeInDuration: _duration,
      );
    } else {
      bgImage = FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: AssetImage('assets/background.png'),
        fit: BoxFit.cover,
        fadeInDuration: _duration,
      );
    }

    FadeInImage avatarImage;
    if (widget.avatarUrl.isNotEmpty) {
      avatarImage = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: widget.avatarUrl,
        fit: BoxFit.cover,
        height: _avatarRadius * 2,
        width: _avatarRadius * 2,
        fadeInDuration: _duration,
      );
    } else {
      avatarImage = FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: AssetImage('assets/avatar.png'),
        fit: BoxFit.cover,
        height: _avatarRadius * 2,
        width: _avatarRadius * 2,
        fadeInDuration: _duration,
      );
    }

    return Stack(
      children: [
        Container(
          height: (_avatarRadius + _padding) * 2,
          width: double.infinity,
          color: Colors.grey[200],
          child: bgImage,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.blueAccent.withOpacity(0.4),
              onTapDown: _saveTapPosition,
              onTap: () async {
                final isSet = widget.backgroundUrl.isNotEmpty;
                final option = await showImageMenu(context, isSet);

                mapImageOption(option, widget.userId, ImageType.background,
                    widget.onChanged);
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(_padding),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_avatarRadius),
            child: avatarImage,
          ),
        ),
        Positioned(
          top: _padding,
          left: _padding,
          width: _avatarRadius * 2,
          height: _avatarRadius * 2,
          child: Material(
            clipBehavior: Clip.hardEdge,
            shape: const CircleBorder(),
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.blueAccent.withOpacity(0.4),
              onTapDown: _saveTapPosition,
              onTap: () async {
                final isSet = widget.avatarUrl.isNotEmpty;
                final option = await showImageMenu(context, isSet);

                mapImageOption(
                    option, widget.userId, ImageType.avatar, widget.onChanged);
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<ImageOption> showImageMenu(BuildContext context, bool isSet) async {
    final RenderBox overlay = context.findRenderObject();

    const cameraOption = PopupMenuItem(
      value: ImageOption.camera,
      child: ListTile(
        leading: Icon(Icons.photo_camera_rounded),
        title: Text('Сделать фото'),
      ),
    );

    const galleryOption = PopupMenuItem(
      value: ImageOption.gallery,
      child: ListTile(
        leading: Icon(Icons.photo_library_rounded),
        title: Text('Выбрать из галереи'),
      ),
    );

    final deleteOption = PopupMenuItem(
      value: ImageOption.delete,
      enabled: isSet,
      child: ListTile(
        leading: Icon(Icons.delete_rounded),
        title: Text('Удалить'),
      ),
    );

    final selectedOption = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _lastTap & const Size.square(40.0),
        Offset.zero & overlay.size,
      ),
      items: <PopupMenuEntry<ImageOption>>[
        cameraOption,
        galleryOption,
        deleteOption,
      ],
    );

    return selectedOption;
  }
}
