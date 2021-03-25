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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> params = {};

    if (searchPhrase?.isNotEmpty ?? false) {
      params['phrase'] = searchPhrase;
    }
    if (industry?.isNotEmpty ?? false) {
      params['industry'] = industry;
    }
    if ((minSalary ?? -1) != -1) {
      params['min-salary'] = minSalary;
    }
    if ((pubAge ?? PublicationAge.allTime) != PublicationAge.allTime) {
      params['pub-date'] = publicationAgeToJson(pubAge);
    }
    if (expTypes?.isNotEmpty ?? false) {
      params['grade'] = expTypes.map((e) => experienceTypeToJson(e)).toList();
    }
    if (expDurations?.isNotEmpty ?? false) {
      params['experience'] =
          expDurations.map((e) => experienceDurationToJson(e)).toList();
    }
    if (workTypes?.isNotEmpty ?? false) {
      params['work-type'] = workTypes.map((e) => workTypeToJson(e)).toList();
    }
    if (tags?.isNotEmpty ?? false) {
      params['tag'] = tags.toList();
    }

    return params;
  }
}
