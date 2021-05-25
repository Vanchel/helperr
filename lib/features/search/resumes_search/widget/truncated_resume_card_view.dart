import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/favorite/widgets/favorite_button/view/favorite_button.dart';
import 'package:helperr/features/response/employer/view/employer_response_loading_page.dart';
import 'package:helperr/features/resume_details/view/resume_details_page.dart';
import 'package:helperr/features/search/cubit/card_actions_cubit.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../data_layer/model/truncated_resume.dart';

class TruncatedResumeCardView extends StatelessWidget {
  const TruncatedResumeCardView({
    Key key,
    @required this.resume,
  })  : assert(resume != null),
        super(key: key);

  final TruncatedResume resume;

  String get _formattedPubDate =>
      DateFormat('dd.MM.yyyy').format(resume.pubDate);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final ImageProvider image = resume.photoUrl?.isNotEmpty ?? false
        ? NetworkImage(resume.photoUrl)
        : AssetImage('assets/avatar.png');

    final header = ListTile(
      leading: ClipOval(
        child: FadeInImage(
          fit: BoxFit.cover,
          width: 40,
          height: 40,
          image: image,
          placeholder: MemoryImage(kTransparentImage),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              resume.vacancyName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text((resume.salary != -1)
              ? '${resume.salary} руб.'
              : 'з/п не указана'),
        ],
      ),
      subtitle: Text(
        resume.workerName,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );

    Widget description;
    if (resume.about?.isNotEmpty ?? false) {
      description = Container(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          resume.about,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: textTheme.bodyText2.copyWith(color: textTheme.caption.color),
        ),
      );
    } else {
      description = const SizedBox.shrink();
    }

    final footer = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(child: const SizedBox.shrink()),
          Text(_formattedPubDate, style: textTheme.caption),
        ],
      ),
    );

    final divider = const Divider();

    final responseCallback = () => context.read<CardActionsCubit>().respond();
    final favoriteCallback = (newValue) =>
        context.read<CardActionsCubit>().changeFavorited(newValue);

    final onRespond = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployerResponsePage(
            onSave: responseCallback,
            resumeId: resume.id,
            workerId: resume.workerId,
          ),
        ),
      );
    };

    final actions = BlocBuilder<CardActionsCubit, CardActionsState>(
      builder: (context, state) {
        return ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          layoutBehavior: ButtonBarLayoutBehavior.constrained,
          children: [
            TextButton(
              onPressed: resume.gotResponsed ? null : onRespond,
              child: Text('Пригласить'.toUpperCase()),
            ),
            FavoriteButton(
              key: GlobalKey(),
              id: resume.id,
              isInFavorite: resume.favorited,
              onChanged: favoriteCallback,
            ),
          ],
        );
      },
    );

    final onCardTap = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResumeDetailsPage(
            resumeName: resume.vacancyName,
            resumeId: resume.id,
            onRespond: responseCallback,
            onFavoriteChanged: favoriteCallback,
          ),
        ),
      );
    };

    return Card(
      margin: const EdgeInsets.all(0.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onCardTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            header,
            description,
            footer,
            divider,
            actions,
          ],
        ),
      ),
    );
  }
}
