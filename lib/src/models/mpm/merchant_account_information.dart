import 'dart:convert';

import 'tlv_model.dart';

MerchantAccountInformationModel merchantAccountInformationFromJson(
        String str) =>
    MerchantAccountInformationModel.fromJson(json.decode(str));

String merchantAccountInformationToJson(MerchantAccountInformationModel data) =>
    json.encode(data.toJson());

class MerchantAccountInformationModel {
  MerchantAccountInformationModel({
    this.tag,
    this.length,
    this.value,
  });

  final String? tag;
  final String? length;
  final MerchantAccountInformationValue? value;

  MerchantAccountInformationModel copyWith({
    String? tag,
    String? length,
    MerchantAccountInformationValue? value,
  }) =>
      MerchantAccountInformationModel(
        tag: tag ?? this.tag,
        length: length ?? this.length,
        value: value ?? this.value,
      );

  factory MerchantAccountInformationModel.fromJson(Map<String, dynamic> json) =>
      MerchantAccountInformationModel(
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

  factory MerchantAccountInformationValue.fromJson(Map<String, dynamic> json) =>
      MerchantAccountInformationValue(
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
