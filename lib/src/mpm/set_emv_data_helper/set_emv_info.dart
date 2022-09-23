import '../../../emvqrcode.dart';
import '../../constants/emv_id.dart';
import '../../errors/set_emv_value_err.dart';

/// set emv value
class EMVQR {
  late EmvqrModel value = EmvqrModel();

  /// Set payload format inficator
  ///
  /// [value] is only No.
  /// length of [value] is 2.
  setPayloadFormatIndicator(String? value) {
    if (value != null) {
      if (value.length != 2) {
        throw ValueLengthErr(title: "PayloadFormatIndicator", length: "2");
      }
      var payloadFormatIndicator = setTLV(value, ID.payloadFormatIndicator);
      this.value =
          this.value.copyWith(payloadFormatIndicator: payloadFormatIndicator);
    }
  }

  /// set point of initiation method
  ///
  /// [value] is only No.
  /// length of [value] is 2.
  setPointOfInitiationMethod(String? value) {
    if (value != null) {
      if (value.length != 2) {
        throw ValueLengthErr(title: "PointOfInitiationMethod", length: "2");
      }
      var pointOfInitiationMethod = setTLV(value, ID.pointOfInitiationMethod);
      this.value =
          this.value.copyWith(pointOfInitiationMethod: pointOfInitiationMethod);
    }
  }

  /// set merchant category code
  ///
  /// [value] is only No.
  /// length of [value] is 4.
  setMerchantCategoryCode(String? value) {
    if (value != null) {
      if (value.length != 4) {
        throw ValueLengthErr(title: "MerchantCategoryCode", length: "4");
      }
      var merchantCategoryCode = setTLV(value, ID.merchantCategoryCode);
      this.value =
          this.value.copyWith(merchantCategoryCode: merchantCategoryCode);
    }
  }

  /// set transaction currency
  ///
  /// [value] is only No.
  /// length of [value] is 3.
  setTransactionCurrency(String? value) {
    if (value != null) {
      if (value.length != 3) {
        throw ValueLengthErr(title: "MerchantCategoryCode", length: "3");
      }
      var transactionCurrency = setTLV(value, ID.transactionCurrency);
      this.value =
          this.value.copyWith(transactionCurrency: transactionCurrency);
    }
  }

  /// set transaction amount
  ///
  /// length limit of [value] is 1 up to 13.
  setTransactionAmount(String? value) {
    if (value != null) {
      if (value.length > 13) {
        throw MaxValueLengthErr(title: "transactionAmount", length: "13");
      }
      var transactionAmount = setTLV(value, ID.transactionAmount);
      this.value = this.value.copyWith(transactionAmount: transactionAmount);
    }
  }

  /// set tip or convenience indicator
  ///
  /// [value] is only No.
  /// length of [value] is 2.
  setTipOrConvenienceIndicator(String? value) {
    if (value != null) {
      if (value.length != 2) {
        throw ValueLengthErr(title: "tipOrConvenienceIndicator", length: "2");
      }
      var tipOrConvenienceIndicator =
          setTLV(value, ID.tipOrConvenienceIndicator);
      this.value = this
          .value
          .copyWith(tipOrConvenienceIndicator: tipOrConvenienceIndicator);
    }
  }

  /// set Value Of Convenience Fee Fixed
  ///
  /// length limit of [value] is 1 up to 13.
  setValueOfConvenienceFeeFixed(String? value) {
    if (value != null) {
      if (value.length > 13) {
        throw MaxValueLengthErr(
            title: "valueOfConvenienceFeeFixed", length: "13");
      }
      var valueOfConvenienceFeeFixed =
          setTLV(value, ID.valueOfConvenienceFeeFixed);
      this.value = this
          .value
          .copyWith(valueOfConvenienceFeeFixed: valueOfConvenienceFeeFixed);
    }
  }

  /// set value of convenience fee percentage
  ///
  /// length limit of [value] is 1 up to 5.
  setValueOfConvenienceFeePercentage(String? value) {
    if (value != null) {
      if (value.length > 5) {
        throw MaxValueLengthErr(
            title: "valueOfConvenienceFeePercentage", length: "5");
      }
      var valueOfConvenienceFeePercentage =
          setTLV(value, ID.valueOfConvenienceFeePercentage);
      this.value = this.value.copyWith(
          valueOfConvenienceFeePercentage: valueOfConvenienceFeePercentage);
    }
  }

  /// set country code
  ///
  /// length of [value] is 2.
  setCountryCode(String? value) {
    if (value != null) {
      if (value.length != 2) {
        throw ValueLengthErr(title: "countryCode", length: "2");
      }
      var countryCode = setTLV(value, ID.countryCode);
      this.value = this.value.copyWith(countryCode: countryCode);
    }
  }

  /// set merchant name
  ///
  /// length limit of [value] is 1 up to 25.
  setMerchantName(String? value) {
    if (value != null) {
      if (value.length > 25) {
        throw MaxValueLengthErr(title: "merchantName", length: "25");
      }
      var merchantName = setTLV(value, ID.merchantName);
      this.value = this.value.copyWith(merchantName: merchantName);
    }
  }

  /// set merchant city
  ///
  /// length limit of [value] is 1 up to 15.
  setMerchantCity(String? value) {
    if (value != null) {
      if (value.length > 15) {
        throw MaxValueLengthErr(title: "merchantCity", length: "15");
      }
      var merchantCity = setTLV(value, ID.merchantCity);
      this.value = this.value.copyWith(merchantCity: merchantCity);
    }
  }

  /// set postal code
  ///
  /// length limit of [value] is 1 up to 10.
  setPostalCode(String? value) {
    if (value != null) {
      if (value.length <= 10) {
        var postalCode = setTLV(value, ID.postalCode);
        this.value = this.value.copyWith(postalCode: postalCode);
      } else {
        throw MaxValueLengthErr(title: "PostalCode", length: "10");
      }
    }
  }

  /// set merchant account information
  ///
  /// merchant account information is map type.
  /// u can add more than one item.
  /// [id] id No. is "02" up to "51".
  addMerchantAccountInformation(
      {String? id, MerchantAccountInformation? value}) {
    if (id != null && value != null) {
      if (int.parse(id) < int.parse(ID.merchantAccountInformationRangeStart) ||
          int.parse(id) > int.parse(ID.merchantAccountInformationRangeEnd)) {
        // this.value = this.value.copyWith(unreservedTemplates: {});
        throw InvalidId(title: "MerchantAccountInformation");
      }
      String _globally =
          "${value.value.globallyUniqueIdentifier?.tag}${value.value.globallyUniqueIdentifier?.length}${value.value.globallyUniqueIdentifier?.value}";
      String _payment = "";
      value.value.paymentNetworkSpecific?.forEach((element) {
        _payment += "${element.tag}${element.length}${element.value}";
      });

      MerchantAccountInformationModel mTLV = MerchantAccountInformationModel(
          tag: id,
          length: getValueLength(_globally + _payment),
          value: value.value);

      // add merchant account info
      if (this.value.merchantAccountInformation != null) {
        this.value.merchantAccountInformation?[id] = mTLV;
      } else {
        this.value =
            this.value.copyWith(merchantAccountInformation: {id: mTLV});
      }
    }
  }

  /// set additional data field template
  ///
  /// /// [value] is AdditionalDataFieldTemplate()
  setAdditionalDataFieldTemplate(AdditionalDataFieldTemplate? value) {
    if (value != null) {
      String billNumber = tlvToString(value.value.billNumber);
      String mobileNumber = tlvToString(value.value.mobileNumber);
      String storeLabel = tlvToString(value.value.storeLabel);
      String loyaltyNumber = tlvToString(value.value.loyaltyNumber);
      String referenceLabel = tlvToString(value.value.referenceLabel);
      String customerLabel = tlvToString(value.value.customerLabel);
      String terminalLabel = tlvToString(value.value.terminalLabel);
      String purposeTransaction = tlvToString(value.value.purposeTransaction);
      String additionalConsumerDataRequest =
          tlvToString(value.value.additionalConsumerDataRequest);
      String merchantTaxId = tlvToString(value.value.merchantTaxId);
      String merchantChannel = tlvToString(value.value.merchantChannel);

      String rfuForEMVCo = "";
      value.value.rfuForEMVCo?.forEach((element) {
        rfuForEMVCo += tlvToString(element);
      });

      String paymentSystemSpecific = "";
      value.value.paymentSystemSpecific?.forEach((element) {
        paymentSystemSpecific += tlvToString(element);
      });
      String length = getValueLength(billNumber +
          mobileNumber +
          storeLabel +
          loyaltyNumber +
          referenceLabel +
          customerLabel +
          terminalLabel +
          purposeTransaction +
          additionalConsumerDataRequest +
          merchantTaxId +
          merchantChannel +
          rfuForEMVCo +
          paymentSystemSpecific);

      AdditionalDataFieldTemplateModel additionalDataFieldTemplate =
          AdditionalDataFieldTemplateModel(
              tag: ID.additionalDataFieldTemplate,
              length: length,
              value: value.value);
      this.value = this
          .value
          .copyWith(additionalDataFieldTemplate: additionalDataFieldTemplate);
    }
  }

  /// set merchant information langage template
  ///
  /// [value] is MerchantInformationLanguageTemplate()
  setMerchantInformationLanguageTemplate(
      MerchantInformationLanguageTemplate? value) {
    if (value != null) {
      String languagePreference = tlvToString(value.value.languagePreference);
      String merchantName = tlvToString(value.value.merchantName);
      String merchantCity = tlvToString(value.value.merchantCity);
      String rfuForEMVCo = "";
      value.value.rfuForEMVCo?.forEach((element) {
        rfuForEMVCo += tlvToString(element);
      });
      MerchantInformationLanguageTemplateModel merchantInfoLanguageTemplate =
          MerchantInformationLanguageTemplateModel(
              tag: ID.merchantInformationLanguageTemplate,
              length: getValueLength(languagePreference +
                  merchantName +
                  merchantCity +
                  rfuForEMVCo),
              value: value.value);
      this.value = this.value.copyWith(
          merchantInformationLanguageTemplate: merchantInfoLanguageTemplate);
    }
  }

  /// add rfu for emvcode
  ///
  /// RFU for EMVCo is list type.
  /// u can add more than one item.
  /// [id] id No. is "65" up to "79".
  /// max length of [value] is 99.
  addRfuForEMVCo({String? id, String? value}) {
    if (id != null && value != null) {
      if (int.parse(id) < int.parse(ID.rfuForEMVCoRangeStart) ||
          int.parse(id) > int.parse(ID.rfuForEMVCoRangeEnd)) {
        // this.value = this.value.copyWith(rfuForEmvCo: []);
        throw InvalidId(title: "RfuForEMVCo");
      }

      if (value.length > 99) {
        throw MaxValueLengthErr(title: "RFUFforEmvCo", length: "99");
      }

      if (this.value.rfuForEmvCo != null) {
        this.value.rfuForEmvCo?.add(setTLV(value, id));
      } else {
        List<TLVModel> tlv = [];
        tlv.add(setTLV(value, id));

        this.value = this.value.copyWith(rfuForEmvCo: tlv);
      }
    }
  }

  /// unreserved template
  ///
  /// unreserved template is map type.
  /// u can add more than one item.
  /// [id] id No. is "80" up to "99".
  addUnreservedTemplate({String? id, UnreservedTemplate? value}) {
    if (id != null && value != null) {
      if (int.parse(id) < int.parse(ID.unreservedTemplatesRangeStart) ||
          int.parse(id) > int.parse(ID.unreservedTemplatesRangeEnd)) {
        throw InvalidId(title: "UnreservedTemplate");
      }
      String _globally =
          "${value.value.globallyUniqueIdentifier?.tag}${value.value.globallyUniqueIdentifier?.length}${value.value.globallyUniqueIdentifier?.value}";
      String _payment = "";
      value.value.contextSpecificData?.forEach((element) {
        _payment += "${element.tag}${element.length}${element.value}";
      });

      UnreservedTemplateModel unreservedTemplate = UnreservedTemplateModel(
          tag: id,
          length: getValueLength(_globally + _payment),
          value: value.value);

      // add merchant account info
      if (this.value.unreservedTemplates != null) {
        this.value.unreservedTemplates?[id] = unreservedTemplate;
      } else {
        this.value =
            this.value.copyWith(unreservedTemplates: {id: unreservedTemplate});
      }
    }
  }
}
