import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'education_page.dart';
import '../../cubit/edit_list_cubit.dart';
import '../../../../data_layer/model/worker.dart';
import '../../../../widgets/list_action_header.dart';

class EducationView extends StatelessWidget {
  const EducationView({Key key, @required this.onChanged}) : super(key: key);

  final void Function(List<Education>) onChanged;

  Widget _buildItemView(BuildContext context, Education education, int index) {
    final cubit = BlocProvider.of<EditListCubit<Education>>(context);

    final onDelete = () {
      context.read<EditListCubit<Education>>().deleteValue(index);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(
            'Элемент удален',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          action: SnackBarAction(
            label: 'отменить',
            onPressed: () {
              context.read<EditListCubit<Education>>().addValue(education);
            },
          ),
        ));
    };

    final onEdit = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditEducationPage(
            isEditing: true,
            education: education,
            onSave: (editedEducation) {
              cubit.editValue(editedEducation, index);
            },
          );
        },
      ));
    };

    return Card(
      child: ListTile(
        title: Text(education.profession),
        subtitle: Text(education.university),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              splashRadius: 24.0,
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_rounded),
              splashRadius: 24.0,
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditListCubit<Education>>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditEducationPage(
            isEditing: false,
            onSave: (education) {
              cubit.addValue(education);
            },
          );
        },
      ));
    };

    return Column(
      children: [
        ListActionHeader('Образование', actionLabel: 'Добавить', action: onAdd),
        BlocBuilder<EditListCubit<Education>, List<Education>>(
          builder: (context, state) {
            if (onChanged != null) {
              onChanged(state);
            }
            return Column(
              children: List.generate(state.length, (index) {
                return _buildItemView(context, state[index], index);
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
