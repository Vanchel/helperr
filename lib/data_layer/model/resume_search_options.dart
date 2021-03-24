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

  @override
  String toString() {
    final query = ['phrase=$searchPhrase'];

    query.add('industry=$industry');
    query.add('max-salary=$maxSalary');
    query.add('pub-date=${publicationAgeToJson(pubAge)}');
    for (final expType in expTypes) {
      query.add('grade=${experienceTypeToJson(expType)}');
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
