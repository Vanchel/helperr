// To parse this JSON data, do
//
//     final tokenRefreshResult = tokenRefreshResultFromJson(jsonString);

import 'dart:convert';

TokenRefreshResult tokenRefreshResultFromJson(String str) =>
    TokenRefreshResult.fromJson(json.decode(str));

String tokenRefreshResultToJson(TokenRefreshResult data) =>
    json.encode(data.toJson());

class TokenRefreshResult {
  TokenRefreshResult({
    this.access,
    this.refresh,
    this.accessTokenExpiration,
  });

  final String access;
  final String refresh;
  final DateTime accessTokenExpiration;

  TokenRefreshResult copyWith({
    String access,
    String refresh,
    DateTime accessTokenExpiration,
  }) =>
      TokenRefreshResult(
        access: access ?? this.access,
        refresh: refresh ?? this.refresh,
        accessTokenExpiration:
            accessTokenExpiration ?? this.accessTokenExpiration,
      );

  factory TokenRefreshResult.fromJson(Map<String, dynamic> json) =>
      TokenRefreshResult(
        access: json["access"],
        refresh: json["refresh"],
        accessTokenExpiration: DateTime.parse(json["access_token_expiration"]),
      );

  Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
        "access_token_expiration": accessTokenExpiration.toIso8601String(),
      };
}
