import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/mpm/set_emv_data_helper/additional_data_field_template.dart';
import 'package:emvqrcode/src/mpm/set_emv_data_helper/merchant_account_information.dart';
import 'package:emvqrcode/src/mpm/set_emv_data_helper/merchant_information_langage_template.dart';
import 'package:emvqrcode/src/mpm/set_emv_data_helper/set_emv_info.dart';
import 'package:emvqrcode/src/mpm/set_emv_data_helper/unreserved_template.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("set emv value", () {
    // 00 02 00
    // 01 02 12
    // 03 20
    // 00 02 IT
    // 01 03 abc
    // 02 03 def
    // 04 20
    // 00 02 IT
    // 01 03 abc
    // 02 03 def
    //#addtionalData
    // 62 28
    // 01 05 0qwea //9
    // 11 02 00
    // 12 02 13
    // 50 03 123 //7
    // 64 33
    // 00 02 LA
    // 01 02 MW
    // 02 09 Vientaine
    // 03 04 asfg
    // 65 03 bbc
    // 89 15
    // 00 03 abs
    // 01 04 qw12
    //81 15
    //00 03 sdf
    //05 04 ffff
    // 63 04 DC02

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
    additionalData.addRfuForEMVCo(id: "11", value: "00");
    additionalData.addRfuForEMVCo(id: "12", value: "13");
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

    final unreserved2 = UnreservedTemplate();
    unreserved2.setGloballyUniqueIdentifier("sdf");
    unreserved2.addContextSpecificData(id: "05", value: "ffff");
    unreserved2.addContextSpecificData(id: "06", value: "ffff");
    emv.addUnreservedTemplate(id: "81", value: unreserved2);

    // crc
    // 63 04 3502

    print("emv body ----------> ${emv.value.toJson()}");

    final emvEncode = EMVMPM.encode(emv);
    print("emv encode -------> ${emvEncode.toJson()}");

    final emvdecode = EMVMPM.decode(
        "0f020001021203200002IT0103abc0203def04200002IT0103abc0203def624601050qwea1006tax id1103cha1202135003123510312364410002LA0102MW0209Vientaine0304asfg0404asfg6503bbc6603bbb89230003abs0104qw120204qw1281230003sdf0504ffff0604ffff63042E4E");
    print("emv decode ------> ${emvdecode.toJson()}");
  });
}
