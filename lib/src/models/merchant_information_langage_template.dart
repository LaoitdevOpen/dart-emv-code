import 'package:emvqrcode/src/models/tlv_model.dart';

class MerchantInformationLanguageTemplateModel {
  MerchantInformationLanguageTemplateModel({
    this.languagePreference,
    this.merchantName,
    this.merchantCity,
    this.rfuForEMVCo,
  });
  TLVModel? languagePreference;
  TLVModel? merchantName;
  TLVModel? merchantCity;
  List<TLVModel>? rfuForEMVCo;

  MerchantInformationLanguageTemplateModel copyWith({
    TLVModel? languagePreference,
    TLVModel? merchantName,
    TLVModel? merchantCity,
    List<TLVModel>? rfuForEMVCo,
  }) =>
      MerchantInformationLanguageTemplateModel(
        languagePreference: languagePreference ?? this.languagePreference,
        merchantName: merchantName ?? this.merchantName,
        merchantCity: merchantCity ?? this.merchantCity,
        rfuForEMVCo: rfuForEMVCo ?? this.rfuForEMVCo,
      );

  factory MerchantInformationLanguageTemplateModel.fromJson(
          Map<String, dynamic> json) =>
      MerchantInformationLanguageTemplateModel(
        languagePreference: TLVModel.fromJson(json["languagePreference"]),
        merchantName: TLVModel.fromJson(json["merchantName"]),
        merchantCity: TLVModel.fromJson(json["merchantCity"]),
        rfuForEMVCo: List<TLVModel>.from(
            json["rfuForEMVCo"].map((x) => TLVModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "languagePreference":
            languagePreference != null ? languagePreference!.toJson() : null,
        "merchantName": merchantName != null ? merchantName!.toJson() : null,
        "merchantCity": merchantCity != null ? merchantCity!.toJson() : null,
        "rfuForEMVCo": rfuForEMVCo != null
            ? List<dynamic>.from(rfuForEMVCo!.map((x) => x.toJson()))
            : null,
      };
}
