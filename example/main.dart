import 'package:emvqrcode/emvqrcode.dart';

void main(List<String> args) {
  /**
   * generate emv QR code
   */
  final emv = MPMQR();

  emv.setPayloadFormatIndicator("00");
  emv.setPointOfInitiationMethod("12");

  /// merchant account information
  final mAccountInfo = MerchantAccountInformation();
  mAccountInfo.setGloballyUniqueIdentifier("IT");
  mAccountInfo.addPaymentNetworkSpecific(id: "01", value: "abc");
  mAccountInfo.addPaymentNetworkSpecific(id: "02", value: "def");
  emv.addMerchantAccountInformation(id: "03", value: mAccountInfo);

  final mAccountInfo2 = MerchantAccountInformation();
  mAccountInfo2.setGloballyUniqueIdentifier("IT");
  mAccountInfo2.addPaymentNetworkSpecific(id: "01", value: "abc");
  mAccountInfo2.addPaymentNetworkSpecific(id: "02", value: "def");
  emv.addMerchantAccountInformation(id: "04", value: mAccountInfo2);

  final additionalData = AdditionalDataFieldTemplate();
  additionalData.setBillNumber("0qwea");
  additionalData.setMerchantTaxID("tax id");
  additionalData.setMerchantChannel("cha");
  additionalData.addRfuForEMVCo(id: "12", value: "00");
  additionalData.addRfuForEMVCo(id: "13", value: "13");
  additionalData.addPaymentSystemSpecific(id: "50", value: "123");
  additionalData.addPaymentSystemSpecific(id: "51", value: "123");
  emv.setAdditionalDataFieldTemplate(additionalData);

  final mInfoLang = MerchantInformationLanguageTemplate();
  mInfoLang.setLanguagePreferencer("LA");
  mInfoLang.setMerchantCity("Vientaine");
  mInfoLang.setMerchantName("MW");
  mInfoLang.addRfuForEMVCo(id: "03", value: "asfg");
  mInfoLang.addRfuForEMVCo(id: "04", value: "asfg");
  emv.setMerchantInformationLanguageTemplate(mInfoLang);

  emv.addRfuForEMVCo(id: "65", value: "bbc");
  emv.addRfuForEMVCo(id: "66", value: "bbb");

  final unreserved1 = UnreservedTemplate();
  unreserved1.setGloballyUniqueIdentifier("abs");
  unreserved1.addContextSpecificData(id: "01", value: "qw12");
  unreserved1.addContextSpecificData(id: "02", value: "qw12");
  emv.addUnreservedTemplate(id: "89", value: unreserved1);

  // encode data
  final emvEncode = EMVMPM.encode(emv);
  print("result -------> ${emvEncode.toJson()}");
  // result -------> {emvqr: 00020001021203200002IT0103abc0203def04200002IT0103abc0203def625201050qwea1006tax id1103cha1202001302135003123510312364410002LA0102MW0209Vientaine0304asfg0404asfg6503bbc6603bbb89230003abs0104qw120204qw126304735A, error: null}

  /**
   * decode emv qr code
   */
  final emvqrcode =
      "00020001021203200002IT0103abc0203def04200002IT0103abc0203def625201050qwea1006tax id1103cha1202001302135003123510312364410002LA0102MW0209Vientaine0304asfg0404asfg6503bbc6603bbb89230003abs0104qw120204qw126304735A";
  final emvDecode = EMVMPM.decode(emvqrcode);
  print("result -------> ${emvDecode.toJson()}");

  /**
   * decode wrong emv qr code
   * 
   * check crc checksum qr code
   */
  String emvQrcode =
      "00020101021138670016A00526628466257701082771041802030010324ZPOSUALNJBWWVYSEIRIESGFE6304D1B9";
  // verify emvqr
  final verified = verifyMPMEmvCo(emvQrcode);
  print("result ------> $verified");

  /**
   * decode not emv qr code
   */
  String notEmvQrcode = "https://laoitdev.com";
  final notEmvDecode = EMVMPM.decode(notEmvQrcode);
  print("result ------> ${notEmvDecode.toJson()}");
  //result ------> {emvqr: null, error: {type: EmvErrorType.verifyqrErr, message: The emv data was wrong}}

// ---------- CPM QRcode -------------------//

  final qr = CPMQR();

  qr.setDataPayloadFormatIndicator("CPV01");

  final appTemplate1 = ApplicationTemplate();
  appTemplate1.setBerTvl(
    dataApplicationDefinitionFileName: "A0000000555555",
    dataApplicationLabel: "Product1",
  );
  qr.addApplicationTemplate(appTemplate1);

  final appTemplate2 = ApplicationTemplate();
  appTemplate2.setBerTvl(
      dataApplicationDefinitionFileName: "A0000000666666",
      dataApplicationLabel: "Product2");
  qr.addApplicationTemplate(appTemplate2);

  final cdt = CommonDataTemplate();
  cdt.setBerTvl(
    dataApplicationPan: "1234567890123458",
    dataCardholderName: "CARDHOLDER/EMV",
    dataLanguagePreference: "ruesdeen",
  );
  cdt.addCommonDataTransparentTemplates(
    dataIssuerApplicationData: '06010A03000000',
    dataApplicationCryptogram: "584FD385FA234BCC",
    dataApplicationTransactionCounter: "0001",
    dataUnpredictableNumber: "6D58EF13",
  );
  qr.addCommonDataTemplate(cdt);

  final cpm = EMVCPM();

  // generate cpm emvCo
  final value = cpm.generatePayload(qr);

  print("cpm emvCo -------> $value");
}
