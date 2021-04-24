import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'portfolio_page.dart';
import '../../cubit/edit_list_cubit.dart';
import '../../../../data_layer/model/portfolio.dart';
import '../../../../widgets/list_action_header.dart';
import '../../../../constants.dart' as c;

class PortfolioView extends StatelessWidget {
  const PortfolioView({Key key, @required this.onChanged}) : super(key: key);

  final void Function(List<Portfolio>) onChanged;

  Widget _buildItemView(BuildContext context, Portfolio portfolio, int index) {
    final cubit = BlocProvider.of<EditListCubit<Portfolio>>(context);

    final onDelete = () {
      context.read<EditListCubit<Portfolio>>().deleteValue(index);
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
              context.read<EditListCubit<Portfolio>>().addValue(portfolio);
            },
          ),
        ));
    };

    final onEdit = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditPortfolioPage(
            isEditing: true,
            portfolio: portfolio,
            onSave: (editedPortfolio) {
              cubit.editValue(editedPortfolio, index);
            },
          );
        },
      ));
    };

    return Card(
      margin: const EdgeInsets.symmetric(vertical: c.defaultMargin),
      child: ListTile(
        title: Text(portfolio.sourceLink),
        subtitle: Text(portfolio.imgLink),
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
    final cubit = BlocProvider.of<EditListCubit<Portfolio>>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditPortfolioPage(
            isEditing: false,
            onSave: (portfolio) {
              cubit.addValue(portfolio);
            },
          );
        },
      ));
    };

    return Column(
      children: [
        ListAddHeader('Ссылки на портфолио', action: onAdd),
        BlocBuilder<EditListCubit<Portfolio>, List<Portfolio>>(
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
