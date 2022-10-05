import 'dart:convert';

import '../../errors/emv_error_model.dart';

EmvEncode emvEncodeFromJson(String str) => EmvEncode.fromJson(json.decode(str));
String emvEncodeToJson(EmvEncode data) => json.encode(data.toJson());

class EmvEncode {
  EmvEncode({this.value, this.error});
  String? value;
  EmvError? error;

  EmvEncode copyWith({
    String? value,
    EmvError? error,
  }) =>
      EmvEncode(
        value: value ?? this.value,
        error: error ?? this.error,
      );

  factory EmvEncode.fromJson(Map<String, dynamic> json) => EmvEncode(
        value: json["value"],
        error: EmvError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "emvqr": value,
        "error": error?.toJson(),
      };
}
