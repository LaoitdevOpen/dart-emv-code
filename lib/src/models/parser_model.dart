import 'dart:convert';

import '../errors/emv_error_model.dart';

ParserModel parserModelFromJson(String str) =>
    ParserModel.fromJson(json.decode(str));

String parserModelToJson(ParserModel data) => json.encode(data.toJson());

class ParserModel {
  ParserModel({
    this.current,
    this.max,
    this.source,
    this.error,
  });

  int? current;
  int? max;
  List<int>? source;
  EmvError? error;

  ParserModel copyWith({
    int? current,
    int? max,
    List<int>? source,
    EmvError? error,
  }) =>
      ParserModel(
        current: current ?? this.current,
        max: max ?? this.max,
        source: source ?? this.source,
        error: error ?? this.error,
      );

  factory ParserModel.fromJson(Map<String, dynamic> json) => ParserModel(
        current: json["current"],
        max: json["max"],
        source: List<int>.from(json["source"].map((x) => x)),
        error: EmvError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "current": current,
        "max": max,
        "source":
            source != null ? List<dynamic>.from(source!.map((x) => x)) : [],
        "error": error?.toJson(),
      };
}
