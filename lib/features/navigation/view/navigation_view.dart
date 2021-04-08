import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/models.dart';
import 'package:helperr/data_layer/model/user_type.dart';
import 'package:helperr/data_layer/repository/authentication_repository.dart';
import 'package:helperr/features/navigation/navigation.dart';
import 'package:helperr/features/response_details/view/employer_initial_response_detail_view.dart';
import 'package:helperr/features/response_details/view/worker_initial_response_detail_view.dart';
import 'package:helperr/features/response_page_view_tab/repository/detailed_response_repository.dart';
import 'package:helperr/features/response_page_view_tab/view/paded_response_page.dart';
import 'package:helperr/features/response_page_view_tab/widget/list_items/employer_response_list_item.dart';
import 'package:helperr/features/response_page_view_tab/widget/list_items/worker_response_list_item.dart';
import 'package:helperr/features/search/vacancies_search/view/vacancies_search_result_page.dart';
import 'package:helperr/features/search/vacancies_search/view/vacancy_search_delegate.dart';
import 'package:helperr/features/search/resumes_search/view/resumes_search_result_page.dart';
import 'package:helperr/features/search/resumes_search/view/resume_search_delegate.dart';
import 'package:helperr/features/profile/employer/view/employer_profile_page.dart';
import 'package:helperr/features/profile/worker/view/worker_profile_page.dart';
import 'package:helperr/features/settings/view/settings_page.dart';

class NavigationView extends StatelessWidget {
  // TODO: yet another temporary solution
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

  // TODO: yet another temporary solution
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

  // TODO: yet another temporary solution
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

  // TODO: yet another temporary solution
  Widget _getResponseViews(BuildContext context) {
    final user = RepositoryProvider.of<AuthenticationRepository>(context).user;

    Widget inboxTab;
    Widget outboxTab;

    if (user.userType == UserType.employee) {
      inboxTab = PagedResponsePage(
        userId: user.id,
        responseRepository: WorkerInboxRepository(),
        builder: (context, response) => WorkerResponseListItem(
          response: response,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployerInitialResponseDetailView(
                response: response,
                isRespondable: true,
                onChange: () {},
              ),
            ),
          ),
        ),
      );
      outboxTab = PagedResponsePage(
        userId: user.id,
        responseRepository: WorkerOutboxRepository(),
        builder: (context, response) => WorkerResponseListItem(
          response: response,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkerInitialResponseDetailView(
                response: response,
                isRespondable: false,
                onChange: () {},
              ),
            ),
          ),
        ),
      );
    } else if (user.userType == UserType.employer) {
      inboxTab = PagedResponsePage(
        userId: user.id,
        responseRepository: EmployerInboxRepository(),
        builder: (context, response) => EmployerResponseListItem(
          response: response,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkerInitialResponseDetailView(
                response: response,
                isRespondable: true,
                onChange: () {},
              ),
            ),
          ),
        ),
      );
      outboxTab = PagedResponsePage(
        userId: user.id,
        responseRepository: EmployerOutboxRepository(),
        builder: (context, response) => EmployerResponseListItem(
          response: response,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployerInitialResponseDetailView(
                response: response,
                isRespondable: false,
                onChange: () {},
              ),
            ),
          ),
        ),
      );
    }

    return TabBarView(children: [inboxTab, outboxTab]);
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
                splashRadius: 24.0,
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
                icon: const Icon(Icons.settings_rounded),
                splashRadius: 24.0,
                onPressed: () => Navigator.push(context, SettingsPage.route()),
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
          body = Container(
            child: Center(
              child: Text('В процессе разработки'),
            ),
          );
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
