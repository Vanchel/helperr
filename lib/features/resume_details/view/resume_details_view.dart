import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/favorite/widgets/favorite_button/view/favorite_button.dart';
import 'package:helperr/features/response/employer/view/employer_response_loading_page.dart';
import 'package:helperr/widgets/custom_back_button.dart';
import 'package:helperr/widgets/error_screen/error_indicator.dart';
import 'package:intl/intl.dart';

import '../cubit/resume_details_loading_cubit.dart';
import '../../../widgets/loading_screen.dart';
import '../../../constants.dart' as c;

import '../../../data_layer/model/experience_type.dart';
import '../../../data_layer/model/work_type.dart';

class ResumeDetailsView extends StatelessWidget {
  const ResumeDetailsView({
    Key key,
    this.resumeName,
  }) : super(key: key);

  final String resumeName;

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
        title: Text(resumeName),
      ),
      body: BlocBuilder<ResumeDetailsLoadingCubit, ResumeDetailsLoadingState>(
        builder: (context, state) {
          if (state is ResumeLoadFailure) {
            return ErrorIndicator(
              error: state.error,
              onTryAgain: () =>
                  context.read<ResumeDetailsLoadingCubit>().loadResume(),
            );
          } else if (state is ResumeLoadSuccess) {
            final textTheme = Theme.of(context).textTheme;

            final resume = state.resume;

            final titleWidget = ListTile(
              contentPadding: const EdgeInsets.all(0.0),
              title: Text(
                resume.vacancyName ?? '?Название резюме?',
                style: textTheme.headline5,
              ),
              subtitle: Text(
                ((resume.salary ?? c.salaryNotSpecified) !=
                        c.salaryNotSpecified)
                    ? '${resume.salary} руб. в месяц'
                    : 'з/п не указана',
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: FavoriteButton(
                id: resume.id,
                isInFavorite: resume.favorited,
              ),
            );

            Widget workTypeWidget;
            if (resume.workType?.isNotEmpty ?? false) {
              final workTypeList = List.from(resume.workType);

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
                Text(resume.industry),
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
                Text(_grade(resume.grade)),
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
                Text((resume.pubDate != null)
                    ? _formatDate(resume.pubDate)
                    : '?дата публикации?'),
              ],
            );

            final aboutTextWidget = Text(
              (resume.about?.isNotEmpty ?? false)
                  ? resume.about
                  : '- нет описания -',
              style: textTheme.bodyText2,
            );

            Widget tagsWidget;
            if (resume.tags?.isNotEmpty ?? false) {
              final tagsList = List.from(resume.tags);

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

            Widget respondWidget;
            if (resume.gotResponsed) {
              respondWidget = Text(
                'Обмен откликами уже был начат.',
                style: textTheme.caption,
              );
            } else {
              final onRespond = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployerResponsePage(
                        onSave: () {},
                        resumeId: resume.id,
                        workerId: resume.userId,
                      ),
                    ));
              };

              respondWidget = ElevatedButton(
                child: Text('Пригласить'),
                onPressed: onRespond,
              );
            }

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
                  pubDateRow,
                  divider,
                  aboutTextWidget,
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
