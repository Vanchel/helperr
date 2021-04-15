// To parse this JSON data, do
//
//     final tokenPublicPart = tokenPublicPartFromJson(jsonString);

import 'dart:convert';

TokenPublicPart tokenPublicPartFromJson(String str) =>
    TokenPublicPart.fromJson(json.decode(str));

String tokenPublicPartToJson(TokenPublicPart data) =>
    json.encode(data.toJson());

class TokenPublicPart {
  TokenPublicPart({
    this.tokenType,
    this.exp,
    this.jti,
    this.userId,
  });

  final String tokenType;
  final int exp;
  final String jti;
  final int userId;

  TokenPublicPart copyWith({
    String tokenType,
    int exp,
    String jti,
    int userId,
  }) =>
      TokenPublicPart(
        tokenType: tokenType ?? this.tokenType,
        exp: exp ?? this.exp,
        jti: jti ?? this.jti,
        userId: userId ?? this.userId,
      );

  factory TokenPublicPart.fromJson(Map<String, dynamic> json) =>
      TokenPublicPart(
        tokenType: json["token_type"],
        exp: json["exp"],
        jti: json["jti"],
        userId: json["user_id"],
      );

  factory TokenPublicPart.parse(String jwt) {
    var publicPart = jwt.split('.')[1];

    if (publicPart.length % 4 == 2) {
      publicPart = publicPart + '==';
    } else if (publicPart.length % 4 == 3) {
      publicPart = publicPart + '=';
    }

    final map = json.decode(utf8.decode(base64.decode(publicPart)));

    return TokenPublicPart.fromJson(map);
  }

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "exp": exp,
        "jti": jti,
        "user_id": userId,
      };
}
