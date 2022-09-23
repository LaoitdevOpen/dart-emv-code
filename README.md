# a dart package for decode and encode EMVCO

[![Dart](https://github.com/LaoitdevOpen/dart-emv-code/actions/workflows/dart.yml/badge.svg)](https://github.com/LaoitdevOpen/dart-emv-code/actions/workflows/dart.yml)

> information about EMVCO
> [www.emvco.com](https://www.emvco.com/)

## Usage

## Install

Run this command:

```cmd

// flutter
$> flutter pub add emvqrcode

// or for dart
$> dart pub add emvqrcode

```

pubspec.yaml:

```yaml
dependencies:
  emvqrcode: ^1.0.5
```

### MPM

#### Decode

```dart
    cost emvqr = "00020001021203200002IT0103abc0203def04200002IT0103abc0203def624601050qwea1006tax id1103cha1202135003123510312364410002LA0102MW0209Vientaine0304asfg0404asfg6503bbc6603bbb89230003abs0104qw120204qw1281230003sdf0504ffff0604ffff63042E4E";
    final emvdecode = EMVMPM.decode(emvqr);

    // print decode json model
    debugPrint("emv decode ------> ${emvdecode.toJson()}");
```

#### Generate

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

    // print encode json model
    debugPrint("emv encode -------> ${emvEncode.toJson()}");

    
    // {emvqr: 00020001021203200002IT0103abc0203def04200002IT0103abc0203def625201050qwea1006tax id1103cha1202001302135003123510312364410002LA0102MW0209Vientaine0304asfg0404asfg6503bbc6603bbb89230003abs0104qw120204qw126304735A, error: null}
```

### Verify CRC EMVCO

if you need to verify whether data in emvCo had changed or not you can use this method.

```dart

    final wrongData =
        "00020101021138670016A00526628466257701082771041802030010324ZPOSUALNJBWWVYSEIRIESGFE6304D1B9";

    // verify emvqr
    final verified = verifyEmvQr(wrongData);

    if(verified) {
        debugPrint("emvCo corrected}");
    }else {
        debugPrint("emvCo incorrect}");
    }

```

## CPM

### Generate

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
