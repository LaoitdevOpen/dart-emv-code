import 'dart:convert';

import 'tlv_model.dart';

UnreservedTemplateModel unreservedTemplateFromJson(String str) =>
    UnreservedTemplateModel.fromJson(json.decode(str));

String unreservedTemplateToJson(UnreservedTemplateModel data) =>
    json.encode(data.toJson());

class UnreservedTemplateModel {
  UnreservedTemplateModel({
    this.tag,
    this.length,
    this.value,
  });

  String? tag;
  String? length;
  UnreservedTemplateValue? value;

  UnreservedTemplateModel copyWith({
    String? tag,
    String? length,
    UnreservedTemplateValue? value,
  }) =>
      UnreservedTemplateModel(
        tag: tag ?? this.tag,
        length: length ?? this.length,
        value: value ?? this.value,
      );

  factory UnreservedTemplateModel.fromJson(Map<String, dynamic> json) =>
      UnreservedTemplateModel(
        tag: json["tag"],
        length: json["length"],
        value: UnreservedTemplateValue.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "length": length,
        "value": value?.toJson(),
      };
}

class UnreservedTemplateValue {
  UnreservedTemplateValue({
    this.globallyUniqueIdentifier,
    this.contextSpecificData,
  });

  TLVModel? globallyUniqueIdentifier;
  List<TLVModel>? contextSpecificData;

  UnreservedTemplateValue copyWith({
    TLVModel? globallyUniqueIdentifier,
    List<TLVModel>? contextSpecificData,
  }) =>
      UnreservedTemplateValue(
        globallyUniqueIdentifier:
            globallyUniqueIdentifier ?? this.globallyUniqueIdentifier,
        contextSpecificData: contextSpecificData ?? this.contextSpecificData,
      );

  factory UnreservedTemplateValue.fromJson(Map<String, dynamic> json) =>
      UnreservedTemplateValue(
        globallyUniqueIdentifier:
            TLVModel.fromJson(json["globallyUniqueIdentifier"]),
        contextSpecificData: List<TLVModel>.from(
            json["contextSpecificData"].map((x) => TLVModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "globallyUniqueIdentifier": globallyUniqueIdentifier?.toJson(),
        "contextSpecificData":
            List<dynamic>.from(contextSpecificData!.map((x) => x.toJson())),
      };
}
