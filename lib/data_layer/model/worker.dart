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
  final String type;
  final String startYear;
  final String endYear;

  Exp copyWith({
    String position,
    String company,
    String type,
    String startYear,
    String endYear,
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
        type: json["type"],
        startYear: json["start_year"],
        endYear: json["end_year"],
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "company": company,
        "type": type,
        "start_year": startYear,
        "end_year": endYear,
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

class Language extends Equatable {
  Language({
    this.language,
    this.grade,
  });

  final String language;
  final String grade;

  Language copyWith({
    String language,
    String grade,
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
        grade: json["grade"],
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "grade": grade,
      };

  @override
  List<Object> get props => [
        this.language,
        this.grade,
      ];
}
