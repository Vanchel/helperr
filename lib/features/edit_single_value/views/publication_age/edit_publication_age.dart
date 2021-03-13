import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_publication_age_view.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/publication_age.dart';

class EditPublicationAge extends StatelessWidget {
  const EditPublicationAge({
    Key key,
    this.initialValue = PublicationAge.allTime,
    this.onChanged,
  }) : super(key: key);

  final PublicationAge initialValue;
  final Function(PublicationAge) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSingleValueCubit<PublicationAge>(initialValue),
      child: PublicationAgeDropdownButton(onChanged: onChanged),
    );
  }
}
