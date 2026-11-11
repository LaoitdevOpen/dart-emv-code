# a dart package for decode and encode EMVCO

[![Dart](https://github.com/LaoitdevOpen/dart-emv-code/actions/workflows/dart.yml/badge.svg)](https://github.com/LaoitdevOpen/dart-emv-code/actions/workflows/dart.yml)

> information about EMVCO
> [www.emvco.com](https://www.emvco.com/)

## Requirements

Dart SDK `^3.8.0` or newer.

## Install

```cmd
// flutter
$> flutter pub add emvqrcode

// or for dart
$> dart pub add emvqrcode
```

pubspec.yaml:

```yaml
dependencies:
  emvqrcode: ^1.1.0
```

Then import it:

```dart
import 'package:emvqrcode/emvqrcode.dart';
```

## Usage

The package supports two kinds of EMV QR codes:

| Kind | Meaning | Format | Entry points |
| ---- | ------- | ------ | ------------ |
| MPM | Merchant-presented mode | TLV text with a CRC16 checksum | `EMVMPM.decode`, `EMVMPM.encode`, `verifyEmvQr` |
| CPM | Consumer-presented mode | BER-TLV, hex, then base64 | `EMVCPM().generatePayload` |

## MPM

### Quick start

```dart
final emv = EMVQR()
  ..setPayloadFormatIndicator("00")
  ..setPointOfInitiationMethod("12")
  ..setMerchantName("MW");

final encoded = EMVMPM.encode(emv);
print(encoded.value); // the QR payload, CRC included

final decoded = EMVMPM.decode(encoded.value!);
print(decoded.emvqr?.merchantName?.value); // MW
```

### Decode

`EMVMPM.decode` never throws on bad input. Check `error` before using `emvqr`.

```dart
const emvqr =
    "00020001021203200002IT0103abc0203def04200002IT0103abc0203def624601050qwea1006tax id1103cha1202135003123510312364410002LA0102MW0209Vientaine0304asfg0404asfg6503bbc6603bbb89230003abs0104qw120204qw1281230003sdf0504ffff0604ffff63042E4E";

final result = EMVMPM.decode(emvqr);

if (result.error != null) {
  print(result.error!.message); // for example: qrcode not emvCo type
} else {
  print(result.emvqr!.toJson());
}
```

### Generate

```dart
   final emv = EMVQR();


    emv.setPayloadFormatIndicator("00");

 
    emv.setPointOfInitiationMethod("12");


    /// merchant account information
    final mAccountInfo = MerchantAccountInformation();
    mAccountInfo.setGloballyUniqueIdentifier("IT");
    mAccountInfo.addPaymentNetworkSpecific(id: "01", value: "abc");
    mAccountInfo.addPaymentNetworkSpecific(id: "02", value: "def");
    emv.addMerchantAccountInformation(id: "03", value: mAccountInfo);

    /// merchant 2 account information
    final mAccountInfo2 = MerchantAccountInformation();
    mAccountInfo2.setGloballyUniqueIdentifier("IT");
    mAccountInfo2.addPaymentNetworkSpecific(id: "01", value: "abc");
    mAccountInfo2.addPaymentNetworkSpecific(id: "02", value: "def");
    emv.addMerchantAccountInformation(id: "04", value: mAccountInfo2);

  
    // Additional Field
    final additionalData = AdditionalDataFieldTemplate();
    additionalData.setBillNumber("0qwea");
    additionalData.setMerchantTaxID("tax id");
    additionalData.setMerchantChannel("cha");
    additionalData.addRfuForEMVCo(id: "12", value: "00");
    additionalData.addRfuForEMVCo(id: "13", value: "13");
    additionalData.addPaymentSystemSpecific(id: "50", value: "123");
    additionalData.addPaymentSystemSpecific(id: "51", value: "123");
    emv.setAdditionalDataFieldTemplate(additionalData);

    
    // merchant info language
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


    // encode data to emvCo
    final emvEncode = EMVMPM.encode(emv);

    // the payload string is in emvEncode.value, any error is in emvEncode.error
    debugPrint("emv encode -------> ${emvEncode.toJson()}");

    
    // {emvqr: 00020001021203200002IT0103abc0203def04200002IT0103abc0203def625201050qwea1006tax id1103cha1202001302135003123510312364410002LA0102MW0209Vientaine0304asfg0404asfg6503bbc6603bbb89230003abs0104qw120204qw126304735A, error: null}
```

#### Field rules and errors

The setters validate their input and **throw** when a rule is broken, so wrap
user-supplied values in `try`/`catch`.

| Field | Rule |
| ----- | ---- |
| `setPayloadFormatIndicator`, `setPointOfInitiationMethod`, `setTipOrConvenienceIndicator`, `setCountryCode` | exactly 2 characters |
| `setTransactionCurrency` | exactly 3 characters |
| `setMerchantCategoryCode` | exactly 4 characters |
| `setTransactionAmount`, `setValueOfConvenienceFeeFixed` | up to 13 characters |
| `setValueOfConvenienceFeePercentage` | up to 5 characters |
| `setMerchantName` | up to 25 characters |
| `setMerchantCity` | up to 15 characters |
| `setPostalCode` | up to 10 characters |
| `MerchantAccountInformation.setGloballyUniqueIdentifier` | up to 32 characters |
| any other value, and every template as a whole | up to 99 characters |

Ids are checked too: merchant account information `02`-`51`, RFU for EMVCo
`65`-`79`, unreserved templates `80`-`99`. An id outside its range throws.

```dart
try {
  emv.setCountryCode("LAO");
} catch (e) {
  print(e); // length of countryCode value must be 2
}
```

Lengths count characters, not UTF-8 bytes, as the EMV MPM spec requires, so a
name such as `最佳运输` has length `04`. The CRC is still computed over the UTF-8
bytes.

### Verify CRC EMVCO

`verifyEmvQr` returns `true` when the CRC matches the payload. It returns
`false`, and does not throw, for a wrong checksum, truncated or malformed TLV
input, or text that is too short.

```dart

    final wrongData =
        "00020101021138670016A00526628466257701082771041802030010324ZPOSUALNJBWWVYSEIRIESGFE6304D1B9";

    // verify emvqr
    final verified = verifyEmvQr(wrongData);

    if (verified) {
        debugPrint("emvCo correct");
    } else {
        debugPrint("emvCo incorrect");
    }

```

## CPM

### Generate

`EMVCPM().generatePayload` returns the base64 payload, or `null` when it cannot
build one.

```dart

    final qr = CPM();


    qr.setDataPayloadFormatIndicator("CPV01");

    final appTemplate1 = ApplicationTemplate();
    appTemplate1.setBerTvl(
      BerTvl(
          dataApplicationDefinitionFileName: "A0000000555555",
          dataApplicationLabel: "Product1"),
    );
    qr.addApplicationTemplate(appTemplate1);


    final appTemplate2 = ApplicationTemplate();
    appTemplate2.setBerTvl(BerTvl(
        dataApplicationDefinitionFileName: "A0000000666666",
        dataApplicationLabel: "Product2"));
    qr.addApplicationTemplate(appTemplate2);


    final cdt = CommonDataTemplate();
    cdt.setBerTvl(
      BerTvl(
          dataApplicationPan: "1234567890123458",
          dataCardholderName: "CARDHOLDER/EMV",
          dataLanguagePreference: "ruesdeen"),
    );
    cdt.addCommonDataTransparentTemplates(
      BerTvl(
        dataIssuerApplicationData: '06010A03000000',
        dataApplicationCryptogram: "584FD385FA234BCC",
        dataApplicationTransactionCounter: "0001",
        dataUnpredictableNumber: "6D58EF13",
      ),
    );
    qr.addCommonDataTemplate(cdt);

    final cpm = EMVCPM();

    // generate cpm emvCo
    final value = cpm.generatePayload(qr);

    debugPrint("cpm emvCo -------> $value");

    // cpm emvCo -------> hQVDUFYwMWETTwegAAAAVVVVUAhQcm9kdWN0MWETTwegAAAAZmZmUAhQcm9kdWN0MmJJWggSNFZ4kBI0WF8gDkNBUkRIT0xERVIvRU1WXy0IcnVlc2RlZW5kIZ8QBwYBCgMAAACfJghYT9OF+iNLzJ82AgABnzcEbVjvEw==

```

## TODO

+ add decode CPM
+ Re-write API generate CPM EMVCO

## Credits

+ [emv-qrcode](https://github.com/dongri/emv-qrcode)
