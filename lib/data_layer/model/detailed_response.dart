// To parse this JSON data, do
//
//     final detailedResponse = detailedResponseFromJson(jsonString);

import 'dart:convert';

import 'response_state.dart';

DetailedResponse detailedResponseFromJson(String str) =>
    DetailedResponse.fromJson(json.decode(str));

String detailedResponseToJson(DetailedResponse data) =>
    json.encode(data.toJson());

class DetailedResponse {
  DetailedResponse({
    this.id,
    this.vacancy,
    this.worker,
    this.employer,
    this.cv,
    this.message,
    this.state,
    this.dateResponse,
    this.vacancyName,
    this.employerAvatar,
    this.workerAvatar,
    this.workerName,
    this.employerName,
    this.cvName,
  });

  final int id;
  final int vacancy;
  final int worker;
  final int employer;
  final int cv;
  final String message;
  final ResponseState state;
  final DateTime dateResponse;
  final String vacancyName;
  final String employerAvatar;
  final String workerAvatar;
  final String workerName;
  final String employerName;
  final String cvName;

  DetailedResponse copyWith({
    int id,
    int vacancy,
    int worker,
    int employer,
    int cv,
    String message,
    ResponseState state,
    DateTime dateResponse,
    String vacancyName,
    String employerAvatar,
    String workerAvatar,
    String workerName,
    String employerName,
    String cvName,
  }) =>
      DetailedResponse(
        id: id ?? this.id,
        vacancy: vacancy ?? this.vacancy,
        worker: worker ?? this.worker,
        employer: employer ?? this.employer,
        cv: cv ?? this.cv,
        message: message ?? this.message,
        state: state ?? this.state,
        dateResponse: dateResponse ?? this.dateResponse,
        vacancyName: vacancyName ?? this.vacancyName,
        employerAvatar: employerAvatar ?? this.employerAvatar,
        workerAvatar: workerAvatar ?? this.workerAvatar,
        workerName: workerName ?? this.workerName,
        employerName: employerName ?? this.employerName,
        cvName: cvName ?? this.cvName,
      );

  factory DetailedResponse.fromJson(Map<String, dynamic> json) =>
      DetailedResponse(
        id: json["id"],
        vacancy: json["vacancy"],
        worker: json["worker"],
        employer: json["employer"],
        cv: json["cv"],
        message: json["message"],
        state: responseStateFromJson(json["state"]),
        dateResponse: DateTime.parse(json["date_response"]),
        vacancyName: json["vacancy_name"],
        employerAvatar: json["employer_avatar"],
        workerAvatar: json["worker_avatar"],
        workerName: json["worker_name"],
        employerName: json["employer_name"],
        cvName: json["cv_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vacancy": vacancy,
        "worker": worker,
        "employer": employer,
        "cv": cv,
        "message": message,
        "state": responseStateToJson(state),
        "date_response": dateResponse.toIso8601String(),
        "vacancy_name": vacancyName,
        "employer_avatar": employerAvatar,
        "worker_avatar": workerAvatar,
        "worker_name": workerName,
        "employer_name": employerName,
        "cv_name": cvName,
      };
}
