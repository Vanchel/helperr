import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../data_layer/model/detailed_response.dart';
import '../../../data_layer/model/response_state.dart';
import '../../../data_layer/model/user_type.dart';
import '../view/response_detail_view.dart';

class DetailedResponseListItem extends StatelessWidget {
  const DetailedResponseListItem({
    Key key,
    @required this.response,
    @required this.sender,
  }) : super(key: key);

  final DetailedResponse response;
  final UserType sender;

  String formatState(ResponseState state) => Intl.select(state, {
        ResponseState.sent: 'Не просмотрено',
        ResponseState.viewed: 'Просмотрено',
        ResponseState.accepted: 'Принято',
        ResponseState.declined: 'Отклонено',
      });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final avatarUrl = sender == UserType.employer
        ? response.employerAvatar
        : response.workerAvatar;

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
            response.vacancyName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          formatState(response.state),
          style: textTheme.caption,
        ),
      ],
    );

    final subtitleText = Text(response.cvName);

    final onTap = () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResponseDetailView(
              response: response,
              sender: sender,
              onChange: () {},
            ),
          ),
        );

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
