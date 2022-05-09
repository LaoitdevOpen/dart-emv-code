// To parse this JSON data, do
//
//     final  BerTvl =  BerTvlFromJson(jsonString);

import 'dart:convert';

BerTvl berTvlFromJson(String str) => BerTvl.fromJson(json.decode(str));

String berTvlToJson(BerTvl data) => json.encode(data.toJson());

class BerTvl {
  BerTvl({
    this.dataApplicationDefinitionFileName,
    this.dataApplicationLabel,
    this.dataTrack2EquivalentData,
    this.dataApplicationPan,
    this.dataCardholderName,
    this.dataLanguagePreference,
    this.dataIssuerUrl,
    this.dataApplicationVersionNumber,
    this.dataIssuerApplicationData,
    this.dataTokenRequestorId,
    this.dataPaymentAccountReference,
    this.dataLast4DigitsOfPan,
    this.dataApplicationCryptogram,
    this.dataApplicationTransactionCounter,
    this.dataUnpredictableNumber,
  });

  String? dataApplicationDefinitionFileName;
  String? dataApplicationLabel;
  String? dataTrack2EquivalentData;
  String? dataApplicationPan;
  String? dataCardholderName;
  String? dataLanguagePreference;
  String? dataIssuerUrl;
  String? dataApplicationVersionNumber;
  String? dataIssuerApplicationData;
  String? dataTokenRequestorId;
  String? dataPaymentAccountReference;
  String? dataLast4DigitsOfPan;
  String? dataApplicationCryptogram;
  String? dataApplicationTransactionCounter;
  String? dataUnpredictableNumber;

  BerTvl copyWith({
    String? dataApplicationDefinitionFileName,
    String? dataApplicationLabel,
    String? dataTrack2EquivalentData,
    String? dataApplicationPan,
    String? dataCardholderName,
    String? dataLanguagePreference,
    String? dataIssuerUrl,
    String? dataApplicationVersionNumber,
    String? dataIssuerApplicationData,
    String? dataTokenRequestorId,
    String? dataPaymentAccountReference,
    String? dataLast4DigitsOfPan,
    String? dataApplicationCryptogram,
    String? dataApplicationTransactionCounter,
    String? dataUnpredictableNumber,
  }) =>
      BerTvl(
        dataApplicationDefinitionFileName: dataApplicationDefinitionFileName ??
            this.dataApplicationDefinitionFileName,
        dataApplicationLabel: dataApplicationLabel ?? this.dataApplicationLabel,
        dataTrack2EquivalentData:
            dataTrack2EquivalentData ?? this.dataTrack2EquivalentData,
        dataApplicationPan: dataApplicationPan ?? this.dataApplicationPan,
        dataCardholderName: dataCardholderName ?? this.dataCardholderName,
        dataLanguagePreference:
            dataLanguagePreference ?? this.dataLanguagePreference,
        dataIssuerUrl: dataIssuerUrl ?? this.dataIssuerUrl,
        dataApplicationVersionNumber:
            dataApplicationVersionNumber ?? this.dataApplicationVersionNumber,
        dataIssuerApplicationData:
            dataIssuerApplicationData ?? this.dataIssuerApplicationData,
        dataTokenRequestorId: dataTokenRequestorId ?? this.dataTokenRequestorId,
        dataPaymentAccountReference:
            dataPaymentAccountReference ?? this.dataPaymentAccountReference,
        dataLast4DigitsOfPan: dataLast4DigitsOfPan ?? this.dataLast4DigitsOfPan,
        dataApplicationCryptogram:
            dataApplicationCryptogram ?? this.dataApplicationCryptogram,
        dataApplicationTransactionCounter: dataApplicationTransactionCounter ??
            this.dataApplicationTransactionCounter,
        dataUnpredictableNumber:
            dataUnpredictableNumber ?? this.dataUnpredictableNumber,
      );

  factory BerTvl.fromJson(Map<String, dynamic> json) => BerTvl(
        dataApplicationDefinitionFileName:
            json["DataApplicationDefinitionFileName"],
        dataApplicationLabel: json["DataApplicationLabel"],
        dataTrack2EquivalentData: json["DataTrack2EquivalentData"],
        dataApplicationPan: json["DataApplicationPAN"],
        dataCardholderName: json["DataCardholderName"],
        dataLanguagePreference: json["DataLanguagePreference"],
        dataIssuerUrl: json["DataIssuerURL"],
        dataApplicationVersionNumber: json["DataApplicationVersionNumber"],
        dataIssuerApplicationData: json["DataIssuerApplicationData"],
        dataTokenRequestorId: json["DataTokenRequestorID"],
        dataPaymentAccountReference: json["DataPaymentAccountReference"],
        dataLast4DigitsOfPan: json["DataLast4DigitsOfPAN"],
        dataApplicationCryptogram: json["DataApplicationCryptogram"],
        dataApplicationTransactionCounter:
            json["DataApplicationTransactionCounter"],
        dataUnpredictableNumber: json["DataUnpredictableNumber"],
      );

  Map<String, dynamic> toJson() => {
        "DataApplicationDefinitionFileName": dataApplicationDefinitionFileName,
        "DataApplicationLabel": dataApplicationLabel,
        "DataTrack2EquivalentData": dataTrack2EquivalentData,
        "DataApplicationPAN": dataApplicationPan,
        "DataCardholderName": dataCardholderName,
        "DataLanguagePreference": dataLanguagePreference,
        "DataIssuerURL": dataIssuerUrl,
        "DataApplicationVersionNumber": dataApplicationVersionNumber,
        "DataIssuerApplicationData": dataIssuerApplicationData,
        "DataTokenRequestorID": dataTokenRequestorId,
        "DataPaymentAccountReference": dataPaymentAccountReference,
        "DataLast4DigitsOfPAN": dataLast4DigitsOfPan,
        "DataApplicationCryptogram": dataApplicationCryptogram,
        "DataApplicationTransactionCounter": dataApplicationTransactionCounter,
        "DataUnpredictableNumber": dataUnpredictableNumber,
      };
}
