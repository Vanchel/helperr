import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'experience_page.dart';
import '../../cubit/edit_list_cubit.dart';
import '../../../../data_layer/model/models.dart';
import '../../../../widgets/list_action_header.dart';
import '../../../../constants.dart' as c;

class ExperienceView extends StatelessWidget {
  const ExperienceView({Key key, @required this.onChanged}) : super(key: key);

  final void Function(List<Exp>) onChanged;

  Widget _buildItemView(BuildContext context, Exp experience, int index) {
    final cubit = BlocProvider.of<EditListCubit<Exp>>(context);

    final onDelete = () {
      context.read<EditListCubit<Exp>>().deleteValue(index);
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
              context.read<EditListCubit<Exp>>().addValue(experience);
            },
          ),
        ));
    };

    final onEdit = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditExperiencePage(
            isEditing: true,
            experience: experience,
            onSave: (editedExperience) {
              cubit.editValue(editedExperience, index);
            },
          );
        },
      ));
    };

    return Card(
      margin: const EdgeInsets.symmetric(vertical: c.defaultMargin),
      child: ListTile(
        title: Text(experience.position),
        subtitle: Text(experience.company),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              splashRadius: c.iconButtonSplashRadius,
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_rounded),
              splashRadius: c.iconButtonSplashRadius,
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditListCubit<Exp>>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditExperiencePage(
            isEditing: false,
            onSave: (experience) {
              cubit.addValue(experience);
            },
          );
        },
      ));
    };

    return Column(
      children: [
        ListAddHeader('Опыт работы', action: onAdd),
        BlocBuilder<EditListCubit<Exp>, List<Exp>>(
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
