import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../cubit/worker_image_cubit.dart';
import '../../model/image_option.dart';
import '../../util.dart';
import '../../../../data_layer/model/worker.dart';

class WorkerAvatarView extends StatefulWidget {
  const WorkerAvatarView({
    Key key,
    this.worker,
    this.onChanged,
  })  : assert(worker != null),
        super(key: key);

  final Worker worker;
  final VoidCallback onChanged;

  @override
  _WorkerAvatarViewState createState() => _WorkerAvatarViewState();
}

class _WorkerAvatarViewState extends State<WorkerAvatarView> {
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
    if (widget.worker.profileBackground.isNotEmpty) {
      bgImage = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: widget.worker.profileBackground,
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
    if (widget.worker.photoUrl.isNotEmpty) {
      avatarImage = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: widget.worker.photoUrl,
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
      final isSet = widget.worker.photoUrl.isNotEmpty;
      final option = await showImageMenu(context, isSet, _lastTap);

      if (option == ImageOption.camera || option == ImageOption.gallery) {
        final file = await prepareFile(option);
        if (file == null) return;
        context.read<WorkerImageCubit>().updateAvatar(widget.worker, file.path);
      } else if (option == ImageOption.delete) {
        context.read<WorkerImageCubit>().deleteAvatar(widget.worker);
      }
    };

    final onBgTap = () async {
      final isSet = widget.worker.profileBackground.isNotEmpty;
      final option = await showImageMenu(context, isSet, _lastTap);

      if (option == ImageOption.camera || option == ImageOption.gallery) {
        final file = await prepareFile(option);
        if (file == null) return;
        context
            .read<WorkerImageCubit>()
            .updateBackground(widget.worker, file.path);
      } else if (option == ImageOption.delete) {
        context.read<WorkerImageCubit>().deleteBackground(widget.worker);
      }
    };

    final loadingIndicator = BlocBuilder<WorkerImageCubit, ImageState>(
      builder: (context, state) {
        if (state is ImageChangeInProgress) {
          return const LinearProgressIndicator();
        } else {
          return const SizedBox(height: 4.0);
        }
      },
    );

    return BlocListener<WorkerImageCubit, ImageState>(
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
                color: Colors.grey[200],
                child: bgImage,
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.blueAccent.withOpacity(0.4),
                    onTapDown: _saveTapPosition,
                    onTap: onBgTap,
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
