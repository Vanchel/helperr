import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../cubit/employer_image_cubit.dart';
import '../../model/image_option.dart';
import '../../util.dart';
import '../../../../data_layer/model/employer.dart';

class EmployerAvatarView extends StatefulWidget {
  const EmployerAvatarView({
    Key key,
    this.employer,
    this.onChanged,
  })  : assert(employer != null),
        super(key: key);

  final Employer employer;
  final VoidCallback onChanged;

  @override
  _EmployerAvatarViewState createState() => _EmployerAvatarViewState();
}

class _EmployerAvatarViewState extends State<EmployerAvatarView> {
  static const _avatarRadius = 40.0;
  static const _padding = 16.0;
  static const _duration = Duration(milliseconds: 300);

  Offset _lastTap;

  void _saveTapPosition(TapDownDetails details) {
    _lastTap = details.globalPosition;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    FadeInImage bgImage;
    if (widget.employer.profileBackground.isNotEmpty) {
      bgImage = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: widget.employer.profileBackground,
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
    if (widget.employer.photoUrl.isNotEmpty) {
      avatarImage = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: widget.employer.photoUrl,
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

    final onAvatarTap = () async {
      final isSet = widget.employer.photoUrl.isNotEmpty;
      final option = await showImageMenu(context, isSet, _lastTap);

      if (option == ImageOption.camera || option == ImageOption.gallery) {
        final file = await prepareFile(option);
        if (file == null) return;
        context
            .read<EmployerImageCubit>()
            .updateAvatar(widget.employer, file.path);
      } else if (option == ImageOption.delete) {
        context.read<EmployerImageCubit>().deleteAvatar(widget.employer);
      }
    };

    final onBgTap = () async {
      final isSet = widget.employer.profileBackground.isNotEmpty;
      final option = await showImageMenu(context, isSet, _lastTap);

      if (option == ImageOption.camera || option == ImageOption.gallery) {
        final file = await prepareFile(option);
        if (file == null) return;
        context
            .read<EmployerImageCubit>()
            .updateBackground(widget.employer, file.path);
      } else if (option == ImageOption.delete) {
        context.read<EmployerImageCubit>().deleteBackground(widget.employer);
      }
    };

    final loadingIndicator = BlocBuilder<EmployerImageCubit, ImageState>(
      builder: (context, state) {
        if (state is ImageChangeInProgress) {
          return const LinearProgressIndicator();
        } else {
          return const SizedBox(height: 4.0);
        }
      },
    );

    return BlocListener<EmployerImageCubit, ImageState>(
      listener: (context, state) {
        if (state is ImageUpdateFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text('Не удалось обновить фото'),
            ));
        } else if (state is ImageDeleteFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text('Не удалось удалить фото'),
            ));
        } else if (state is ImageInitial || state is ImageChangeInProgress) {
          return;
        } else {
          widget.onChanged();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: (_avatarRadius + _padding) * 2,
                width: double.infinity,
                color: themeData.canvasColor.withAlpha(128),
                child: bgImage,
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTapDown: _saveTapPosition,
                    onTap: onBgTap,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(_padding),
                decoration: BoxDecoration(
                  color: themeData.canvasColor.withAlpha(160),
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
                    onTapDown: _saveTapPosition,
                    onTap: onAvatarTap,
                  ),
                ),
              ),
            ],
          ),
          loadingIndicator,
        ],
      ),
    );
  }
}
