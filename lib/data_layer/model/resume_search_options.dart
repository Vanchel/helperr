import 'experience_type.dart';
import 'work_type.dart';
import 'publication_age.dart';

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
    int maxSalary,
    Set<ExperienceType> expTypes,
    Set<WorkType> workTypes,
    List<String> tags,
    PublicationAge pubAge,
  }) =>
      ResumeSearchOptions(
        searchPhrase: searchQuery ?? this.searchPhrase,
        industry: industry ?? this.industry,
        maxSalary: maxSalary ?? this.maxSalary,
        expTypes: expTypes ?? this.expTypes,
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
    if ((maxSalary ?? -1) != -1) {
      params['max-salary'] = maxSalary;
    }
    if ((pubAge ?? PublicationAge.allTime) != PublicationAge.allTime) {
      params['pub-date'] = publicationAgeToJson(pubAge);
    }
    if (expTypes?.isNotEmpty ?? false) {
      params['grades'] = expTypes.map((e) => experienceTypeToJson(e)).toList();
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
