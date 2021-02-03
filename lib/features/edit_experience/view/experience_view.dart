import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_experience/cubit/experience_cubit.dart';
import 'package:helperr/features/edit_experience/view/experience_page.dart';

class ExperienceView extends StatelessWidget {
  const ExperienceView({Key key, @required this.onChanged}) : super(key: key);

  final Function(List<Exp>) onChanged;

  Widget _buildExperienceCard(BuildContext context, Exp experience, int index) {
    final experienceCubit = BlocProvider.of<ExperienceCubit>(context);

    final onDelete = () {
      context.read<ExperienceCubit>().deleteExperience(index);
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
            onPressed: () =>
                context.read<ExperienceCubit>().addExperience(experience),
          ),
        ));
    };

    final onEdit =
        // education == null ? null :
        () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditExperiencePage(
            onSave: (editedExperience) =>
                experienceCubit.editExperience(editedExperience, index),
            isEditing: true,
            experience: experience,
          );
        },
      ));
    };

    return Card(
      child: ListTile(
        title: Text(experience.position),
        subtitle: Text(experience.company),
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
    final themeData = Theme.of(context);
    final experienceCubit = BlocProvider.of<ExperienceCubit>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditExperiencePage(
            onSave: (experience) => experienceCubit.addExperience(experience),
            isEditing: false,
          );
        },
      ));
    };

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Опыт работы', style: themeData.textTheme.subtitle1),
            OutlinedButton(
              child: const Text('Добавить'),
              onPressed: onAdd,
            ),
          ],
        ),
        BlocBuilder<ExperienceCubit, List<Exp>>(
          builder: (context, state) {
            if (onChanged != null) {
              onChanged(state);
            }

            return Column(
              children: List.generate(
                state.length,
                (index) => _buildExperienceCard(context, state[index], index),
              ).toList(),
            );
          },
        ),
      ],
    );
  }
}
