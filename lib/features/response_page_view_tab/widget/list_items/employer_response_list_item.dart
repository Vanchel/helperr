import 'package:flutter/material.dart';

import 'detailed_response_list_item.dart';
import '../../../../data_layer/model/detailed_response.dart';

class EmployerResponseListItem extends StatelessWidget {
  const EmployerResponseListItem({
    Key key,
    @required this.response,
    @required this.onTap,
  }) : super(key: key);

  final DetailedResponse response;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DetailedResponseListItem(
      title: response.cvName,
      subtitle: response.workerName,
      avatarUrl: response.workerAvatar,
      state: response.state,
      onTap: onTap,
    );
  }
}
