import '../../../../data_layer/model/experience_type.dart';
import '../../../../data_layer/model/experience_duration.dart';
import '../../../../data_layer/model/work_type.dart';
import '../../../../data_layer/model/publication_age.dart';

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
}
