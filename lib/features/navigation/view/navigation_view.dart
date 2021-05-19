import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/models.dart';
import 'package:helperr/data_layer/model/user_type.dart';
import 'package:helperr/data_layer/repository/authentication_repository.dart';
import 'package:helperr/features/favorite/resumes/view/favorite_resumes_page.dart';
import 'package:helperr/features/favorite/vacancies/view/favorite_vacancies_page.dart';
import 'package:helperr/features/navigation/navigation.dart';
import 'package:helperr/features/response_page_view_tab/repository/detailed_response_repository.dart';
import 'package:helperr/features/response_page_view_tab/view/paged_response_page.dart';
import 'package:helperr/features/search/vacancies_search/view/vacancies_search_result_page.dart';
import 'package:helperr/features/search/vacancies_search/view/vacancy_search_delegate.dart';
import 'package:helperr/features/search/resumes_search/view/resumes_search_result_page.dart';
import 'package:helperr/features/search/resumes_search/view/resume_search_delegate.dart';
import 'package:helperr/features/profile/employer/view/employer_profile_page.dart';
import 'package:helperr/features/profile/worker/view/worker_profile_page.dart';
import 'package:helperr/constants.dart' as c;
import 'package:url_launcher/url_launcher.dart';

class NavigationView extends StatelessWidget {
  Widget _getUserProfilePage(BuildContext context) {
    final user = RepositoryProvider.of<AuthenticationRepository>(context).user;

    if (user.userType == UserType.employee) {
      return WorkerProfilePage(user.id);
    } else if (user.userType == UserType.employer) {
      return EmployerProfilePage(user.id);
    } else {
      return Container();
    }
  }

  SearchDelegate<Widget> _getSearchDelegate(BuildContext context) {
    final user = RepositoryProvider.of<AuthenticationRepository>(context).user;

    if (user.userType == UserType.employee) {
      return VacancySearchDelegate();
    } else if (user.userType == UserType.employer) {
      return ResumeSearchDelegate();
    } else {
      return null;
    }
  }

  Widget _getSearchPage(BuildContext context) {
    final user = RepositoryProvider.of<AuthenticationRepository>(context).user;

    if (user.userType == UserType.employee) {
      return VacanciesSearchResultPage(searchOptions: VacancySearchOptions());
    } else if (user.userType == UserType.employer) {
      return ResumesSearchResultPage(searchOptions: ResumeSearchOptions());
    } else {
      return Container();
    }
  }

  Widget _getResponseViews(BuildContext context) {
    final currentUserType =
        RepositoryProvider.of<AuthenticationRepository>(context).user.userType;

    Widget inboxTab;
    Widget outboxTab;

    if (currentUserType == UserType.employee) {
      inboxTab = PagedResponsePage(
        sender: UserType.employer,
        responseRepository: WorkerInboxRepository(),
      );
      outboxTab = PagedResponsePage(
        sender: UserType.employee,
        responseRepository: WorkerOutboxRepository(),
      );
    } else if (currentUserType == UserType.employer) {
      inboxTab = PagedResponsePage(
        sender: UserType.employee,
        responseRepository: EmployerInboxRepository(),
      );
      outboxTab = PagedResponsePage(
        sender: UserType.employer,
        responseRepository: EmployerOutboxRepository(),
      );
    }

    return TabBarView(children: [inboxTab, outboxTab]);
  }

  Widget _getFavoritesPage(BuildContext context) {
    final user = RepositoryProvider.of<AuthenticationRepository>(context).user;

    if (user.userType == UserType.employee) {
      return FavoriteVacanciesPage();
    } else if (user.userType == UserType.employer) {
      return FavoriteResumesPage();
    } else {
      return Container();
    }
  }

  void _showAppAboutDialog(BuildContext context) {
    final themeData = Theme.of(context);

    final openLink = (String urlString) async {
      if (await canLaunch(urlString)) {
        await launch(urlString);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text('Не удалось найти подходящее приложение'),
          ));
      }
    };

    final getEmailUrl = (String emailAddress, String subject) {
      final _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: emailAddress,
        queryParameters: {
          'subject': subject ?? '',
        },
      );
      return _emailLaunchUri.toString();
    };

    showAboutDialog(
      context: context,
      applicationLegalese: '© 2021 Helperr Все права защищены',
      children: [
        const Divider(),
        ListTile(
          dense: true,
          title: Text('О проекте'),
          onTap: () async => await openLink('http://job-flow.ru'),
        ),
        ListTile(
          dense: true,
          title: Text('Официальный сайт'),
          onTap: () async => await openLink('http://job-flow.ru'),
        ),
        ListTile(
          dense: true,
          title: Text('Пользовательское соглашение'),
          onTap: () async => await openLink('http://job-flow.ru'),
        ),
        ListTile(
          dense: true,
          title: Text('Лицензионное соглашение'),
          onTap: () async => await openLink('http://job-flow.ru'),
        ),
        ListTile(
          dense: true,
          title: Text('Политика конфиденциальности'),
          onTap: () async => await openLink('http://job-flow.ru'),
        ),
        const Divider(),
        Text(
          'Служба поддержки',
          style: themeData.textTheme.bodyText1,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'По вопросам работы приложения: ',
                style: themeData.textTheme.caption,
              ),
              TextSpan(
                text: '175940@edu.fa.ru',
                style: themeData.textTheme.caption
                    .copyWith(color: themeData.accentColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await openLink(getEmailUrl(
                      '175940@edu.fa.ru',
                      'Вопрос по работе мобильного приложения Helperr',
                    ));
                  },
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'По вопросам работы сайта: ',
                style: themeData.textTheme.caption,
              ),
              TextSpan(
                text: '175912@edu.fa.ru',
                style: themeData.textTheme.caption
                    .copyWith(color: themeData.accentColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await openLink(getEmailUrl(
                      '175912@edu.fa.ru',
                      'Вопрос по работе сайта job-flow.ru',
                    ));
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        PreferredSizeWidget appBar;
        if (state == 0) {
          appBar = AppBar(
            title: const Text('Поиск'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded),
                splashRadius: c.iconButtonSplashRadius,
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: _getSearchDelegate(context),
                  );
                },
              ),
            ],
          );
        } else if (state == 1) {
          appBar = AppBar(
            title: const Text('Отклики'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Входящие'.toUpperCase()),
                Tab(text: 'Исходящие'.toUpperCase()),
              ],
            ),
          );
        } else if (state == 2) {
          appBar = AppBar(title: const Text('Избранное'));
        } else if (state == 3) {
          appBar = AppBar(
            title: const Text('Профиль'),
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline_rounded),
                onPressed: () => _showAppAboutDialog(context),
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                splashRadius: c.iconButtonSplashRadius,
                onPressed: () =>
                    RepositoryProvider.of<AuthenticationRepository>(context)
                        .logOut(),
              ),
            ],
          );
        } else {
          appBar = null;
        }

        Widget body;
        if (state == 0) {
          body = _getSearchPage(context);
        } else if (state == 1) {
          body = _getResponseViews(context);
        } else if (state == 2) {
          body = _getFavoritesPage(context);
        } else if (state == 3) {
          body = _getUserProfilePage(context);
        }

        Widget bottomNavigationBar = BottomNavigationBar(
          currentIndex: state,
          onTap: (value) => context.read<NavigationCubit>().selectPage(value),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Поиск',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded),
              label: 'Отклики',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'Избранное',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Профиль',
            ),
          ],
        );

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: appBar,
            body: body,
            bottomNavigationBar: bottomNavigationBar,
          ),
        );
      },
    );
  }
}
