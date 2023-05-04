import 'dart:convert';

import 'additoinal_data_field_template.dart';
import 'merchant_account_information.dart';
import 'merchant_information_langage_template.dart';
import 'tlv_model.dart';
import 'unreserved_template.dart';

EmvqrModel emvqrModelFromJson(String str) =>
    EmvqrModel.fromJson(json.decode(str));

String emvqrModelToJson(EmvqrModel data) => json.encode(data.toJson());

class EmvqrModel {
  EmvqrModel({
    this.payloadFormatIndicator,
    this.pointOfInitiationMethod,
    this.merchantAccountInformation,
    this.merchantCategoryCode,
    this.transactionCurrency,
    this.transactionAmount,
    this.tipOrConvenienceIndicator,
    this.valueOfConvenienceFeeFixed,
    this.valueOfConvenienceFeePercentage,
    this.countryCode,
    this.merchantName,
    this.merchantCity,
    this.postalCode,
    this.additionalDataFieldTemplate,
    this.crc,
    this.merchantInformationLanguageTemplate,
    this.rfuForEmvCo,
    this.unreservedTemplates,
  });

  TLVModel? payloadFormatIndicator;
  TLVModel? pointOfInitiationMethod;
  Map<String, MerchantAccountInformationModel>? merchantAccountInformation;
  TLVModel? merchantCategoryCode;
  TLVModel? transactionCurrency;
  TLVModel? transactionAmount;
  TLVModel? tipOrConvenienceIndicator;
  TLVModel? valueOfConvenienceFeeFixed;
  TLVModel? valueOfConvenienceFeePercentage;
  TLVModel? countryCode;
  TLVModel? merchantName;
  TLVModel? merchantCity;
  TLVModel? postalCode;
  AdditionalDataFieldTemplateModel? additionalDataFieldTemplate;
  TLVModel? crc;
  MerchantInformationLanguageTemplateModel? merchantInformationLanguageTemplate;
  List<TLVModel>? rfuForEmvCo;
  Map<String, UnreservedTemplateModel>? unreservedTemplates;

  EmvqrModel copyWith({
    TLVModel? payloadFormatIndicator,
    TLVModel? pointOfInitiationMethod,
    Map<String, MerchantAccountInformationModel>? merchantAccountInformation,
    TLVModel? merchantCategoryCode,
    TLVModel? transactionCurrency,
    TLVModel? transactionAmount,
    TLVModel? tipOrConvenienceIndicator,
    TLVModel? valueOfConvenienceFeeFixed,
    TLVModel? valueOfConvenienceFeePercentage,
    TLVModel? countryCode,
    TLVModel? merchantName,
    TLVModel? merchantCity,
    TLVModel? postalCode,
    AdditionalDataFieldTemplateModel? additionalDataFieldTemplate,
    TLVModel? crc,
    MerchantInformationLanguageTemplateModel?
        merchantInformationLanguageTemplate,
    List<TLVModel>? rfuForEmvCo,
    Map<String, UnreservedTemplateModel>? unreservedTemplates,
  }) =>
      EmvqrModel(
        payloadFormatIndicator:
            payloadFormatIndicator ?? this.payloadFormatIndicator,
        pointOfInitiationMethod:
            pointOfInitiationMethod ?? this.pointOfInitiationMethod,
        merchantAccountInformation:
            merchantAccountInformation ?? this.merchantAccountInformation,
        merchantCategoryCode: merchantCategoryCode ?? this.merchantCategoryCode,
        transactionCurrency: transactionCurrency ?? this.transactionCurrency,
        transactionAmount: transactionAmount ?? this.transactionAmount,
        tipOrConvenienceIndicator:
            tipOrConvenienceIndicator ?? this.tipOrConvenienceIndicator,
        valueOfConvenienceFeeFixed:
            valueOfConvenienceFeeFixed ?? this.valueOfConvenienceFeeFixed,
        valueOfConvenienceFeePercentage: valueOfConvenienceFeePercentage ??
            this.valueOfConvenienceFeePercentage,
        countryCode: countryCode ?? this.countryCode,
        merchantName: merchantName ?? this.merchantName,
        merchantCity: merchantCity ?? this.merchantCity,
        postalCode: postalCode ?? this.postalCode,
        additionalDataFieldTemplate:
            additionalDataFieldTemplate ?? this.additionalDataFieldTemplate,
        crc: crc ?? this.crc,
        merchantInformationLanguageTemplate:
            merchantInformationLanguageTemplate ??
                this.merchantInformationLanguageTemplate,
        rfuForEmvCo: rfuForEmvCo ?? this.rfuForEmvCo,
        unreservedTemplates: unreservedTemplates ?? this.unreservedTemplates,
      );

  factory EmvqrModel.fromJson(Map<String, dynamic> json) => EmvqrModel(
        payloadFormatIndicator:
            TLVModel.fromJson(json["payloadFormatIndicator"]),
        pointOfInitiationMethod:
            TLVModel.fromJson(json["pointOfInitiationMethod"]),
        merchantAccountInformation: Map.from(json["MerchantAccountInformation"])
            .map((k, v) => MapEntry<String, MerchantAccountInformationModel>(
                k, MerchantAccountInformationModel.fromJson(v))),
        merchantCategoryCode: TLVModel.fromJson(json["merchantCategoryCode"]),
        transactionCurrency: TLVModel.fromJson(json["transactionCurrency"]),
        transactionAmount: TLVModel.fromJson(json["transactionAmount"]),
        tipOrConvenienceIndicator:
            TLVModel.fromJson(json["tipOrConvenienceIndicator"]),
        valueOfConvenienceFeeFixed:
            TLVModel.fromJson(json["valueOfConvenienceFeeFixed"]),
        valueOfConvenienceFeePercentage:
            TLVModel.fromJson(json["valueOfConvenienceFeePercentage"]),
        countryCode: TLVModel.fromJson(json["countryCode"]),
        merchantName: TLVModel.fromJson(json["merchantName"]),
        merchantCity: TLVModel.fromJson(json["merchantCity"]),
        postalCode: TLVModel.fromJson(json["postalCode"]),
        additionalDataFieldTemplate: AdditionalDataFieldTemplateModel.fromJson(
            json["additionalDataFieldTemplate"]),
        crc: TLVModel.fromJson(json["crc"]),
        merchantInformationLanguageTemplate:
            MerchantInformationLanguageTemplateModel.fromJson(
                json["merchantInformationLanguageTemplate"]),
        rfuForEmvCo: List<TLVModel>.from(
            json["rfuForEMVCo"].map((x) => TLVModel.fromJson(x))),
        unreservedTemplates: Map.from(json["unreservedTemplates"]).map((k, v) =>
            MapEntry<String, UnreservedTemplateModel>(
                k, UnreservedTemplateModel.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "payloadFormatIndicator": payloadFormatIndicator?.toJson(),
        "pointOfInitiationMethod": pointOfInitiationMethod?.toJson(),
        "merchantAccountInformation": Map.from(merchantAccountInformation ?? {})
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "merchantCategoryCode": merchantCategoryCode?.toJson(),
        "transactionCurrency": transactionCurrency?.toJson(),
        "transactionAmount": transactionAmount?.toJson(),
        "tipOrConvenienceIndicator": tipOrConvenienceIndicator?.toJson(),
        "valueOfConvenienceFeeFixed": valueOfConvenienceFeeFixed?.toJson(),
        "valueOfConvenienceFeePercentage":
            valueOfConvenienceFeePercentage?.toJson(),
        "countryCode": countryCode?.toJson(),
        "merchantName": merchantName?.toJson(),
        "merchantCity": merchantCity?.toJson(),
        "postalCode": postalCode?.toJson(),
        "additionalDataFieldTemplate": additionalDataFieldTemplate?.toJson(),
        "crc": crc?.toJson(),
        "merchantInformationLanguageTemplate":
            merchantInformationLanguageTemplate?.toJson(),
        "rfuForEMVCo": rfuForEmvCo != null
            ? List<dynamic>.from(rfuForEmvCo!.map((x) => x.toJson()))
            : [],
        "unreservedTemplates": Map.from(unreservedTemplates ?? {})
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}
