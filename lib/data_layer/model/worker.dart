import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

enum Gender { male, female, unknown }

Gender genderFromJson(String str) {
  Gender gender;

  if (str == "male") {
    gender = Gender.male;
  } else if (str == "female") {
    gender = Gender.female;
  } else {
    gender = Gender.unknown;
  }

  return gender;
}

String genderToJson(Gender gender) {
  String str;

  if (gender == Gender.male) {
    str = "male";
  } else if (gender == Gender.female) {
    str = "female";
  } else {
    str = "";
  }

  return str;
}

DateTime dateFromJson(String str) {
  try {
    return DateTime.parse(str);
  } catch (_) {
    return null;
  }
}

String dateToJson(DateTime date) {
  if (date != null) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
  return '';
}

Worker workerFromJson(String str) => Worker.fromJson(json.decode(str));

String workerToJson(Worker data) => json.encode(data.toJson());

class Worker extends Equatable {
  Worker({
    this.userId,
    this.name,
    this.mailing,
    this.language,
    this.birthday,
    this.gender,
    this.city,
    this.phone,
    this.about,
    this.socialLinks,
    this.education,
    this.exp,
    this.cz,
    this.profileLink,
    this.photoUrl,
    this.profileBackground,
  });

  final int userId;
  final String name;
  final bool mailing;
  final List<Language> language;
  final DateTime birthday;
  final Gender gender;
  final String city;
  final List<String> phone;
  final String about;
  final List<String> socialLinks;
  final List<Education> education;
  final List<Exp> exp;
  final String cz;
  final String profileLink;
  final String photoUrl;
  final String profileBackground;

  Worker copyWith({
    int userId,
    String name,
    bool mailing,
    List<Language> language,
    DateTime birthday,
    Gender gender,
    String city,
    List<String> phone,
    String about,
    List<String> socialLinks,
    List<Education> education,
    List<Exp> exp,
    String cz,
    String profileLink,
    String photoUrl,
    String profileBackground,
  }) =>
      Worker(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        mailing: mailing ?? this.mailing,
        language: language ?? this.language,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        city: city ?? this.city,
        phone: phone ?? this.phone,
        about: about ?? this.about,
        socialLinks: socialLinks ?? this.socialLinks,
        education: education ?? this.education,
        exp: exp ?? this.exp,
        cz: cz ?? this.cz,
        profileLink: profileLink ?? this.profileLink,
        photoUrl: photoUrl ?? this.photoUrl,
        profileBackground: profileBackground ?? this.profileBackground,
      );

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        userId: json["user_id"],
        name: json["name"],
        mailing: json["mailing"],
        // language: List<Language>.from(
        //     json["language"].map((x) => Language.fromJson(x))),
        // back-end sending null for this particular field :/
        language: List<Language>.from(
            json["language"]?.map((x) => Language.fromJson(x)) ?? []),
        birthday: dateFromJson(json["birthday"]),
        gender: genderFromJson(json["gender"]),
        city: json["city"],
        phone: List<String>.from(json["phone"].map((x) => x)),
        about: json["about"],
        socialLinks: List<String>.from(json["social_links"].map((x) => x)),
        education: List<Education>.from(
            json["education"].map((x) => Education.fromJson(x))),
        exp: List<Exp>.from(json["exp"].map((x) => Exp.fromJson(x))),
        cz: json["cz"],
        profileLink: json["profile_link"],
        photoUrl: json["photo_url"],
        profileBackground: json["profile_background"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "mailing": mailing,
        "language": List<dynamic>.from(language.map((x) => x.toJson())),
        "birthday": dateToJson(birthday),
        "gender": genderToJson(gender),
        "city": city,
        "phone": List<dynamic>.from(phone.map((x) => x)),
        "about": about,
        "social_links": List<dynamic>.from(socialLinks.map((x) => x)),
        "education": List<dynamic>.from(education.map((x) => x.toJson())),
        "exp": List<dynamic>.from(exp.map((x) => x.toJson())),
        "cz": cz,
        "profile_link": profileLink,
        "photo_url": photoUrl,
        "profile_background": profileBackground,
      };

  @override
  List<Object> get props => [
        this.userId,
        this.name,
        this.mailing,
        this.language,
        this.birthday,
        this.gender,
        this.city,
        this.phone,
        this.about,
        this.socialLinks,
        this.education,
        this.exp,
        this.cz,
        this.profileLink,
        this.photoUrl,
        this.profileBackground,
      ];
}

enum EducationType {
  course,
  primary,
  basic,
  secondary,
  postSecondary,
  bachelor,
  specialist,
  magister,
  phdAsp,
  phdDoc
}

EducationType educationTypeFromJson(String str) {
  EducationType type;

  if (str == "primary") {
    type = EducationType.primary;
  } else if (str == "basic") {
    type = EducationType.basic;
  } else if (str == "secondary") {
    type = EducationType.secondary;
  } else if (str == "post-secondary") {
    type = EducationType.postSecondary;
  } else if (str == "bachelor") {
    type = EducationType.bachelor;
  } else if (str == "specialist") {
    type = EducationType.specialist;
  } else if (str == "master") {
    type = EducationType.magister;
  } else if (str == "PhD-asp") {
    type = EducationType.phdAsp;
  } else if (str == "PhD-doc") {
    type = EducationType.phdDoc;
  } else {
    type = EducationType.course;
  }

  return type;
}

String educationTypeToJson(EducationType type) {
  String str;

  if (type == EducationType.primary) {
    str = "primary";
  } else if (type == EducationType.basic) {
    str = "basic";
  } else if (type == EducationType.secondary) {
    str = "secondary";
  } else if (type == EducationType.postSecondary) {
    str = "post-secondary";
  } else if (type == EducationType.bachelor) {
    str = "bachelor";
  } else if (type == EducationType.magister) {
    str = "master";
  } else if (type == EducationType.phdAsp) {
    str = "PhD-asp";
  } else if (type == EducationType.phdDoc) {
    str = "PhD-doc";
  } else {
    str = "course";
  }

  return str;
}

class Education extends Equatable {
  Education({
    this.profession,
    this.university,
    this.type,
    this.startYear,
    this.endYear,
  });

  final String profession;
  final String university;
  final EducationType type;
  final DateTime startYear;
  final DateTime endYear;

  Education copyWith({
    String profession,
    String university,
    EducationType type,
    DateTime startYear,
    DateTime endYear,
  }) =>
      Education(
        profession: profession ?? this.profession,
        university: university ?? this.university,
        type: type ?? this.type,
        startYear: startYear ?? this.startYear,
        endYear: endYear ?? this.endYear,
      );

  factory Education.fromRawJson(String str) =>
      Education.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        profession: json["profession"],
        university: json["university"],
        type: educationTypeFromJson(json["type"]),
        startYear: dateFromJson(json["start_year"]),
        endYear: dateFromJson(json["end_year"]),
      );

  Map<String, dynamic> toJson() => {
        "profession": profession,
        "university": university,
        "type": educationTypeToJson(type),
        "start_year": dateToJson(startYear),
        "end_year": dateToJson(endYear),
      };

  @override
  List<Object> get props => [
        this.profession,
        this.university,
        this.type,
        this.startYear,
        this.endYear,
      ];
}

enum ExperienceType {
  internship,
  junior,
  middle,
  senior,
  director,
  seniorDirector
}

ExperienceType experienceTypeFromJson(String str) {
  ExperienceType type;

  if (str == "junior") {
    type = ExperienceType.junior;
  } else if (str == "middle") {
    type = ExperienceType.middle;
  } else if (str == "senior") {
    type = ExperienceType.senior;
  } else if (str == "director") {
    type = ExperienceType.director;
  } else if (str == "senior-director") {
    type = ExperienceType.seniorDirector;
  } else {
    type = ExperienceType.internship;
  }

  return type;
}

String experienceTypeToJson(ExperienceType type) {
  String str;

  if (type == ExperienceType.junior) {
    str = "junior";
  } else if (type == ExperienceType.middle) {
    str = "middle";
  } else if (type == ExperienceType.senior) {
    str = "senior";
  } else if (type == ExperienceType.director) {
    str = "director";
  } else if (type == ExperienceType.seniorDirector) {
    str = "senior-director";
  } else {
    str = "internship";
  }

  return str;
}

class Exp extends Equatable {
  Exp({
    this.position,
    this.company,
    this.type,
    this.startYear,
    this.endYear,
  });

  final String position;
  final String company;
  final ExperienceType type;
  final DateTime startYear;
  final DateTime endYear;

  Exp copyWith({
    String position,
    String company,
    ExperienceType type,
    DateTime startYear,
    DateTime endYear,
  }) =>
      Exp(
        position: position ?? this.position,
        company: company ?? this.company,
        type: type ?? this.type,
        startYear: startYear ?? this.startYear,
        endYear: endYear ?? this.endYear,
      );

  factory Exp.fromRawJson(String str) => Exp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Exp.fromJson(Map<String, dynamic> json) => Exp(
        position: json["position"],
        company: json["company"],
        type: experienceTypeFromJson(json["type"]),
        startYear: dateFromJson(json["start_year"]),
        endYear: dateFromJson(json["end_year"]),
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "company": company,
        "type": experienceTypeToJson(type),
        "start_year": dateToJson(startYear),
        "end_year": dateToJson(endYear),
      };

  @override
  List<Object> get props => [
        this.position,
        this.company,
        this.type,
        this.startYear,
        this.endYear,
      ];
}

enum LanguageProficiency { a1, a2, b1, b2, c1, c2 }

LanguageProficiency languageProficiencyFromJson(String str) {
  LanguageProficiency proficiency;

  if (str == "A2") {
    proficiency = LanguageProficiency.a2;
  } else if (str == "B1") {
    proficiency = LanguageProficiency.b1;
  } else if (str == "B2") {
    proficiency = LanguageProficiency.b2;
  } else if (str == "C1") {
    proficiency = LanguageProficiency.c1;
  } else if (str == "C2") {
    proficiency = LanguageProficiency.c2;
  } else {
    proficiency = LanguageProficiency.a1;
  }

  return proficiency;
}

String languageProficiencyToJson(LanguageProficiency proficiency) {
  String str;

  if (proficiency == LanguageProficiency.a2) {
    str = "A2";
  } else if (proficiency == LanguageProficiency.b1) {
    str = "B1";
  } else if (proficiency == LanguageProficiency.b2) {
    str = "B2";
  } else if (proficiency == LanguageProficiency.c1) {
    str = "C1";
  } else if (proficiency == LanguageProficiency.c2) {
    str = "C2";
  } else {
    str = "A1";
  }

  return str;
}

class Language extends Equatable {
  Language({
    this.language,
    this.grade,
  });

  final String language;
  final LanguageProficiency grade;

  Language copyWith({
    String language,
    LanguageProficiency grade,
  }) =>
      Language(
        language: language ?? this.language,
        grade: grade ?? this.grade,
      );

  factory Language.fromRawJson(String str) =>
      Language.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        language: json["language"],
        grade: languageProficiencyFromJson(json["grade"]),
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "grade": languageProficiencyToJson(grade),
      };

  @override
  List<Object> get props => [
        this.language,
        this.grade,
      ];
}
