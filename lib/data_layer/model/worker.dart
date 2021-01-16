// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Worker workerFromJson(String str) => Worker.fromJson(json.decode(str));

String workerToJson(Worker data) => json.encode(data.toJson());

class Worker {
  Worker({
    this.userId,
    this.mailing,
    this.language,
    this.birthday,
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
  final bool mailing;
  final List<Language> language;
  final String birthday;
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
    bool mailing,
    List<Language> language,
    String birthday,
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
        mailing: mailing ?? this.mailing,
        language: language ?? this.language,
        birthday: birthday ?? this.birthday,
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
        mailing: json["mailing"],
        // language: List<Language>.from(
        //     json["language"].map((x) => Language.fromJson(x))),
        language: List<Language>.from(
            json["language"]?.map((x) => Language.fromJson(x)) ?? []),
        birthday: json["birthday"],
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
        "mailing": mailing,
        "language": List<dynamic>.from(language.map((x) => x.toJson())),
        "birthday": birthday,
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
}

class Education {
  Education({
    this.years,
    this.profession,
    this.university,
  });

  final int years;
  final String profession;
  final String university;

  Education copyWith({
    int years,
    String profession,
    String university,
  }) =>
      Education(
        years: years ?? this.years,
        profession: profession ?? this.profession,
        university: university ?? this.university,
      );

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        years: json["years"],
        profession: json["profession"],
        university: json["university"],
      );

  Map<String, dynamic> toJson() => {
        "years": years,
        "profession": profession,
        "university": university,
      };
}

class Exp {
  Exp({
    this.years,
    this.position,
    this.company,
    this.type,
  });

  final int years;
  final String position;
  final String company;
  final String type;

  Exp copyWith({
    int years,
    String position,
    String company,
    String type,
  }) =>
      Exp(
        years: years ?? this.years,
        position: position ?? this.position,
        company: company ?? this.company,
        type: type ?? this.type,
      );

  factory Exp.fromJson(Map<String, dynamic> json) => Exp(
        years: json["years"],
        position: json["position"],
        company: json["company"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "years": years,
        "position": position,
        "company": company,
        "type": type,
      };
}

class Language {
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

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        language: json["language"],
        grade: json["grade"],
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "grade": grade,
      };
}
