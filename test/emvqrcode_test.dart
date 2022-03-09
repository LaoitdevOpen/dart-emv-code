import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/mpm/set_emv_info/additional_data_field_template.dart';
import 'package:emvqrcode/src/mpm/set_emv_info/merchant_account_information.dart';
import 'package:emvqrcode/src/mpm/set_emv_info/merchant_information_langage_template.dart';
import 'package:emvqrcode/src/mpm/set_emv_info/set_emv_info.dart';
import 'package:emvqrcode/src/mpm/set_emv_info/unreserved_template.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("set emv value", () {
    final emv = EMVQR();
    emv.setPayloadFormatIndicator("00");
    emv.setPointOfInitiationMethod("12");

    /// merchant account information
    final mAccountInfo = SetMerchantAccountInformationValue();
    mAccountInfo.setGloballyUniqueIdentifier("IT");
    mAccountInfo.setPaymentNetworkSpecific(id: "01", value: "abc");
    mAccountInfo.setPaymentNetworkSpecific(id: "02", value: "def");
    emv.addMerchantAccountInformation(id: "03", value: mAccountInfo.value);

    final mAccountInfo2 = SetMerchantAccountInformationValue();
    mAccountInfo2.setGloballyUniqueIdentifier("IT");
    mAccountInfo2.setPaymentNetworkSpecific(id: "01", value: "abc");
    mAccountInfo2.setPaymentNetworkSpecific(id: "02", value: "def");
    emv.addMerchantAccountInformation(id: "04", value: mAccountInfo2.value);

    final additionalData = SetAdditionalDataFieldTemplate();
    additionalData.setBillNumber("0qwea");
    additionalData.setRfuForEMVCo(id: "11", value: "00");
    additionalData.setRfuForEMVCo(id: "12", value: "13");
    additionalData.setPaymentSystemSpecific(id: "50", value: "0004hoge0104abcd");
    emv.setAdditionalDataFieldTemplate(additionalData.value);

    final mInfoLang = SetMerchantInformationLanguageTemplate();
    mInfoLang.setLanguagePreferencer("LA");
    mInfoLang.setMerchantCity("Vientaine");
    mInfoLang.setMerchantName("MW");
    mInfoLang.setRfuForEMVCo(id: "03",value: "asfg");
    emv.setMerchantInformationLanguageTemplate(mInfoLang.value);

    emv.setRfuForEMVCo(id: "65",value: "bbc");

    final unreserved1 = SetUnreservedTemplateValue();
    unreserved1.setGloballyUniqueIdentifier("abs");
    unreserved1.setContextSpecificData(id: "01",value: "qw12");
    emv.addUnreservedTemplate(id: "89",value: unreserved1.value);

    final unreserved2 = SetUnreservedTemplateValue();
    unreserved2.setGloballyUniqueIdentifier("sdf");
    unreserved2.setContextSpecificData(id: "05",value: "ffff");
    emv.addUnreservedTemplate(id: "81",value: unreserved2.value);
    print("emv body ----------> ${emv.value.toJson()}");

    final emvEncode = EMVMPM.encode(emv.value);
    print("emvcode -------> ${emvEncode.toJson()}");
  });
}
