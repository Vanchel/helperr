import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'social_link_page.dart';
import '../../cubit/edit_list_cubit.dart';
import '../../../../widgets/list_action_header.dart';

class SocialLinkView extends StatelessWidget {
  const SocialLinkView({Key key, @required this.onChanged}) : super(key: key);

  final void Function(List<String>) onChanged;

  Widget _buildItemView(BuildContext context, String socialLink, int index) {
    final onDelete = () {
      context.read<EditListCubit<String>>().deleteValue(index);
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
              context.read<EditListCubit<String>>().addValue(socialLink);
            },
          ),
        ));
    };

    return Card(
      child: ListTile(
        title: Text(socialLink),
        trailing: IconButton(
          icon: const Icon(Icons.delete_rounded),
          splashRadius: 24.0,
          onPressed: onDelete,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditListCubit<String>>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditSocialLinkPage(
            onSave: (socialLink) {
              cubit.addValue(socialLink);
            },
          );
        },
      ));
    };

    return Column(
      children: [
        ListActionHeader('Ссылки на сторонние ресурсы',
            actionLabel: 'Добавить', action: onAdd),
        BlocBuilder<EditListCubit<String>, List<String>>(
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
