import '../../../models/cpm/ber_tvl.dart';

class ApplicationTemplate {
  BerTvl? _berTvl;
  final List<BerTvl> _applicationSpecificTransparentTemplates = [];

  BerTvl? get berTvl => _berTvl;

  List<BerTvl> get applicationSpecificTransparentTemplates =>
      _applicationSpecificTransparentTemplates;

  addApplicationSpecificTransparentTemplates({
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
  }) {
    final berTvl = BerTvl(
      dataApplicationDefinitionFileName: dataApplicationDefinitionFileName,
      dataApplicationLabel: dataApplicationLabel,
      dataTrack2EquivalentData: dataTrack2EquivalentData,
      dataApplicationPan: dataApplicationPan,
      dataCardholderName: dataCardholderName,
      dataLanguagePreference: dataLanguagePreference,
      dataIssuerUrl: dataIssuerUrl,
      dataApplicationVersionNumber: dataApplicationVersionNumber,
      dataIssuerApplicationData: dataIssuerApplicationData,
      dataTokenRequestorId: dataTokenRequestorId,
      dataPaymentAccountReference: dataPaymentAccountReference,
      dataLast4DigitsOfPan: dataLast4DigitsOfPan,
      dataApplicationCryptogram: dataApplicationCryptogram,
      dataApplicationTransactionCounter: dataApplicationTransactionCounter,
      dataUnpredictableNumber: dataUnpredictableNumber,
    );
    _applicationSpecificTransparentTemplates.add(berTvl);
  }

  setBerTvl({
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
  }) {
    final berTvl = BerTvl(
      dataApplicationDefinitionFileName: dataApplicationDefinitionFileName,
      dataApplicationLabel: dataApplicationLabel,
      dataTrack2EquivalentData: dataTrack2EquivalentData,
      dataApplicationPan: dataApplicationPan,
      dataCardholderName: dataCardholderName,
      dataLanguagePreference: dataLanguagePreference,
      dataIssuerUrl: dataIssuerUrl,
      dataApplicationVersionNumber: dataApplicationVersionNumber,
      dataIssuerApplicationData: dataIssuerApplicationData,
      dataTokenRequestorId: dataTokenRequestorId,
      dataPaymentAccountReference: dataPaymentAccountReference,
      dataLast4DigitsOfPan: dataLast4DigitsOfPan,
      dataApplicationCryptogram: dataApplicationCryptogram,
      dataApplicationTransactionCounter: dataApplicationTransactionCounter,
      dataUnpredictableNumber: dataUnpredictableNumber,
    );
    _berTvl = berTvl;
  }
}
