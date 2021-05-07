import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/favorite/widgets/favorite_button/view/favorite_button.dart';
import 'package:helperr/features/vacancy_details/widgets/respond_block.dart';
import 'package:helperr/widgets/custom_back_button.dart';
import 'package:helperr/widgets/error_screen/error_indicator.dart';
import 'package:intl/intl.dart';

import '../cubit/vacancy_details_loading_cubit.dart';
import '../../../widgets/loading_screen.dart';
import '../../../constants.dart' as c;

import '../../../data_layer/model/experience_type.dart';
import '../../../data_layer/model/experience_duration.dart';
import '../../../data_layer/model/work_type.dart';

class VacancyDetailsView extends StatelessWidget {
  const VacancyDetailsView({
    Key key,
    this.vacancyName,
  }) : super(key: key);

  final String vacancyName;

  String _formatDate(DateTime date) =>
      DateFormat('dd.MM.yyyy, HH:mm').format(date);

  String _grade(ExperienceType grade) => Intl.select(grade, {
        ExperienceType.internship: 'Стажировка',
        ExperienceType.junior: 'Младший специалист',
        ExperienceType.middle: 'Средний специалист',
        ExperienceType.senior: 'Старший специалист',
        ExperienceType.director: 'Руководитель',
        ExperienceType.seniorDirector: 'Старший руководитель',
      });

  String _exp(ExperienceDuration exp) => Intl.select(exp, {
        ExperienceDuration.noExperience: 'Без опыта работы',
        ExperienceDuration.lessThanYear: 'Меньше года',
        ExperienceDuration.oneToThreeYears: '1-3 года',
        ExperienceDuration.threeToFiveYears: '3-5 лет',
        ExperienceDuration.moreThanFiveYears: 'Более пяти лет',
      });

  String _workType(WorkType workType) => Intl.select(workType, {
        WorkType.fullDay: 'Полный день',
        WorkType.partDay: 'Неполный день',
        WorkType.fullTime: 'Полная занятость',
        WorkType.partTime: 'Частичная занятость',
        WorkType.volunteer: 'Волонтерство',
        WorkType.oneTimeJob: 'Разовое задание',
        WorkType.flexibleSchedule: 'Гибкий график',
        WorkType.shiftSchedule: 'Сменный график',
        WorkType.shiftMethod: 'Вахтовый метод',
        WorkType.remote: 'Удаленная работа',
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(vacancyName),
      ),
      body: BlocBuilder<VacancyDetailsLoadingCubit, VacancyDetailsLoadingState>(
        builder: (context, state) {
          if (state is VacancyLoadFailure) {
            return ErrorIndicator(
              error: state.error,
              onTryAgain: () =>
                  context.read<VacancyDetailsLoadingCubit>().loadVacancy(),
            );
          } else if (state is VacancyLoadSuccess) {
            final textTheme = Theme.of(context).textTheme;

            final vacancy = state.vacancy;

            final titleWidget = ListTile(
              contentPadding: const EdgeInsets.all(0.0),
              title: Text(
                vacancy.vacancyName ?? '?Название вакансии?',
                style: textTheme.headline5,
              ),
              subtitle: Text(
                ((vacancy.salary ?? c.salaryNotSpecified) !=
                        c.salaryNotSpecified)
                    ? '${vacancy.salary} руб. в месяц'
                    : 'з/п не указана',
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: FavoriteButton(
                id: vacancy.id,
                isInFavorite: vacancy.favorited,
              ),
            );

            Widget workTypeWidget;
            if (vacancy.workType?.isNotEmpty ?? false) {
              final workTypeList = List.from(vacancy.workType);

              workTypeWidget = SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: workTypeList.length,
                  itemBuilder: (context, index) {
                    return Chip(
                      label: Text(_workType(workTypeList[index])),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 4.0);
                  },
                ),
              );
            } else {
              workTypeWidget = const SizedBox.shrink();
            }

            final industryRow = Row(
              children: [
                Expanded(
                  child: Text(
                    'Отрасль',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: textTheme.caption.color),
                  ),
                ),
                Text(vacancy.industry),
              ],
            );

            final gradeRow = Row(
              children: [
                Expanded(
                  child: Text(
                    'Уровень должности',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: textTheme.caption.color),
                  ),
                ),
                Text(_grade(vacancy.grade)),
              ],
            );

            final expRow = Row(
              children: [
                Expanded(
                  child: Text(
                    'Опыт работы',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: textTheme.caption.color),
                  ),
                ),
                Text(_exp(vacancy.exp)),
              ],
            );

            final addressRow = Row(
              children: [
                Expanded(
                  child: Text(
                    'Место работы',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: textTheme.caption.color),
                  ),
                ),
                Text((vacancy.address?.name?.isNotEmpty ?? false)
                    ? vacancy.address.name
                    : 'Не указано'),
              ],
            );

            final pubDateRow = Row(
              children: [
                Expanded(
                  child: Text(
                    'Опубликовано',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: textTheme.caption.color),
                  ),
                ),
                Text((vacancy.pubDate != null)
                    ? _formatDate(vacancy.pubDate)
                    : '?дата публикации?'),
              ],
            );

            final leadingTextWidget = Text(
              (vacancy.leading?.isNotEmpty ?? false)
                  ? vacancy.leading
                  : '- нет описания -',
              style: textTheme.bodyText2,
            );

            Widget scrollsWidget;
            if (vacancy.body?.isNotEmpty ?? false) {
              final scrolls = vacancy.body;

              scrollsWidget = Column(
                children: List.generate(
                  scrolls.length,
                  (index) {
                    final scroll = scrolls[index];

                    return ExpansionTile(
                      title: Text(scroll.title),
                      subtitle: Text(scroll.subtitle),
                      children: List.generate(
                        scroll.points.length,
                        (index) => ListTile(
                            leading: const Icon(Icons.remove_rounded),
                            title: Text(scroll.points[index])),
                      ),
                    );
                  },
                ),
              );
            } else {
              scrollsWidget = const SizedBox.shrink();
            }

            final trailingTextWidget = Text(
              vacancy.trailing ?? '',
              style: textTheme.bodyText2,
            );

            Widget tagsWidget;
            if (vacancy.tags?.isNotEmpty ?? false) {
              final tagsList = List.from(vacancy.tags);

              tagsWidget = SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: tagsList.length,
                  itemBuilder: (context, index) {
                    return Chip(label: Text(tagsList[index]));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 4.0);
                  },
                ),
              );
            } else {
              tagsWidget = const SizedBox.shrink();
            }

            Widget respondWidget = RespondBlock(
              responded: vacancy.gotResponsed,
              vacancy: vacancy,
            );

            final divider = const Divider();

            final spacer = const SizedBox(height: c.defaultMargin);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(c.scaffoldBodyPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  titleWidget,
                  spacer,
                  workTypeWidget,
                  divider,
                  industryRow,
                  spacer,
                  gradeRow,
                  spacer,
                  expRow,
                  spacer,
                  addressRow,
                  spacer,
                  pubDateRow,
                  divider,
                  leadingTextWidget,
                  spacer,
                  scrollsWidget,
                  spacer,
                  trailingTextWidget,
                  spacer,
                  tagsWidget,
                  divider,
                  respondWidget,
                ],
              ),
            );
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }
}
