import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../data_layer/model/response_state.dart';

class DetailedResponseListItem extends StatelessWidget {
  const DetailedResponseListItem({
    Key key,
    this.title,
    this.subtitle,
    this.avatarUrl,
    this.state,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String avatarUrl;
  final ResponseState state;
  final VoidCallback onTap;

  String formatState(ResponseState state) => Intl.select(state, {
        ResponseState.sent: 'Не просмотрено',
        ResponseState.viewed: 'Просмотрено',
        ResponseState.accepted: 'Принято',
        ResponseState.declined: 'Отклонено',
      });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final leading = ClipOval(
      child: FadeInImage(
        fit: BoxFit.cover,
        width: 40,
        height: 40,
        image: avatarUrl.isNotEmpty
            ? NetworkImage(avatarUrl)
            : AssetImage('assets/avatar.png'),
        placeholder: MemoryImage(kTransparentImage),
      ),
    );

    final titleRow = Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          formatState(state),
          style: textTheme.caption,
        ),
      ],
    );

    final subtitleText = Text(subtitle);

    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: leading,
        title: titleRow,
        subtitle: subtitleText,
      ),
    );
  }
}
