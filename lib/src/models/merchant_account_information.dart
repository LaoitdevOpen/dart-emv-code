import 'dart:convert';

import 'package:emvqrcode/src/models/tlv_model.dart';

MerchantAccountInformation merchantAccountInformationFromJson(String str) =>
    MerchantAccountInformation.fromJson(json.decode(str));

String merchantAccountInformationToJson(MerchantAccountInformation data) =>
    json.encode(data.toJson());

class MerchantAccountInformation {
  MerchantAccountInformation({
    this.tag,
    this.length,
    this.value,
  });

  final String? tag;
  final String? length;
  final MerchantAccountInformationValue? value;

  MerchantAccountInformation copyWith({
    String? tag,
    String? length,
    MerchantAccountInformationValue? value,
  }) =>
      MerchantAccountInformation(
        tag: tag ?? this.tag,
        length: length ?? this.length,
        value: value ?? this.value,
      );

  factory MerchantAccountInformation.fromJson(Map<String, dynamic> json) =>
      MerchantAccountInformation(
        tag: json["tag"],
        length: json["length"],
        value: MerchantAccountInformationValue.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "length": length,
        "value": value?.toJson(),
      };
}

class MerchantAccountInformationValue {
  MerchantAccountInformationValue({
    this.globallyUniqueIdentifier,
    this.paymentNetworkSpecific,
  });

  final TLVModel? globallyUniqueIdentifier;
  final List<TLVModel>? paymentNetworkSpecific;

  MerchantAccountInformationValue copyWith({
    TLVModel? globallyUniqueIdentifier,
    List<TLVModel>? paymentNetworkSpecific,
  }) =>
      MerchantAccountInformationValue(
        globallyUniqueIdentifier:
            globallyUniqueIdentifier ?? this.globallyUniqueIdentifier,
        paymentNetworkSpecific:
            paymentNetworkSpecific ?? this.paymentNetworkSpecific,
      );

  factory MerchantAccountInformationValue.fromJson(Map<String, dynamic> json) => MerchantAccountInformationValue(
        globallyUniqueIdentifier:
            TLVModel.fromJson(json["globallyUniqueIdentifier"]),
        paymentNetworkSpecific: List<TLVModel>.from(
            json["paymentNetworkSpecific"].map((x) => TLVModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "globallyUniqueIdentifier": globallyUniqueIdentifier?.toJson(),
        "paymentNetworkSpecific":
            List<dynamic>.from(paymentNetworkSpecific!.map((x) => x.toJson())),
      };
}

