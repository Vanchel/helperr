import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_social_links/cubit/social_links_cubit.dart';
import 'package:helperr/features/edit_social_links/view/social_link_page.dart';
import 'package:helperr/widgets/list_action_header.dart';

class SocialLinksView extends StatelessWidget {
  const SocialLinksView({Key key, @required this.onChanged}) : super(key: key);

  final Function(List<String>) onChanged;

  Widget _buildSocialLinkCard(BuildContext context, String link, int index) {
    return Card(
      child: ListTile(
        title: Text(link),
        trailing: IconButton(
          icon: const Icon(Icons.delete_rounded),
          splashRadius: 24.0,
          onPressed: () {
            context.read<SocialLinksCubit>().deleteLink(index);
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
                      context.read<SocialLinksCubit>().addLink(link),
                ),
              ));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final socialLinksCubit = BlocProvider.of<SocialLinksCubit>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditSocialLinkPage(
            onSave: (socialLink) => socialLinksCubit.addLink(socialLink),
          );
        },
      ));
    };

    return Column(
      children: [
        ListActionHeader('Ссылки на соц. сети',
            actionLabel: 'Добавить', action: onAdd),
        BlocBuilder<SocialLinksCubit, List<String>>(
          builder: (context, state) {
            if (onChanged != null) {
              onChanged(state);
            }

            return Column(
              children: List.generate(
                state.length,
                (index) => _buildSocialLinkCard(context, state[index], index),
              ).toList(),
            );
          },
        ),
      ],
    );
  }
}
