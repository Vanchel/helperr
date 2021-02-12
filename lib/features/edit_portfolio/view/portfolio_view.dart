import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/resume.dart';
import 'package:helperr/features/edit_portfolio/cubit/portfolio_cubit.dart';
import 'package:helperr/features/edit_portfolio/view/portfolio_page.dart';
import 'package:helperr/widgets/list_action_header.dart';

class PortfolioView extends StatelessWidget {
  const PortfolioView({Key key, @required this.onChanged}) : super(key: key);

  final Function(List<Portfolio>) onChanged;

  Widget _buildPortfolioCard(
      BuildContext context, Portfolio portfolio, int index) {
    final portfolioCubit = BlocProvider.of<PortfolioCubit>(context);

    final onDelete = () {
      context.read<PortfolioCubit>().deletePortfolio(index);
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
                context.read<PortfolioCubit>().addPortfolio(portfolio),
          ),
        ));
    };

    final onEdit =
        // education == null ? null :
        () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditPortfolioPage(
            onSave: (editedPortfolio) =>
                portfolioCubit.editPortfolio(editedPortfolio, index),
            isEditing: true,
            portfolio: portfolio,
          );
        },
      ));
    };

    return Card(
      child: ListTile(
        title: Text(portfolio.sourceLink),
        subtitle: Text(portfolio.imgLink),
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
    final portfolioCubit = BlocProvider.of<PortfolioCubit>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditPortfolioPage(
            onSave: (portfolio) => portfolioCubit.addPortfolio(portfolio),
            isEditing: false,
          );
        },
      ));
    };

    return Column(
      children: [
        ListActionHeader('Ссылки на портфолио',
            actionLabel: 'Добавить', action: onAdd),
        BlocBuilder<PortfolioCubit, List<Portfolio>>(
          builder: (context, state) {
            if (onChanged != null) {
              onChanged(state);
            }

            return Column(
              children: List.generate(
                state.length,
                (index) => _buildPortfolioCard(context, state[index], index),
              ).toList(),
            );
          },
        ),
      ],
    );
  }
}
