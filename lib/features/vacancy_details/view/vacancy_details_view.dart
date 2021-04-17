import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/favorite/widgets/favorite_button/view/favorite_button.dart';
import 'package:helperr/features/response/worker/view/worker_response_loading_page.dart';
import 'package:helperr/widgets/custom_back_button.dart';
import 'package:intl/intl.dart';

import '../cubit/vacancy_details_loading_cubit.dart';
import '../../../widgets/loading_screen.dart';
import '../../../widgets/error_screen.dart';
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

  String _formatDate(DateTime date) => DateFormat('dd.MM.yyyy').format(date);

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
            return ErrorScreen(
              onRetry: () =>
                  context.read<VacancyDetailsLoadingCubit>().loadVacancy(),
            );
          } else if (state is VacancyLoadSuccess) {
            final textTheme = Theme.of(context).textTheme;

            final vacancy = state.vacancy;

            final vacancyNameWidget = Text(
              vacancy.vacancyName ?? '?Название вакансии?',
              style: textTheme.headline5,
            );

            Widget vacancyIndustryWidget;
            if (vacancy.industry?.isNotEmpty ?? false) {
              vacancyIndustryWidget = Text(
                vacancy.industry,
                style: textTheme.overline,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            } else {
              vacancyIndustryWidget = const SizedBox.shrink();
            }

            final salaryWidget = Text(
              ((vacancy.salary ?? -1) != -1)
                  ? '${vacancy.salary} руб. в месяц'
                  : 'з/п не указана',
              style: textTheme.headline6,
              overflow: TextOverflow.ellipsis,
            );

            final headFooter = Row(
              children: [
                Expanded(
                  child: Text(
                    (vacancy.address?.name?.isNotEmpty ?? false)
                        ? vacancy.address.name
                        : 'Местоположение неизвестно',
                    style: textTheme.subtitle2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  (vacancy.pubDate != null)
                      ? _formatDate(vacancy.pubDate)
                      : '?дата публикации?',
                  style: textTheme.subtitle2,
                ),
              ],
            );

            final favoriteRow = Row(
              children: [
                Expanded(
                  child: Text(
                    'Добавить в избранное:',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                FavoriteButton(
                  id: vacancy.id,
                  isInFavorite: vacancy.favorited,
                ),
              ],
            );

            final gradeWidget = Row(
              children: [
                Expanded(
                  child: Text(
                    'Уровень должности:',
                    style: textTheme.subtitle1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  _grade(vacancy.grade),
                  style: textTheme.subtitle1,
                ),
              ],
            );

            final expWidget = Row(
              children: [
                Expanded(
                  child: Text(
                    'Опыт работы:',
                    style: textTheme.subtitle1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  _exp(vacancy.exp),
                  style: textTheme.subtitle1,
                ),
              ],
            );

            Widget workTypeWidget;
            if (vacancy.workType?.isNotEmpty ?? false) {
              final workTypeList = List.from(vacancy.workType);

              workTypeWidget = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Типы работы:',
                    style: textTheme.subtitle1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: workTypeList.length,
                      itemBuilder: (context, index) {
                        return Chip(
                            label: Text(_workType(workTypeList[index])));
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 4.0),
                    ),
                  ),
                ],
              );
            } else {
              workTypeWidget = const SizedBox.shrink();
            }

            final leadingTextWidget = Text(
              vacancy.leading ?? '',
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

            final tagsWidget = SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: vacancy.tags.length,
                itemBuilder: (context, index) {
                  return Chip(label: Text(vacancy.tags[index]));
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 4.0),
              ),
            );

            Widget respondWidget;
            if (vacancy.gotResponsed) {
              respondWidget = Text(
                'Вы уже откликнулись на эту вакансию.',
                style: textTheme.caption,
              );
            } else {
              final onRespond = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkerResponsePage(
                        onSave: () {},
                        vacancyId: vacancy.id,
                        employerId: vacancy.userId,
                      ),
                    ));
              };

              respondWidget = ElevatedButton(
                child: Text('Откликнуться'),
                onPressed: onRespond,
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(c.scaffoldBodyPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  vacancyNameWidget,
                  vacancyIndustryWidget,
                  SizedBox(height: 16.0),
                  salaryWidget,
                  headFooter,
                  favoriteRow,
                  Divider(),
                  gradeWidget,
                  expWidget,
                  workTypeWidget,
                  Divider(),
                  leadingTextWidget,
                  scrollsWidget,
                  trailingTextWidget,
                  SizedBox(height: 16.0),
                  tagsWidget,
                  Divider(),
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
