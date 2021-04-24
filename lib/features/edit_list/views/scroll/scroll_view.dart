import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'scroll_page.dart';
import '../../cubit/edit_list_cubit.dart';
import '../../../../data_layer/model/models.dart';
import '../../../../widgets/list_action_header.dart';
import '../../../../constants.dart' as c;

class ScrollsView extends StatelessWidget {
  const ScrollsView({Key key, @required this.onChanged}) : super(key: key);

  final void Function(List<Scroll>) onChanged;

  Widget _buildItemView(BuildContext context, Scroll scroll, int index) {
    final cubit = BlocProvider.of<EditListCubit<Scroll>>(context);

    final onDelete = () {
      context.read<EditListCubit<Scroll>>().deleteValue(index);
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
              context.read<EditListCubit<Scroll>>().addValue(scroll);
            },
          ),
        ));
    };

    final onEdit = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditScrollPage(
            isEditing: true,
            scroll: scroll,
            onSave: (editedScroll) {
              cubit.editValue(scroll, index);
            },
          );
        },
      ));
    };

    return Card(
      margin: const EdgeInsets.symmetric(vertical: c.defaultMargin),
      child: ListTile(
        title: Text(
          scroll.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          scroll.subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
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
    final cubit = BlocProvider.of<EditListCubit<Scroll>>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditScrollPage(
            isEditing: false,
            onSave: (scroll) {
              cubit.addValue(scroll);
            },
          );
        },
      ));
    };

    return Column(
      children: [
        ListAddHeader('Список перечней', action: onAdd),
        BlocBuilder<EditListCubit<Scroll>, List<Scroll>>(
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
