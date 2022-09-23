import 'tlv_model.dart';

class AdditionalDataFieldTemplateModel {
  AdditionalDataFieldTemplateModel({
    this.tag,
    this.length,
    this.value,
  });

  String? tag;
  String? length;
  AdditionalDataFieldTemplateValue? value;

  AdditionalDataFieldTemplateModel copyWith({
    String? tag,
    String? length,
    AdditionalDataFieldTemplateValue? value,
  }) =>
      AdditionalDataFieldTemplateModel(
        tag: tag ?? this.tag,
        length: length ?? this.length,
        value: value ?? this.value,
      );

  factory AdditionalDataFieldTemplateModel.fromJson(
          Map<String, dynamic> json) =>
      AdditionalDataFieldTemplateModel(
        tag: json["tag"],
        length: json["length"],
        value: AdditionalDataFieldTemplateValue.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "length": length,
        "value": value?.toJson(),
      };
}

class AdditionalDataFieldTemplateValue {
  AdditionalDataFieldTemplateValue({
    this.billNumber,
    this.mobileNumber,
    this.storeLabel,
    this.loyaltyNumber,
    this.referenceLabel,
    this.customerLabel,
    this.terminalLabel,
    this.purposeTransaction,
    this.additionalConsumerDataRequest,
    this.merchantTaxId,
    this.merchantChannel,
    this.rfuForEMVCo,
    this.paymentSystemSpecific,
  });

  TLVModel? billNumber;
  TLVModel? mobileNumber;
  TLVModel? storeLabel;
  TLVModel? loyaltyNumber;
  TLVModel? referenceLabel;
  TLVModel? customerLabel;
  TLVModel? terminalLabel;
  TLVModel? purposeTransaction;
  TLVModel? additionalConsumerDataRequest;
  TLVModel? merchantTaxId;
  TLVModel? merchantChannel;
  List<TLVModel>? rfuForEMVCo;
  List<TLVModel>? paymentSystemSpecific;

  AdditionalDataFieldTemplateValue copyWith({
    TLVModel? billNumber,
    TLVModel? mobileNumber,
    TLVModel? storeLabel,
    TLVModel? loyaltyNumber,
    TLVModel? referenceLabel,
    TLVModel? customerLabel,
    TLVModel? terminalLabel,
    TLVModel? purposeTransaction,
    TLVModel? additionalConsumerDataRequest,
    TLVModel? merchantTaxId,
    TLVModel? merchantChannel,
    List<TLVModel>? rfuForEMVCo,
    List<TLVModel>? paymentSystemSpecific,
  }) =>
      AdditionalDataFieldTemplateValue(
        billNumber: billNumber ?? this.billNumber,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        storeLabel: storeLabel ?? this.storeLabel,
        loyaltyNumber: loyaltyNumber ?? this.loyaltyNumber,
        referenceLabel: referenceLabel ?? this.referenceLabel,
        customerLabel: customerLabel ?? this.customerLabel,
        terminalLabel: terminalLabel ?? this.terminalLabel,
        purposeTransaction: purposeTransaction ?? this.purposeTransaction,
        additionalConsumerDataRequest:
            additionalConsumerDataRequest ?? this.additionalConsumerDataRequest,
        merchantTaxId: merchantTaxId ?? this.merchantTaxId,
        merchantChannel: merchantChannel ?? this.merchantChannel,
        rfuForEMVCo: rfuForEMVCo ?? this.rfuForEMVCo,
        paymentSystemSpecific:
            paymentSystemSpecific ?? this.paymentSystemSpecific,
      );

  factory AdditionalDataFieldTemplateValue.fromJson(
          Map<String, dynamic> json) =>
      AdditionalDataFieldTemplateValue(
        billNumber: TLVModel.fromJson(json["billNumber"]),
        mobileNumber: TLVModel.fromJson(json["mobileNumber"]),
        storeLabel: TLVModel.fromJson(json["storeLabel"]),
        loyaltyNumber: TLVModel.fromJson(json["loyaltyNumber"]),
        referenceLabel: TLVModel.fromJson(json["referenceLabel"]),
        customerLabel: TLVModel.fromJson(json["customerLabel"]),
        terminalLabel: TLVModel.fromJson(json["terminalLabel"]),
        purposeTransaction: TLVModel.fromJson(json["purposeTransaction"]),
        additionalConsumerDataRequest:
            TLVModel.fromJson(json["additionalConsumerDataRequest"]),
        merchantTaxId: TLVModel.fromJson(json["merchantTaxID"]),
        merchantChannel: TLVModel.fromJson(json["merchantChannel"]),
        rfuForEMVCo: List<TLVModel>.from(
            json["rfuForEMVCo"].map((x) => TLVModel.fromJson(x))),
        paymentSystemSpecific: List<TLVModel>.from(
            json["paymentSystemSpecific"].map((x) => TLVModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "billNumber": billNumber != null ? billNumber!.toJson() : null,
        "mobileNumber": mobileNumber != null ? mobileNumber!.toJson() : null,
        "storeLabel": storeLabel != null ? storeLabel!.toJson() : null,
        "loyaltyNumber": loyaltyNumber != null ? loyaltyNumber!.toJson() : null,
        "referenceLabel":
            referenceLabel != null ? referenceLabel!.toJson() : null,
        "customerLabel": customerLabel != null ? customerLabel!.toJson() : null,
        "terminalLabel": terminalLabel != null ? terminalLabel!.toJson() : null,
        "purposeTransaction":
            purposeTransaction != null ? purposeTransaction!.toJson() : null,
        "additionalConsumerDataRequest": additionalConsumerDataRequest != null
            ? additionalConsumerDataRequest!.toJson()
            : null,
        "merchantTaxID": merchantTaxId != null ? merchantTaxId!.toJson() : null,
        "merchantChannel":
            merchantChannel != null ? merchantChannel!.toJson() : null,
        "rfuForEMVCo": rfuForEMVCo != null
            ? List<dynamic>.from(rfuForEMVCo!.map((x) => x.toJson()))
            : [],
        "paymentSystemSpecific": paymentSystemSpecific != null
            ? List<dynamic>.from(paymentSystemSpecific!.map((x) => x.toJson()))
            : [],
      };
}
