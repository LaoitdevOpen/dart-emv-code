// To parse this JSON data, do
//
//     final parserModel = parserModelFromJson(jsonString);

import 'dart:convert';

import 'package:emvqrcode/src/models/tlv_model.dart';


UnreservedTemplate unreservedTemplateFromJson(String str) => UnreservedTemplate.fromJson(json.decode(str));

String unreservedTemplateToJson(UnreservedTemplate data) => json.encode(data.toJson());


class UnreservedTemplate {
    UnreservedTemplate({
        this.tag,
        this.length,
        this.value,
    });

    String? tag;
    String? length;
    UnreservedTemplateValue? value;

    UnreservedTemplate copyWith({
        String? tag,
        String? length,
        UnreservedTemplateValue? value,
    }) => 
        UnreservedTemplate(
            tag: tag ?? this.tag,
            length: length ?? this.length,
            value: value ?? this.value,
        );

    factory UnreservedTemplate.fromJson(Map<String, dynamic> json) => UnreservedTemplate(
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
            globallyUniqueIdentifier: globallyUniqueIdentifier ?? this.globallyUniqueIdentifier,
            contextSpecificData: contextSpecificData ?? this.contextSpecificData,
        );

    factory UnreservedTemplateValue.fromJson(Map<String, dynamic> json) => UnreservedTemplateValue(
        globallyUniqueIdentifier: TLVModel.fromJson(json["globallyUniqueIdentifier"]),
        contextSpecificData: List<TLVModel>.from(json["contextSpecificData"].map((x) => TLVModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "globallyUniqueIdentifier": globallyUniqueIdentifier?.toJson(),
        "contextSpecificData": List<dynamic>.from(contextSpecificData!.map((x) => x.toJson())),
    };
}
