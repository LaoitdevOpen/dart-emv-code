a flutter plugin for decode and genrate emv-mpm qrcode

<hr>

## Usage

#### Decode func
```dart
    final emvdecode = EMVMPM.decode(emvqr);
    debugPrint("emv decode ------> ${emvdecode.toJson()}");
```

#### Generate func
```dart
    final emv = EMVQR();

    emv.setPayloadFormatIndicator("00");
    emv.setPointOfInitiationMethod("12");

    /// merchant account information
    final mcAccountInfo = MerchantAccountInformation();
    mcAccountInfo.setGloballyUniqueIdentifier("IT");
    mcAccountInfo.addPaymentNetworkSpecific(id: "01", value: "abc");
    mcAccountInfo.addPaymentNetworkSpecific(id: "02", value: "def");
    emv.addMerchantAccountInformation(id: "03", value: mcAccountInfo);

    final additionalData = AdditionalDataFieldTemplate();
    additionalData.setBillNumber("aaaa");
    additionalData.setMerchantTaxID("111");
    additionalData.setMerchantChannel("cha");
    additionalData.addRfuForEMVCo(id: "12", value: "00");
    additionalData.addPaymentSystemSpecific(id: "50", value: "123");
    additionalData.addPaymentSystemSpecific(id: "51", value: "123");
    emv.setAdditionalDataFieldTemplate(additionalData);

   
    final mcInfoLang = MerchantInformationLanguageTemplate();
    mcInfoLang.setLanguagePreferencer("LA");
    mcInfoLang.setMerchantCity("Vientaine");
    mcInfoLang.setMerchantName("MW");
    mcInfoLang.addRfuForEMVCo(id: "03", value: "asfg");
    mcInfoLang.addRfuForEMVCo(id: "04", value: "asfg");
    emv.setMerchantInformationLanguageTemplate(mcInfoLang);

    emv.addRfuForEMVCo(id: "66", value: "bbb");

    final unreserved = UnreservedTemplate();
    unreserved.setGloballyUniqueIdentifier("abs");
    unreserved.addContextSpecificData(id: "01", value: "qw12");
    emv.addUnreservedTemplate(id: "89", value: unreserved);

    debugPrint("emv body ----------> ${emv.value.toJson()}");

    final emvEncode = EMVMPM.encode(emv);
    debugPrint("emv encode -------> ${emvEncode.toJson()}");
```
<hr>

#### add Merchant Account Information function
```dart
    final mcAccountInfo = MerchantAccountInformation();
```

####add Additional Data Field Template function
```dart
    final additionalData = AdditionalDataFieldTemplate();
```

#### add Merchant Information Language Template function
```dart
    final mcInfoLang = MerchantInformationLanguageTemplate();
```
#### add Unreserved Template function
```dart
    final unreserved = UnreservedTemplate();
```
## Credits 

 <li>https://github.com/dongri/emv-qrcode</li>