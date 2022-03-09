import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/models/additoinal_data_field_template.dart';
import 'package:emvqrcode/src/models/merchant_information_langage_template.dart';
import 'package:emvqrcode/src/models/set_tlv_model.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/models/unreserved_template.dart';

class EMVQR {
  late EmvqrModel value = EmvqrModel();

  ///set emv value
  ///
  // payloadLoadFormat
  setPayloadFormatIndicator(String? value) {
    if (value != null) {
      var payloadFormatIndicator = setTLV(value, ID.payloadFormatIndicator);
      this.value =
          this.value.copyWith(payloadFormatIndicator: payloadFormatIndicator);
    }
  }

  // point of initiation method
  setPointOfInitiationMethod(String? value) {
    if (value != null) {
      var pointOfInitiationMethod = setTLV(value, ID.pointOfInitiationMethod);
      this.value =
          this.value.copyWith(pointOfInitiationMethod: pointOfInitiationMethod);
    }
  }

  // merchant category code
  setMerchantCategoryCode(String? value) {
    if (value != null) {
      var merchantCategoryCode = setTLV(value, ID.merchantCategoryCode);
      this.value =
          this.value.copyWith(merchantCategoryCode: merchantCategoryCode);
    }
  }

  // transaction currency
  setTransactionCurrency(String? value) {
    if (value != null) {
      var transactionCurrency = setTLV(value, ID.transactionCurrency);
      this.value =
          this.value.copyWith(transactionCurrency: transactionCurrency);
    }
  }

  // transaction amount
  setTransactionAmount(String? value) {
    if (value != null) {
      var transactionAmount = setTLV(value, ID.transactionAmount);
      this.value = this.value.copyWith(transactionAmount: transactionAmount);
    }
  }

  // tip or convenience indicator
  setTipOrConvenienceIndicator(String? value) {
    if (value != null) {
      var tipOrConvenienceIndicator =
          setTLV(value, ID.tipOrConvenienceIndicator);
      this.value = this
          .value
          .copyWith(tipOrConvenienceIndicator: tipOrConvenienceIndicator);
    }
  }

  // tip or convenience indicator
  setValueOfConvenienceFeeFixed(String? value) {
    if (value != null) {
      var valueOfConvenienceFeeFixed =
          setTLV(value, ID.valueOfConvenienceFeeFixed);
      this.value = this
          .value
          .copyWith(valueOfConvenienceFeeFixed: valueOfConvenienceFeeFixed);
    }
  }

  // value of convenience fee percentage
  setValueOfConvenienceFeePercentage(String? value) {
    if (value != null) {
      var valueOfConvenienceFeePercentage =
          setTLV(value, ID.valueOfConvenienceFeePercentage);
      this.value = this.value.copyWith(
          valueOfConvenienceFeePercentage: valueOfConvenienceFeePercentage);
    }
  }

  // country code
  setCountryCode(String? value) {
    if (value != null) {
      var countryCode = setTLV(value, ID.countryCode);
      this.value = this.value.copyWith(countryCode: countryCode);
    }
  }

  // merchant name
  setMerchantName(String? value) {
    if (value != null) {
      var merchantName = setTLV(value, ID.merchantName);
      this.value = this.value.copyWith(merchantName: merchantName);
    }
  }

  // merchant city
  setMerchantCity(String? value) {
    if (value != null) {
      var merchantCity = setTLV(value, ID.merchantCity);
      this.value = this.value.copyWith(merchantCity: merchantCity);
    }
  }

  // postal code
  setPostalCode(String? value) {
    if (value != null) {
      var postalCode = setTLV(value, ID.postalCode);
      this.value = this.value.copyWith(postalCode: postalCode);
    }
  }

  // merchant account information
  setMerchantAccountInformation(
      MerchantAccountInformation? merchantAccountInformation) {
    if (merchantAccountInformation != null) {
      if (value.merchantAccountInformation != null) {
        value.merchantAccountInformation?[merchantAccountInformation.tag!] =
            merchantAccountInformation;
      } else {
        value = value.copyWith(merchantAccountInformation: {
          merchantAccountInformation.tag!: merchantAccountInformation
        });
      }
    }
  }

  // merchant account information
  setAdditionalDataFieldTemplate(
      AdditionalDataFieldTemplate? additionalDataFieldTemplate) {
    if (additionalDataFieldTemplate != null) {
      value = value.copyWith(
          additionalDataFieldTemplate: additionalDataFieldTemplate);
    }
  }

  // unreserved template
  setUnreservedTemplate(UnreservedTemplate? unreservedTemplates) {
    if (unreservedTemplates != null) {
      if (value.unreservedTemplates != null) {
        value.unreservedTemplates?[unreservedTemplates.tag!] =
            unreservedTemplates;
      } else {
        value = value.copyWith(unreservedTemplates: {
          unreservedTemplates.tag!: unreservedTemplates
        });
      }
    }
  }

  // merchant account information
  setMerchantInformationLanguageTemplate(
      MerchantInformationLanguageTemplate?
          merchantInformationLanguageTemplate) {
    if (merchantInformationLanguageTemplate != null) {
      value = value.copyWith(
          merchantInformationLanguageTemplate:
              merchantInformationLanguageTemplate);
    }
  }

  // set rfu for emvcode
  setRfuForEMVCo(List<SetTlvModel> value) {
    late List<TLVModel> rfuForEMVCo = [];

    for (var element in value) {
      if (int.parse(element.id) < int.parse(ID.rfuForEMVCoRangeStart) ||
          int.parse(element.id) > int.parse(ID.rfuForEMVCoRangeEnd)) {
        return [];
      }
      rfuForEMVCo.add(setTLV(element.value, element.id));
    }
    this.value = this.value.copyWith(rfuForEmvCo: rfuForEMVCo);
  }
}
