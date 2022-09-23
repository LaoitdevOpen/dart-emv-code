import 'dart:convert';

TLVModel tlvModelFromJson(String str) => TLVModel.fromJson(json.decode(str));

String tlvModelToJson(TLVModel data) => json.encode(data.toJson());

class TLVModel {
  TLVModel({
    this.tag,
    this.length,
    this.value,
  });

  String? tag;
  String? length;
  String? value;

  TLVModel copyWith({
    String? tag,
    String? length,
    String? value,
  }) =>
      TLVModel(
        tag: tag ?? this.tag,
        length: length ?? this.length,
        value: value ?? this.value,
      );

  factory TLVModel.fromJson(Map<String, dynamic> json) => TLVModel(
        tag: json["tag"],
        length: json["lenght"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "lenght": length,
        "value": value,
      };
}
