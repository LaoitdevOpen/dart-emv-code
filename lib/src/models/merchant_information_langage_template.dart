import 'package:emvqrcode/src/models/tlv_model.dart';


class MerchantInformationLanguageTemplate {
  MerchantInformationLanguageTemplate({
    this.languagePreference,
    this.merchantName,
    this.merchantCity,
    this.rfuForEMVCo,
  });
  TLVModel? languagePreference;
  TLVModel? merchantName;
  TLVModel? merchantCity;
  List<TLVModel>? rfuForEMVCo;

  MerchantInformationLanguageTemplate copyWith({
    TLVModel? languagePreference,
    TLVModel? merchantName,
    TLVModel? merchantCity,
    List<TLVModel>? rfuForEMVCo,
  }) =>
      MerchantInformationLanguageTemplate(
        languagePreference: languagePreference ?? this.languagePreference,
        merchantName: merchantName ?? this.merchantName,
        merchantCity: merchantCity ?? this.merchantCity,
        rfuForEMVCo: rfuForEMVCo ?? this.rfuForEMVCo,
      );

  factory MerchantInformationLanguageTemplate.fromJson(
          Map<String, dynamic> json) =>
      MerchantInformationLanguageTemplate(
        languagePreference: TLVModel.fromJson(json["languagePreference"]),
        merchantName: TLVModel.fromJson(json["merchantName"]),
        merchantCity: TLVModel.fromJson(json["merchantCity"]),
        rfuForEMVCo: List<TLVModel>.from(
            json["rfuForEMVCo"].map((x) => TLVModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "languagePreference": languagePreference!.toJson(),
        "merchantName": merchantName!.toJson(),
        "merchantCity": merchantCity!.toJson(),
        "rfuForEMVCo": List<dynamic>.from(rfuForEMVCo!.map((x) => x.toJson())),
      };
}
