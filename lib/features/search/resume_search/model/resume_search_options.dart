import '../../../../data_layer/model/experience_type.dart';
import '../../../../data_layer/model/work_type.dart';
import '../../../../data_layer/model/publication_age.dart';

class ResumeSearchOptions {
  const ResumeSearchOptions({
    this.searchPhrase,
    this.industry,
    this.maxSalary,
    this.expTypes,
    this.workTypes,
    this.tags,
    this.pubAge,
  });

  final String searchPhrase;
  final String industry;
  final int maxSalary;
  final Set<ExperienceType> expTypes;
  final Set<WorkType> workTypes;
  final List<String> tags;
  final PublicationAge pubAge;

  ResumeSearchOptions copyWith({
    String searchQuery,
    String industry,
    int minSalary,
    Set<ExperienceType> expTypes,
    Set<WorkType> workTypes,
    List<String> tags,
    PublicationAge pubAge,
  }) =>
      ResumeSearchOptions(
        searchPhrase: searchQuery ?? this.searchPhrase,
        industry: industry ?? this.industry,
        maxSalary: minSalary ?? this.maxSalary,
        expTypes: expTypes ?? this.expTypes,
        workTypes: workTypes ?? this.workTypes,
        tags: tags ?? this.tags,
        pubAge: pubAge ?? this.pubAge,
      );
}
