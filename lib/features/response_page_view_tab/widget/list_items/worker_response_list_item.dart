import 'package:flutter/material.dart';

import 'detailed_response_list_item.dart';
import '../../../../data_layer/model/detailed_response.dart';

class WorkerResponseListItem extends StatelessWidget {
  const WorkerResponseListItem({
    Key key,
    @required this.response,
    @required this.onTap,
  }) : super(key: key);

  final DetailedResponse response;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DetailedResponseListItem(
      title: response.vacancyName,
      subtitle: response.employerName,
      avatarUrl: response.employerAvatar,
      state: response.state,
      onTap: onTap,
    );
  }
}
