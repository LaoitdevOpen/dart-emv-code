// import 'package:flutter_test/flutter_test.dart';

// import 'package:emvqrcode/emvqrcode.dart';

// void main() {

//   test("decode emv code", () {
//     const emvCode =
//         "00020101021229280007D1234561313123123456789031310007M1234560416123456789012345652041111530339254071000.005802LA6009Vientaine630486AC";
//     final decoded = emvQRDeCode(emvCode);
//     print("emvcode ------------->${decoded.emvqr?.toJson()}");
//     print("error ------------->${decoded.error?.toJson()}");

//     //
//     final emvqr = decoded.emvqr;

//     // merchant account info
//     emvqr?.merchantAccountInformation?.forEach((key, value) {
//       final merchant = value.value;
//       print("merchant -------> $key");
//       print(merchant?.globallyUniqueIdentifier?.value);

//       merchant?.paymentNetworkSpecific?.forEach((element) {
//         print(element.value);
//       });
//     });
//     // get merchant by id
//     final merchant = emvqr?.merchantAccountInformation?.entries
//         .firstWhere((element) => element.key == "31");
//     print("merchant -------> ${merchant?.key}");
//     print(merchant?.value.value?.toJson());

//     // addtionnal data
//     final additionalData = emvqr?.additionalDataFieldTemplate;
//     print("additional data -------> ");
//     print(additionalData?.billNumber?.value);
//     print(additionalData?.mobileNumber?.value);

//     // RFU for emv co
//     prints("RFU for emv co -------> ");
//     emvqr?.rfuForEmvCo?.forEach((element) {
//       prints(element.value);
//     });
//   });

//   test("generate emvqr :", () {
//     ///set emv value
//     ///
//     // payloadLoadFormat
//     var payloadFormat = ParseEMVQR().setTLV("01", ID.payloadFormatIndicator);
//     // point of initiation method
//     var pointOfInit = ParseEMVQR().setTLV("12", ID.pointOfInitiationMethod);
//     // merchant
//     var merchantInfo1 = MerchantAccountInformationValue(
//         globallyUniqueIdentifier: ParseEMVQR().setTLV(
//             "D123456", MerchantAccountInformationID.globallyUniqueIdentifier),
//         paymentNetworkSpecific: [ParseEMVQR().setTLV("1231234567890", "13")]);
//     var merchantInfo2 = MerchantAccountInformationValue(
//         globallyUniqueIdentifier: ParseEMVQR().setTLV(
//             "M123456", MerchantAccountInformationID.globallyUniqueIdentifier),
//         paymentNetworkSpecific: [
//           ParseEMVQR().setTLV("1234567890123456", "04")
//         ]);
//     // merchant category code
//     var merchantCategory =
//         ParseEMVQR().setTLV("1111", ID.merchantCategoryCode);
//     // transaction currency
//     var transactionCurrency =
//         ParseEMVQR().setTLV("392", ID.transactionCurrency);
//     // transaction amount
//     var transactionAmount =
//         ParseEMVQR().setTLV("1000.00", ID.transactionAmount);
//     // country code
//     final countryCode = ParseEMVQR().setTLV("LA", ID.countryCode);
//     // merchant name
//     var merchantName = ParseEMVQR().setTLV("KAk MOoo", ID.merchantName);
//     // merchant city
//     var merchantCity = ParseEMVQR().setTLV("Vientaine", ID.merchantCity);

//     // emv data
//     var emvData = EMVQR(
//       payloadFormatIndicator: payloadFormat,
//       pointOfInitiationMethod: pointOfInit,
//       merchantAccountInformation: {
//         "29": ParseEMVQR().addMerchantAccountInformation("29", merchantInfo1),
//         "31": ParseEMVQR().addMerchantAccountInformation("31", merchantInfo2)
//       },
//       merchantCategoryCode: merchantCategory,
//       transactionCurrency: transactionCurrency,
//       transactionAmount: transactionAmount,
//       countryCode: countryCode,
//       merchantName: merchantName,
//       merchantCity: merchantCity,
//     );

//     final emvqr = ParseEMVQR().generatePayload(emvData);
//     print("value----> ${emvqr.toJson()}");
//   });
// }
