import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/models.dart';
import 'package:helperr/features/edit_education/cubit/education_cubit.dart';
import 'package:helperr/features/edit_education/view/education_page.dart';

class EducationView extends StatelessWidget {
  const EducationView({Key key, @required this.onChanged}) : super(key: key);

  final Function(List<Education>) onChanged;

  Widget _buildEducationCard(
      BuildContext context, Education education, int index) {
    final educationCubit = BlocProvider.of<EducationCubit>(context);

    final onDelete = () {
      context.read<EducationCubit>().deleteEducation(index);
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
                context.read<EducationCubit>().addEducation(education),
          ),
        ));
    };

    final onEdit =
        // education == null ? null :
        () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditEducationPage(
            onSave: (editedEducation) =>
                educationCubit.editEducation(editedEducation, index),
            isEditing: true,
            education: education,
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
    final themeData = Theme.of(context);
    final educationCubit = BlocProvider.of<EducationCubit>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditEducationPage(
            onSave: (education) => educationCubit.addEducation(education),
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
            Text('Образование', style: themeData.textTheme.subtitle1),
            OutlinedButton(
              child: const Text('Добавить'),
              onPressed: onAdd,
            ),
          ],
        ),
        BlocBuilder<EducationCubit, List<Education>>(
          builder: (context, state) {
            if (onChanged != null) {
              onChanged(state);
            }

            return Column(
              children: List.generate(
                state.length,
                (index) => _buildEducationCard(context, state[index], index),
              ).toList(),
            );
          },
        ),
      ],
    );
  }
}
