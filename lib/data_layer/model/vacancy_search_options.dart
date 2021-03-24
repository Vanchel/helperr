import 'experience_type.dart';
import 'experience_duration.dart';
import 'work_type.dart';
import 'publication_age.dart';

class VacancySearchOptions {
  const VacancySearchOptions({
    this.searchPhrase,
    this.industry,
    this.minSalary,
    this.expTypes,
    this.expDurations,
    this.workTypes,
    this.tags,
    this.pubAge,
  });

  final String searchPhrase;
  final String industry;
  final int minSalary;
  final Set<ExperienceType> expTypes;
  final Set<ExperienceDuration> expDurations;
  final Set<WorkType> workTypes;
  final List<String> tags;
  final PublicationAge pubAge;

  VacancySearchOptions copyWith({
    String searchQuery,
    String industry,
    int minSalary,
    Set<ExperienceType> expTypes,
    Set<ExperienceDuration> expDurations,
    Set<WorkType> workTypes,
    List<String> tags,
    PublicationAge pubAge,
  }) =>
      VacancySearchOptions(
        searchPhrase: searchQuery ?? this.searchPhrase,
        industry: industry ?? this.industry,
        minSalary: minSalary ?? this.minSalary,
        expTypes: expTypes ?? this.expTypes,
        expDurations: expDurations ?? this.expDurations,
        workTypes: workTypes ?? this.workTypes,
        tags: tags ?? this.tags,
        pubAge: pubAge ?? this.pubAge,
      );

  @override
  String toString() {
    final query = ['phrase=$searchPhrase'];

    query.add('industry=$industry');
    query.add('min-salary=$minSalary');
    query.add('pub-date=${publicationAgeToJson(pubAge)}');
    for (final expType in expTypes) {
      query.add('grade=${experienceTypeToJson(expType)}');
    }
    for (final expDuration in expDurations) {
      query.add('experience=${experienceDurationToJson(expDuration)}');
    }
    for (final workType in workTypes) {
      query.add('work-type=${workTypeToJson(workType)}');
    }
    for (final tag in tags) {
      query.add('tag=$tag');
    }

    return query.join('&');
  }
}
