// To parse this JSON data, do
//
//     final employer = employerFromJson(jsonString);

import 'dart:convert';

Employer employerFromJson(String str) => Employer.fromJson(json.decode(str));

String employerToJson(Employer data) => json.encode(data.toJson());

class Employer {
  Employer({
    this.userId,
    this.name,
    this.mailing,
    this.address,
    this.phone,
    this.about,
    this.links,
    this.profileLink,
    this.photoUrl,
    this.profileBackground,
  });

  final int userId;
  final String name;
  final bool mailing;
  final String address;
  final List<String> phone;
  final String about;
  final List<String> links;
  final String profileLink;
  final String photoUrl;
  final String profileBackground;

  Employer copyWith({
    int userId,
    String name,
    bool mailing,
    String address,
    List<String> phone,
    String about,
    List<String> links,
    String profileLink,
    String photoUrl,
    String profileBackground,
  }) =>
      Employer(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        mailing: mailing ?? this.mailing,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        about: about ?? this.about,
        links: links ?? this.links,
        profileLink: profileLink ?? this.profileLink,
        photoUrl: photoUrl ?? this.photoUrl,
        profileBackground: profileBackground ?? this.profileBackground,
      );

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        userId: json["user_id"],
        name: json["name"],
        mailing: json["mailing"],
        address: json["address"],
        phone: List<String>.from(json["phone"].map((x) => x)),
        about: json["about"],
        links: List<String>.from(json["links"].map((x) => x)),
        profileLink: json["profile_link"],
        photoUrl: json["photo_url"],
        profileBackground: json["profile_background"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "mailing": mailing,
        "address": address,
        "phone": List<dynamic>.from(phone.map((x) => x)),
        "about": about,
        "links": List<dynamic>.from(links.map((x) => x)),
        "profile_link": profileLink,
        "photo_url": photoUrl,
        "profile_background": profileBackground,
      };
}
