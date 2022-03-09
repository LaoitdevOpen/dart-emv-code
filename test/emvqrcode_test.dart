import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/models/set_tlv_model.dart';
import 'package:emvqrcode/src/mpm/set_emv_info/additional_data_field_template.dart';
import 'package:emvqrcode/src/mpm/set_emv_info/merchant_account_information.dart';
import 'package:emvqrcode/src/mpm/set_emv_info/merchant_information_langage_template.dart';
import 'package:emvqrcode/src/mpm/set_emv_info/rfu_for_emv_co.dart';
import 'package:emvqrcode/src/mpm/set_emv_info/unreserved_template.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Set emv value", () {
    final additionData = SetAdditionalDataFieldTemplate();
    additionData.setBillNumber("0qwea");
    additionData.setRfuForEMVCo([
      // id: 10 -> 49
      SetTlvModel(id: "11", value: "value"),
    ]);
    additionData.setPaymentSystemSpecific([
      // id: 50 -> 99
      SetTlvModel(id: "50", value: "value"),
      SetTlvModel(id: "70", value: "asd")
    ]);

    final mAccountInfo = SetMerchantAccountInformation();
    // merchant id: 02 -> 51
    mAccountInfo.addMerchantAccountInformation(
        id: "02",
        globallyUniqueIdentifierValue: "qwer",
        paymentNetworkSpecificValue: [
          // id: 01 -> 99
          SetTlvModel(id: "01", value: "asdf"),
          SetTlvModel(id: "02", value: "asdfg")
        ]);

    final unreserved = SetUnreservedTemplate();
    // unreserved id: 01 -> 99
    unreserved.setUnreservedTemplates(
      id: "89",
      globallyUniqueIdentifierValue: "qwer",
      contextSpecificDataValue: [
        // id: 01 -> 99
        SetTlvModel(id: "01", value: "value"),
      ],
    );

    final mInfoLang = SetMerchantInformationLangageTemplate();
    mInfoLang.setLanguagePreferencer("asdf");
    mInfoLang.setMerchantCity("asfg");
    mInfoLang.setMerchantName("qwer");
    mInfoLang.setRfuForEMVCo([
      // id: 03 -> 99
      SetTlvModel(id: "65", value: "asdf"),
    ]);

    final rfu = setRfuForEMVCo([
      // id: 80 -> 99
      SetTlvModel(id: "65", value: "asdf"),
      SetTlvModel(id: "72", value: "asdfg")
    ]);

    final emv = setEMVData(
      payloadFormatIndicator: "01",
      pointOfInitiationMethod: "12",
      countryCode: "856",
      additionalDataFieldTemplate: additionData.value,
      merchantAccountInformation: {"02": mAccountInfo.value},
      unreservedTemplates: {
        "89": unreserved.value,
      },
      merchantInformationLanguageTemplate: mInfoLang.value,
      rfuForEmvCo: rfu,
    );
    print(emv.toJson());
  });
  // test("merchant account information", () {
  //   final info1 = SetMerchantAccountInformation();
  //   info1.addMerchantAccountInformation("02", "qwer", [
  //     SetTlvModel(id: "01", value: "asdf"),
  //     SetTlvModel(id: "02", value: "asdfg")
  //   ]);

  //   final info2 = SetMerchantAccountInformation();
  //   info2.addMerchantAccountInformation("01", "qwer", [
  //     SetTlvModel(id: "03", value: "asdf"),
  //     SetTlvModel(id: "05", value: "asdfg")
  //   ]);

  //   print("info3 -------> ${info1.value.toJson()}");
  //   print("info2 -------> ${info2.value.toJson()}");
  // });

  // test("merchant information language template", () {
  //   final info1 = SetMerchantInformationLangageTemplate();
  //   info1.setLanguagePreferencer("asdf");
  //   info1.setMerchantCity("asfg");
  //   info1.setMerchantName("qwer");
  // });

  // test("Additional data field", () {
  //   final additionData = SetAdditionalDataFieldTemplate();
  //   additionData.setBillNumber("0qwea");
  //   additionData.setRfuForEMVCo([SetTlvModel(id: "00", value: "value")]);
  //   additionData.setPaymentSystemSpecific([
  //     SetTlvModel(id: "00", value: "value"),
  //     SetTlvModel(id: "02", value: "asd")
  //   ]);

  //   print(additionData.value.toJson());
  // });

  // test("unreserved template", () {
  //   final unreserved = SetUnreservedTemplate();

  //   unreserved.setUnreservedTemplates(
  //     "89",
  //     "qwer",
  //     [SetTlvModel(id: "01", value: "value")],
  //   );

  //   print(unreserved.value.toJson());
  // });

  // test("decode emv code", () {
  //   const emvCode =
  //       "00020101021229280007D1234561313123123456789031310007M1234560416123456789012345652041111530339254071000.005802LA6009Vientaine630486AC";
  //   final decoded = EMVMPM.decode(emvCode);
  //   print("emvcode ------------->${decoded.emvqr?.toJson()}");
  //   print("error ------------->${decoded.error?.toJson()}");

  //   //
  //   final emvqr = decoded.emvqr;

  //   // merchant account info
  //   emvqr?.merchantAccountInformation?.forEach((key, value) {
  //     final merchant = value.value;
  //     print("merchant -------> $key");
  //     print(merchant?.globallyUniqueIdentifier?.value);

  //     merchant?.paymentNetworkSpecific?.forEach((element) {
  //       print(element.value);
  //     });
  //   });
  //   // get merchant by id
  //   final merchant = emvqr?.merchantAccountInformation?.entries
  //       .firstWhere((element) => element.key == "31");
  //   print("merchant -------> ${merchant?.key}");
  //   print(merchant?.value.value?.toJson());

  //   // addtionnal data
  //   final additionalData = emvqr?.additionalDataFieldTemplate;
  //   print("additional data -------> ");
  //   print(additionalData?.billNumber?.value);
  //   print(additionalData?.mobileNumber?.value);

  //   // RFU for emv co
  //   prints("RFU for emv co -------> ");
  //   emvqr?.rfuForEmvCo?.forEach((element) {
  //     prints(element.value);
  //   });
  // });

  // test("generate emvqr :", () {
  //   ///set emv value
  //   ///
  //   // payloadLoadFormat
  //   var payloadFormat = ParseEMVQR().setTLV("01", ID.payloadFormatIndicator);
  //   // point of initiation method
  //   var pointOfInit = ParseEMVQR().setTLV("12", ID.pointOfInitiationMethod);
  //   // merchant
  //   var merchantInfo1 = MerchantAccountInformationValue(
  //       globallyUniqueIdentifier: ParseEMVQR().setTLV(
  //           "D123456", MerchantAccountInformationID.globallyUniqueIdentifier),
  //       paymentNetworkSpecific: [ParseEMVQR().setTLV("1231234567890", "13")]);
  //   var merchantInfo2 = MerchantAccountInformationValue(
  //       globallyUniqueIdentifier: ParseEMVQR().setTLV(
  //           "M123456", MerchantAccountInformationID.globallyUniqueIdentifier),
  //       paymentNetworkSpecific: [
  //         ParseEMVQR().setTLV("1234567890123456", "04")
  //       ]);
  //   // merchant category code
  //   var merchantCategory =
  //       ParseEMVQR().setTLV("1111", ID.merchantCategory);
  //   // transaction currency
  //   var transactionCurrency =
  //       ParseEMVQR().setTLV("392", ID.transactionCurrency);
  //   // transaction amount
  //   var transactionAmount =
  //       ParseEMVQR().setTLV("1000.00", ID.transactionAmount);
  //   // country code
  //   final countryCode = ParseEMVQR().setTLV("LA", ID.countryCode);
  //   // merchant name
  //   var merchantName = ParseEMVQR().setTLV("KAk MOoo", ID.merchantName);
  //   // merchant city
  //   var merchantCity = ParseEMVQR().setTLV("Vientaine", ID.merchantCity);

  //   // emv data
  //   var emvData = EMVQR(
  //     payloadFormatIndicator: payloadFormat,
  //     pointOfInitiationMethod: pointOfInit,
  //     merchantAccountInformation: {
  //       "29": ParseEMVQR().addMerchantAccountInformation("29", merchantInfo1),
  //       "31": ParseEMVQR().addMerchantAccountInformation("31", merchantInfo2)
  //     },
  //     merchantCategoryCode: merchantCategory,
  //     transactionCurrency: transactionCurrency,
  //     transactionAmount: transactionAmount,
  //     countryCode: countryCode,
  //     merchantName: merchantName,
  //     merchantCity: merchantCity,
  //   );

  //   var emvqr = EMVMPM.encode(emvData);
  //   print("value----> ${emvqr.toJson()}");
  // });
}
