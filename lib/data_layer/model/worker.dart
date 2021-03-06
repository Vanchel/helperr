import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'education.dart';
import 'experience.dart';
import 'gender.dart';
import 'address.dart';
import 'language.dart';
import 'schedule.dart';

Worker workerFromJson(String str) => Worker.fromJson(json.decode(str));

String workerToJson(Worker data) => json.encode(data.toJson());

class Worker extends Equatable {
  Worker({
    this.id,
    this.userId,
    this.name,
    this.mailing,
    this.language,
    this.birthday,
    this.gender,
    this.address,
    this.phone,
    this.about,
    this.schedules,
    this.socialLinks,
    this.education,
    this.exp,
    this.cz,
    this.profileLink,
    this.photoUrl,
    this.profileBackground,
  });

  final int id;
  final int userId;
  final String name;
  final bool mailing;
  final List<Language> language;
  final DateTime birthday;
  final Gender gender;
  final Address address;
  final List<String> phone;
  final String about;
  final List<Schedule> schedules;
  final List<String> socialLinks;
  final List<Education> education;
  final List<Exp> exp;
  final String cz;
  final String profileLink;
  final String photoUrl;
  final String profileBackground;

  Worker copyWith({
    int id,
    int userId,
    String name,
    bool mailing,
    List<Language> language,
    DateTime birthday,
    Gender gender,
    Address address,
    List<String> phone,
    String about,
    List<Schedule> schedules,
    List<String> socialLinks,
    List<Education> education,
    List<Exp> exp,
    String cz,
    String profileLink,
    String photoUrl,
    String profileBackground,
  }) =>
      Worker(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        mailing: mailing ?? this.mailing,
        language: language ?? this.language,
        birthday: birthday,
        //birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        about: about ?? this.about,
        schedules: schedules ?? this.schedules,
        socialLinks: socialLinks ?? this.socialLinks,
        education: education ?? this.education,
        exp: exp ?? this.exp,
        cz: cz ?? this.cz,
        profileLink: profileLink ?? this.profileLink,
        photoUrl: photoUrl ?? this.photoUrl,
        profileBackground: profileBackground ?? this.profileBackground,
      );

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["id"],
        userId: json["user"],
        name: json["name"] ?? '',
        mailing: json["mailing"] ?? false,
        language: List<Language>.from(
            json["language"]?.map((x) => Language.fromJson(x)) ?? []),
        birthday: DateTime.tryParse(json["birthday"] ?? ''),
        gender: genderFromJson(json["gender"]),
        address: (json["address"]?.isNotEmpty ?? false)
            ? Address.fromJson(json["address"])
            : Address.empty,
        phone: List<String>.from(json["phone"]?.map((x) => x) ?? []),
        about: json["about"] ?? '',
        schedules: List<Schedule>.from(
            json["schedule"]?.map((x) => Schedule.fromJson(x)) ?? []),
        socialLinks:
            List<String>.from(json["social_links"]?.map((x) => x) ?? []),
        education: List<Education>.from(
            json["education"]?.map((x) => Education.fromJson(x)) ?? []),
        exp: List<Exp>.from(
            json["experience"]?.map((x) => Exp.fromJson(x)) ?? []),
        cz: json["citizenship"] ?? '',
        profileLink: json["profile_link"] ?? '',
        photoUrl: json["photo_url"] ?? '',
        profileBackground: json["profile_background"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": userId,
        "name": name,
        "mailing": mailing,
        "language": List<dynamic>.from(language.map((x) => x.toJson())),
        "birthday": birthday?.toIso8601String(),
        "gender": genderToJson(gender),
        "address": address.toJson(),
        "phone": List<dynamic>.from(phone.map((x) => x)),
        "about": about,
        "schedule": List<dynamic>.from(schedules.map((x) => x.toJson())),
        "social_links": List<dynamic>.from(socialLinks.map((x) => x)),
        "education": List<dynamic>.from(education.map((x) => x.toJson())),
        "experience": List<dynamic>.from(exp.map((x) => x.toJson())),
        "citizenship": cz,
        "profile_link": profileLink,
        "photo_url": photoUrl,
        "profile_background": profileBackground,
      };

  @override
  List<Object> get props => [
        this.id,
        this.userId,
        this.name,
        this.mailing,
        this.language,
        this.birthday,
        this.gender,
        this.address,
        this.phone,
        this.about,
        this.schedules,
        this.socialLinks,
        this.education,
        this.exp,
        this.cz,
        this.profileLink,
        this.photoUrl,
        this.profileBackground,
      ];
}
