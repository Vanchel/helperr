// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address extends Equatable {
  const Address({
    this.name,
    this.lat,
    this.lng,
  });

  final String name;
  final double lat;
  final double lng;

  Address copyWith({
    String name,
    double lat,
    double lng,
  }) =>
      Address(
        name: name ?? this.name,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lng": lng,
      };

  static const empty = Address(lat: 0.0, lng: 0.0, name: '');

  @override
  List<Object> get props => [
        this.name,
        this.lat,
        this.lng,
      ];
}
