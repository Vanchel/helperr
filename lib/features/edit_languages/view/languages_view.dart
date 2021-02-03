import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_languages/cubit/languages_cubit.dart';
import 'package:helperr/features/edit_languages/view/language_page.dart';

class LanguagesView extends StatelessWidget {
  const LanguagesView({Key key, @required this.onChanged}) : super(key: key);

  final Function(List<Language>) onChanged;

  Widget _buildLanguageCard(
      BuildContext context, Language language, int index) {
    final languagesCubit = BlocProvider.of<LanguagesCubit>(context);

    final onDelete = () {
      context.read<LanguagesCubit>().deleteLanguage(index);
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
                context.read<LanguagesCubit>().addLanguage(language),
          ),
        ));
    };

    final onEdit =
        // education == null ? null :
        () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditLanguagePage(
            onSave: (editedLanguage) =>
                languagesCubit.editLanguage(editedLanguage, index),
            isEditing: true,
            language: language,
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
    final themeData = Theme.of(context);
    final languagesCubit = BlocProvider.of<LanguagesCubit>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditLanguagePage(
            onSave: (language) => languagesCubit.addLanguage(language),
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
            Text('Владение языками', style: themeData.textTheme.subtitle1),
            OutlinedButton(
              child: const Text('Добавить'),
              onPressed: onAdd,
            ),
          ],
        ),
        BlocBuilder<LanguagesCubit, List<Language>>(
          builder: (context, state) {
            if (onChanged != null) {
              onChanged(state);
            }

            return Column(
              children: List.generate(
                state.length,
                (index) => _buildLanguageCard(context, state[index], index),
              ).toList(),
            );
          },
        ),
      ],
    );
  }
}
