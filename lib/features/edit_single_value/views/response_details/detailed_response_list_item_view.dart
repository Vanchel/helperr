import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import 'response_detail_view.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/models.dart';
import '../../../../data_layer/model/detailed_response.dart';
import '../../../../data_layer/model/response_state.dart';
import '../../../../data_layer/model/user_type.dart';

class DetailedResponseListItemView extends StatelessWidget {
  const DetailedResponseListItemView({
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
        BlocBuilder<EditSingleValueCubit<ResponseState>, ResponseState>(
          builder: (context, state) => Text(
            formatState(state),
            style: textTheme.caption,
          ),
        ),
      ],
    );

    final subtitleText = Text(response.cvName);

    final onTap = () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<EditSingleValueCubit<ResponseState>>(
                    context),
                child: ResponseDetailView(
                  response: response,
                  sender: sender,
                  onChange: (newState) => context
                      .read<EditSingleValueCubit<ResponseState>>()
                      .changeValue(newState),
                ),
              );
            },
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
