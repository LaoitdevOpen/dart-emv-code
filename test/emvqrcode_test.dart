import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/models/set_tlv_model.dart';
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

    final mAccountInfo = SetMerchantAccountInformation();
    mAccountInfo.addMerchantAccountInformation(
        id: "03",
        globallyUniqueIdentifierValue: "qwer",
        paymentNetworkSpecificValue: [
          // id: 01 -> 99
          SetTlvModel(id: "01", value: "asdf"),
          SetTlvModel(id: "02", value: "asdfg")
        ]);
    emv.setMerchantAccountInformation(mAccountInfo.value);

    final mAccountInfo2 = SetMerchantAccountInformation();
    mAccountInfo2.addMerchantAccountInformation(
        id: "04",
        globallyUniqueIdentifierValue: "qwer",
        paymentNetworkSpecificValue: [
          // id: 01 -> 99
          SetTlvModel(id: "05", value: "asdf"),
          SetTlvModel(id: "06", value: "asdfg")
        ]);
    emv.setMerchantAccountInformation(mAccountInfo2.value);

    final additionData = SetAdditionalDataFieldTemplate();
    additionData.setBillNumber("0qwea");
    additionData.setRfuForEMVCo([
      // id: 10 -> 49
      SetTlvModel(id: "11", value: "dhdf"),
    ]);
    emv.setAdditionalDataFieldTemplate(additionData.value);

    final mInfoLang = SetMerchantInformationLangageTemplate();
    mInfoLang.setLanguagePreferencer("asdf");
    mInfoLang.setMerchantCity("asfg");
    mInfoLang.setMerchantName("qwer");
    mInfoLang.setRfuForEMVCo([
      // id: 03 -> 99
      SetTlvModel(id: "65", value: "asdf"),
    ]);
    emv.setMerchantInformationLanguageTemplate(mInfoLang.value);

    emv.setRfuForEMVCo([
      // id: 65 -> 79
      SetTlvModel(id: "65", value: "asdf"),
      SetTlvModel(id: "70", value: "asdfg")
    ]);

    // unreserved id: 80 -> 99
    final unreserved1 = SetUnreservedTemplate();
    unreserved1.setUnreservedTemplates(
      id: "89",
      globallyUniqueIdentifierValue: "qwer",
      contextSpecificDataValue: [
        // id: 01 -> 99
        SetTlvModel(id: "01", value: "asdf"),
      ],
    );
    emv.setUnreservedTemplate(unreserved1.value);

    final unreserved2 = SetUnreservedTemplate();
    unreserved2.setUnreservedTemplates(
      id: "81",
      globallyUniqueIdentifierValue: "qwer",
      contextSpecificDataValue: [
        // id: 01 -> 99
        SetTlvModel(id: "01", value: "asdf"),
      ],
    );
    emv.setUnreservedTemplate(unreserved2.value);
    print("emv body ----------> ${emv.value.toJson()}");

    final emvEncode = EMVMPM.encode(emv.value);
    print("emvcode -------> ${emvEncode.toJson()}");
    
  });
}
