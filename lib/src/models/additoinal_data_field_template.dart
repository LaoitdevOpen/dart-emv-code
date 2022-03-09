import 'package:emvqrcode/src/models/tlv_model.dart';

class AdditionalDataFieldTemplate {
  AdditionalDataFieldTemplate({
    this.billNumber,
    this.mobileNumber,
    this.storeLabel,
    this.loyaltyNumber,
    this.referenceLabel,
    this.customerLabel,
    this.terminalLabel,
    this.purposeTransaction,
    this.additionalConsumerDataRequest,
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
  List<TLVModel>? rfuForEMVCo;
  List<TLVModel>? paymentSystemSpecific;

  AdditionalDataFieldTemplate copyWith({
    TLVModel? billNumber,
    TLVModel? mobileNumber,
    TLVModel? storeLabel,
    TLVModel? loyaltyNumber,
    TLVModel? referenceLabel,
    TLVModel? customerLabel,
    TLVModel? terminalLabel,
    TLVModel? purposeTransaction,
    TLVModel? additionalConsumerDataRequest,
    List<TLVModel>? rfuForEMVCo,
    List<TLVModel>? paymentSystemSpecific,
  }) =>
      AdditionalDataFieldTemplate(
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
        rfuForEMVCo: rfuForEMVCo ?? this.rfuForEMVCo,
        paymentSystemSpecific:
            paymentSystemSpecific ?? this.paymentSystemSpecific,
      );

  factory AdditionalDataFieldTemplate.fromJson(Map<String, dynamic> json) =>
      AdditionalDataFieldTemplate(
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
        "referenceLabel": referenceLabel != null ? referenceLabel!.toJson() : null,
        "customerLabel": customerLabel != null ? customerLabel!.toJson() : null,
        "terminalLabel": terminalLabel != null ? terminalLabel!.toJson() : null,
        "purposeTransaction": purposeTransaction != null ? purposeTransaction!.toJson() : null,
        "additionalConsumerDataRequest": additionalConsumerDataRequest != null ? additionalConsumerDataRequest!.toJson() : null,
        "rfuForEMVCo": rfuForEMVCo != null
            ? List<dynamic>.from(rfuForEMVCo!.map((x) => x.toJson()))
            : [],
        "paymentSystemSpecific": paymentSystemSpecific != null
            ? List<dynamic>.from(paymentSystemSpecific!.map((x) => x.toJson()))
            : [],
      };
}
