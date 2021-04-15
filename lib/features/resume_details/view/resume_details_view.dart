import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/response/employer/view/employer_response_loading_page.dart';
import 'package:intl/intl.dart';

import '../cubit/resume_details_loading_cubit.dart';
import '../../../widgets/loading_screen.dart';
import '../../../widgets/error_screen.dart';
import '../../../constants.dart' as c;

import '../../../data_layer/model/experience_type.dart';
import '../../../data_layer/model/work_type.dart';

class ResumeDetailsView extends StatelessWidget {
  const ResumeDetailsView({
    Key key,
    this.resumeName,
  }) : super(key: key);

  final String resumeName;

  String _formatDate(DateTime date) => DateFormat('dd.MM.yyyy').format(date);

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          splashRadius: c.iconButtonSplashRadius,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(resumeName),
      ),
      body: BlocBuilder<ResumeDetailsLoadingCubit, ResumeDetailsLoadingState>(
        builder: (context, state) {
          if (state is ResumeLoadFailure) {
            return ErrorScreen(
              onRetry: () =>
                  context.read<ResumeDetailsLoadingCubit>().loadResume(),
            );
          } else if (state is ResumeLoadSuccess) {
            final textTheme = Theme.of(context).textTheme;

            final resume = state.resume;

            final resumeNameWidget = Text(
              resume.vacancyName ?? '?Название резюме?',
              style: textTheme.headline5,
            );

            Widget resumeIndustryWidget;
            if (resume.industry?.isNotEmpty ?? false) {
              resumeIndustryWidget = Text(
                resume.industry,
                style: textTheme.overline,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            } else {
              resumeIndustryWidget = const SizedBox.shrink();
            }

            final salaryWidget = Text(
              ((resume.salary ?? -1) != -1)
                  ? '${resume.salary} руб. в месяц'
                  : 'з/п не указана',
              style: textTheme.headline6,
              overflow: TextOverflow.ellipsis,
            );

            final headFooter = Row(
              children: [
                Expanded(child: const SizedBox.shrink()),
                Text(
                  (resume.pubDate != null)
                      ? _formatDate(resume.pubDate)
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
                IconButton(
                  icon: const Icon(Icons.favorite_border_rounded),
                  splashRadius: c.iconButtonSplashRadius,
                  onPressed: () {},
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
                  _grade(resume.grade),
                  style: textTheme.subtitle1,
                ),
              ],
            );

            Widget workTypeWidget;
            if (resume.workType?.isNotEmpty ?? false) {
              final workTypeList = List.from(resume.workType);

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

            final aboutTextWidget = Text(
              resume.about ?? '',
              style: textTheme.bodyText2,
            );

            final tagsWidget = SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: resume.tags.length,
                itemBuilder: (context, index) {
                  return Chip(label: Text(resume.tags[index]));
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 4.0),
              ),
            );

            final onRespondClick = () {
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

            final respondButton = ElevatedButton(
              onPressed: resume.gotResponsed ? null : onRespondClick,
              child: Text('Пригласить'),
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.all(c.scaffoldBodyPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  resumeNameWidget,
                  resumeIndustryWidget,
                  SizedBox(height: 16.0),
                  salaryWidget,
                  headFooter,
                  favoriteRow,
                  Divider(),
                  gradeWidget,
                  workTypeWidget,
                  Divider(),
                  aboutTextWidget,
                  SizedBox(height: 16.0),
                  tagsWidget,
                  Divider(),
                  respondButton,
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
