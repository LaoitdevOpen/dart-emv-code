import 'tlv_model.dart';

class MerchantInformationLanguageTemplateModel {
  MerchantInformationLanguageTemplateModel({
    this.tag,
    this.length,
    this.value,
  });

  String? tag;
  String? length;
  MerchantInformationLanguageTemplateValue? value;

  MerchantInformationLanguageTemplateModel copyWith({
    String? tag,
    String? length,
    MerchantInformationLanguageTemplateValue? value,
  }) =>
      MerchantInformationLanguageTemplateModel(
        tag: tag ?? this.tag,
        length: length ?? this.length,
        value: value ?? this.value,
      );

  factory MerchantInformationLanguageTemplateModel.fromJson(
          Map<String, dynamic> json) =>
      MerchantInformationLanguageTemplateModel(
        tag: json["tag"],
        length: json["length"],
        value: MerchantInformationLanguageTemplateValue.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "length": length,
        "value": value?.toJson(),
      };
}

class MerchantInformationLanguageTemplateValue {
  MerchantInformationLanguageTemplateValue({
    this.languagePreference,
    this.merchantName,
    this.merchantCity,
    this.rfuForEMVCo,
  });
  TLVModel? languagePreference;
  TLVModel? merchantName;
  TLVModel? merchantCity;
  List<TLVModel>? rfuForEMVCo;

  MerchantInformationLanguageTemplateValue copyWith({
    TLVModel? languagePreference,
    TLVModel? merchantName,
    TLVModel? merchantCity,
    List<TLVModel>? rfuForEMVCo,
  }) =>
      MerchantInformationLanguageTemplateValue(
        languagePreference: languagePreference ?? this.languagePreference,
        merchantName: merchantName ?? this.merchantName,
        merchantCity: merchantCity ?? this.merchantCity,
        rfuForEMVCo: rfuForEMVCo ?? this.rfuForEMVCo,
      );

  factory MerchantInformationLanguageTemplateValue.fromJson(
          Map<String, dynamic> json) =>
      MerchantInformationLanguageTemplateValue(
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
