import 'dart:convert';

import 'package:emvqrcode/src/errors/emv_error_model.dart';
import 'package:emvqrcode/src/models/emvqr_model.dart';

EMVDeCode emvqrDecodeFromJson(String str) =>
    EMVDeCode.fromJson(json.decode(str));
String emvqrDecodeToJson(EMVDeCode data) => json.encode(data.toJson());

class EMVDeCode {
  EMVDeCode({this.emvqr, this.error});
  EmvqrModel? emvqr;
  EmvError? error;

  EMVDeCode copyWith({
    EmvqrModel? emvqr,
    EmvError? error,
  }) =>
      EMVDeCode(
        emvqr: emvqr ?? this.emvqr,
        error: error ?? this.error,
      );

  factory EMVDeCode.fromJson(Map<String, dynamic> json) => EMVDeCode(
        emvqr: EmvqrModel.fromJson(json["emvqr"]),
        error: EmvError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "emvqr": emvqr?.toJson(),
        "error": error?.toJson(),
      };
}
