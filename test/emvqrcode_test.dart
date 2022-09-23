import 'package:emvqrcode/emvqrcode.dart';
import 'package:test/test.dart';

void main() {
  test(
    "encode emv code",
    () {
      final emvqr = EMVQR();
      // 00 02 01        // 00 02 01
      emvqr.setPayloadFormatIndicator("01");
      // 01 02 12        // 01 02 12
      emvqr.setPointOfInitiationMethod("12");
      // 29 28                    //
      //    00 07 D123456         //
      //    13 13 JCB1234567890   // 13 13 JCB1234567890
      final merchantAccountInformationJCB = MerchantAccountInformation();
      merchantAccountInformationJCB.setGloballyUniqueIdentifier("D123456");
      merchantAccountInformationJCB.addPaymentNetworkSpecific(
          id: "13", value: "JCB1234567890");
      emvqr.addMerchantAccountInformation(
          id: "29", value: merchantAccountInformationJCB);
      // 31 31                     //
      //    00 07 M123456          //
      //    04 16 MASTER1234567890 // 04 16 MASTER1234567890
      final merchantAccountInformationMaster = MerchantAccountInformation();
      merchantAccountInformationMaster.setGloballyUniqueIdentifier("M123456");
      merchantAccountInformationMaster.addPaymentNetworkSpecific(
          id: "04", value: "MASTER1234567890");
      emvqr.addMerchantAccountInformation(
          id: "31", value: merchantAccountInformationMaster);
      // 52 04 5311      // 52 04 5311
      emvqr.setMerchantCategoryCode("5311");
      // 53 03 392       // 53 03 392
      emvqr.setTransactionCurrency("392");
      // 54 07 999.123   // 54 07 999.123
      emvqr.setTransactionAmount("999.123");
      // 58 02 JP        // 58 02 JP
      emvqr.setCountryCode("JP");
      // 59 06 DONGRI    // 59 06 DONGRI
      emvqr.setMerchantName("DONGRI");
      // 60 05 TOKYO     // 60 05 TOKYO
      emvqr.setMerchantCity("TOKYO");
      // 62 24           // 62 24
      //    01 04 hoge   //    01 04 hoge
      //    05 04 fuga   //    05 04 fuga
      //    07 04 piyo   //    07 04 piyo
      final additionalTemplate = AdditionalDataFieldTemplate();
      additionalTemplate.setBillNumber("hoge");
      additionalTemplate.setReferenceLabel("fuga");
      additionalTemplate.setTerminalLabel("piyo");
      emvqr.setAdditionalDataFieldTemplate(additionalTemplate);
      // 63 04 9599  // 63 04 C343
      final emvencode = EMVMPM.encode(emvqr);

      String data =
          "00020101021229280007D1234561313JCB123456789031310007M1234560416MASTER12345678905204531153033925407999.1235802JP5906DONGRI6005TOKYO62240104hoge0504fuga0704piyo63049599";

      expect(emvencode.value, data);
    },
  );
  test("set emv data & encode", () {
    final emv = EMVQR();

    // 00 02 00
    emv.setPayloadFormatIndicator("00");

    // 01 02 12
    emv.setPointOfInitiationMethod("12");

    // 03 20
    //00 02 IT
    //01 03 abc
    //02 03 def
    /// merchant account information
    final mAccountInfo = MerchantAccountInformation();
    mAccountInfo.setGloballyUniqueIdentifier("IT");
    mAccountInfo.addPaymentNetworkSpecific(id: "01", value: "abc");
    mAccountInfo.addPaymentNetworkSpecific(id: "02", value: "def");
    emv.addMerchantAccountInformation(id: "03", value: mAccountInfo);

    // 04 20
    // 00 02 IT
    // 01 03 abc
    // 02 03 def
    final mAccountInfo2 = MerchantAccountInformation();
    mAccountInfo2.setGloballyUniqueIdentifier("IT");
    mAccountInfo2.addPaymentNetworkSpecific(id: "01", value: "abc");
    mAccountInfo2.addPaymentNetworkSpecific(id: "02", value: "def");
    emv.addMerchantAccountInformation(id: "04", value: mAccountInfo2);

    // 01 05 0qwea // 9
    // 11 02 00 // 6
    // 12 02 13 // 6
    // 50 16 00 04 ho ge 01 04 ab cd//20
    final additionalData = AdditionalDataFieldTemplate();
    additionalData.setBillNumber("0qwea");
    additionalData.setMerchantTaxID("tax id");
    additionalData.setMerchantChannel("cha");
    additionalData.addRfuForEMVCo(id: "12", value: "00");
    additionalData.addRfuForEMVCo(id: "13", value: "13");
    additionalData.addPaymentSystemSpecific(id: "50", value: "123");
    additionalData.addPaymentSystemSpecific(id: "51", value: "123");
    emv.setAdditionalDataFieldTemplate(additionalData);

    // 00 02 LA
    // 01 02 MW
    // 02 09 Vi en ta in e //13
    // 03 04 as fg // 8
    final mInfoLang = MerchantInformationLanguageTemplate();
    mInfoLang.setLanguagePreferencer("LA");
    mInfoLang.setMerchantCity("Vientaine");
    mInfoLang.setMerchantName("MW");
    mInfoLang.addRfuForEMVCo(id: "03", value: "asfg");
    mInfoLang.addRfuForEMVCo(id: "04", value: "asfg");
    emv.setMerchantInformationLanguageTemplate(mInfoLang);

    // 65 03 bbc
    emv.addRfuForEMVCo(id: "65", value: "bbc");
    emv.addRfuForEMVCo(id: "66", value: "bbb");

    final unreserved1 = UnreservedTemplate();
    unreserved1.setGloballyUniqueIdentifier("abs");
    unreserved1.addContextSpecificData(id: "01", value: "qw12");
    unreserved1.addContextSpecificData(id: "02", value: "qw12");
    emv.addUnreservedTemplate(id: "89", value: unreserved1);

    // crc
    // 63 04 3502

    final emvEncode = EMVMPM.encode(emv);
    expect(emvEncode.value,
        "00020001021203200002IT0103abc0203def04200002IT0103abc0203def625201050qwea1006tax id1103cha1202001302135003123510312364410002LA0102MW0209Vientaine0304asfg0404asfg6503bbc6603bbb89230003abs0104qw120204qw126304735A");
  });

  test("decode emvCo", () {
    String data =
        "00020001021203200002IT0103abc0203def04200002IT0103abc0203def624601050qwea1006tax id1103cha1202135003123510312364410002LA0102MW0209Vientaine0304asfg0404asfg6503bbc6603bbb89230003abs0104qw120204qw1281230003sdf0504ffff0604ffff63042E4E";
    final emvdecode = EMVMPM.decode(data);

    expect(emvdecode.emvqr, isNotNull);
  });

  test("emvCo wrong crc", () {
    String wrongData =
        "00020101021138670016A00526628466257701082771041802030010324ZPOSUALNJBWWVYSEIRIESGFE6304D1B9";
    final emvdecode = verifyEmvQr(wrongData);

    expect(emvdecode, false);
  });
}
