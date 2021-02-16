import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_page.dart';
import '../../cubit/edit_list_cubit.dart';
import '../../../../data_layer/model/worker.dart';
import '../../../../widgets/list_action_header.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({Key key, @required this.onChanged}) : super(key: key);

  final void Function(List<Language>) onChanged;

  Widget _buildItemView(BuildContext context, Language language, int index) {
    final cubit = BlocProvider.of<EditListCubit<Language>>(context);

    final onDelete = () {
      context.read<EditListCubit<Language>>().deleteValue(index);
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
              context.read<EditListCubit<Language>>().addValue(language);
            },
          ),
        ));
    };

    final onEdit = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditLanguagePage(
            isEditing: true,
            language: language,
            onSave: (editedLanguage) {
              cubit.editValue(editedLanguage, index);
            },
          );
        },
      ));
    };

    return Card(
      child: ListTile(
        title: Text(language.language),
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
    final cubit = BlocProvider.of<EditListCubit<Language>>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditLanguagePage(
            isEditing: false,
            onSave: (language) {
              cubit.addValue(language);
            },
          );
        },
      ));
    };

    return Column(
      children: [
        ListActionHeader('Владение языками',
            actionLabel: 'Добавить', action: onAdd),
        BlocBuilder<EditListCubit<Language>, List<Language>>(
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
