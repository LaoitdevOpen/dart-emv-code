a flutter plugin for decode and genrate emv-mpm qrcode

<hr>

## Usage

Decode func
```dart
    final decoded = emvQRDeCode(emvCode);
    print("emvcode ------------->${decoded.emvqr?.toJson()}");
```

Generate func
```dart
    var payloadFormat = ParseEMVQR().setTLV("01", ID.payloadFormatIndicator);
    // point of initiation method
    var pointOfInit = ParseEMVQR().setTLV("12", ID.pointOfInitiationMethod);
    // merchant
    var merchantInfo1 = MerchantAccountInformationValue(
        globallyUniqueIdentifier: ParseEMVQR().setTLV(
            "D123456", MerchantAccountInformationID.globallyUniqueIdentifier),
        paymentNetworkSpecific: [ParseEMVQR().setTLV("1231234567890", "13")]);
    var merchantInfo2 = MerchantAccountInformationValue(
        globallyUniqueIdentifier: ParseEMVQR().setTLV(
            "M123456", MerchantAccountInformationID.globallyUniqueIdentifier),
        paymentNetworkSpecific: [
          ParseEMVQR().setTLV("1234567890123456", "04")
        ]);
    // merchant category code
    var merchantCategory =
        ParseEMVQR().setTLV("1111", ID.merchantCategoryCode);
    // transaction currency
    var transactionCurrency =
        ParseEMVQR().setTLV("392", ID.transactionCurrency);
    // transaction amount
    var transactionAmount =
        ParseEMVQR().setTLV("1000.00", ID.transactionAmount);
    // country code
    final countryCode = ParseEMVQR().setTLV("LA", ID.countryCode);
    // merchant name
    var merchantName = ParseEMVQR().setTLV("KAk MOoo", ID.merchantName);
    // merchant city
    var merchantCity = ParseEMVQR().setTLV("Vientaine", ID.merchantCity);

    // emv data
    var emvData = EMVQR(
      payloadFormatIndicator: payloadFormat,
      pointOfInitiationMethod: pointOfInit,
      merchantAccountInformation: {
        "29": ParseEMVQR().addMerchantAccountInformation("29", merchantInfo1),
        "31": ParseEMVQR().addMerchantAccountInformation("31", merchantInfo2)
      },
      merchantCategoryCode: merchantCategory,
      transactionCurrency: transactionCurrency,
      transactionAmount: transactionAmount,
      countryCode: countryCode,
      merchantName: merchantName,
      merchantCity: merchantCity,
    );

    final emvqr = ParseEMVQR().generatePayload(emvData);
    print("value----> ${emvqr.toJson()}");
```
<hr>

## Credits 

<li>https://github.com/dongri/emv-qrcode</li>