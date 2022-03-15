import 'package:emvqrcode/src/constants/additional_id.dart';
import 'package:emvqrcode/src/errors/set_emv_value_err.dart';
import 'package:emvqrcode/src/models/additoinal_data_field_template.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/mpm/emv_types.dart';

/// set additional data field template
class AdditionalDataFieldTemplate {
  late AdditionalDataFieldTemplateValue value =
      AdditionalDataFieldTemplateValue();

  /// Set bill number
  ///
  /// length limit of [value] 1 up to 25.
  setBillNumber(String value) {
    if (value.length > 25) {
      throw MaxValueLengthErr(title: "BillNumber", length: "25");
    }
    final billNumber = setTLV(value, AdditionalID.billNumber);
    this.value = this.value.copyWith(billNumber: billNumber);
  }

  /// Set mobile number
  ///
  /// length of [value] is 1 up to 25.
  setMobileNumber(String value) {
    if (value.length > 25) {
      throw MaxValueLengthErr(title: "MobileNumber", length: "25");
    }
    final mobileNumber = setTLV(value, AdditionalID.mobileNumber);
    this.value = this.value.copyWith(mobileNumber: mobileNumber);
  }

  /// Set store label
  ///
  /// length of [value] is 1 up to 25.
  setStoreLabel(String value) {
    if (value.length > 25) {
      throw MaxValueLengthErr(title: "StoreLabel", length: "25");
    }
    final storeLabel = setTLV(value, AdditionalID.storeLabel);
    this.value = this.value.copyWith(storeLabel: storeLabel);
  }

  /// Set loyalty number
  ///
  /// length of [value] is 1 up to 25.
  setLoyaltyNumber(String value) {
    if (value.length > 25) {
      throw MaxValueLengthErr(title: "LoyaltyNumber", length: "25");
    }
    final loyaltyNumber = setTLV(value, AdditionalID.loyaltyNumber);
    this.value = this.value.copyWith(loyaltyNumber: loyaltyNumber);
  }

  /// Set reference label
  ///
  /// length of [value] is 1 up to 25.
  setReferenceLabel(String value) {
    if (value.length > 25) {
      throw MaxValueLengthErr(title: "ReferenceLabel", length: "25");
    }
    final referenceLabel = setTLV(value, AdditionalID.referenceLabel);
    this.value = this.value.copyWith(referenceLabel: referenceLabel);
  }

  /// Set customer label
  ///
  /// length of [value] is 1 up to 25.
  setCustomerLabel(String value) {
    if (value.length > 25) {
      throw MaxValueLengthErr(title: "CustomerLabel", length: "25");
    }
    final customerLabel = setTLV(value, AdditionalID.customerLabel);
    this.value = this.value.copyWith(customerLabel: customerLabel);
  }

  /// Set terminal label
  ///
  /// length of [value] is 1 up to 25.
  setTerminalLabel(String value) {
    if (value.length > 25) {
      throw MaxValueLengthErr(title: "TerminalLabel", length: "25");
    }
    final terminalLabel = setTLV(value, AdditionalID.terminalLabel);
    this.value = this.value.copyWith(terminalLabel: terminalLabel);
  }

  /// Set purpose transaction
  ///
  /// length of [value] is 1 up to 25.
  setPurposeTransaction(String value) {
    if (value.length > 25) {
      throw MaxValueLengthErr(title: "PurposeTransaction", length: "25");
    }
    final purposeTransaction = setTLV(value, AdditionalID.purposeTransaction);
    this.value = this.value.copyWith(purposeTransaction: purposeTransaction);
  }

  /// Set additional consumer data request
  ///
  /// length of [value] is 1 up to 3.
  setAdditionalConsumerDataRequest(String value) {
    if (value.length > 3) {
      throw MaxValueLengthErr(
          title: "AdditionalConsumerDataRequest", length: "3");
    }
    final additionalConsumerDataRequest =
        setTLV(value, AdditionalID.additionalConsumerDataRequest);
    this.value = this
        .value
        .copyWith(additionalConsumerDataRequest: additionalConsumerDataRequest);
  }

  /// merchant tax id
  ///
  /// length of [value] is 1 up to 20.
  setMerchantTaxID(String value) {
    if (value.length > 20) {
      throw MaxValueLengthErr(title: "MerchantTaxID", length: "20");
    }
    final merchantTaxId = setTLV(value, AdditionalID.merchantTaxId);
    this.value = this.value.copyWith(merchantTaxId: merchantTaxId);
  }

  /// Set merchant channel
  ///
  /// length of [value] is 3.
  setMerchantChannel(String value) {
    if (value.length != 3) {
      throw ValueLengthErr(title: "MerchantChannel", length: "3");
    }
    final merchantChannel = setTLV(value, AdditionalID.merchantChannel);

    this.value = this.value.copyWith(merchantChannel: merchantChannel);
  }

  /// RFU for EMVCo
  ///
  /// RFU for EMVCo is list type. u can add more than one item.
  /// [id] id is "12" to "49"
  addRfuForEMVCo({String? id, String? value}) {
    if (id != null && value != null) {
      if (int.parse(id) < int.parse(AdditionalID.rfuForEMVCoRangeStart) ||
          int.parse(id) > int.parse(AdditionalID.rfuForEMVCoRangeEnd)) {
        // this.value = this.value.copyWith(rfuForEMVCo: []);
        throw InvalidId(title: "RfuForEMVCo");
      }

      if (this.value.rfuForEMVCo != null) {
        this.value.rfuForEMVCo?.add(setTLV(value, id));
      } else {
        List<TLVModel> tlv = [];
        tlv.add(setTLV(value, id));
        this.value = this.value.copyWith(rfuForEMVCo: tlv);
      }
    }
  }

  /// Payment System Specific
  ///
  /// payment system specific is list type. u can add more than one item.
  /// [id] id is "50" to "99".
  addPaymentSystemSpecific({String? id, String? value}) {
    if (id != null && value != null) {
      if (int.parse(id) <
              int.parse(
                  AdditionalID.paymentSystemSpecificTemplatesRangeStart) ||
          int.parse(id) >
              int.parse(AdditionalID.paymentSystemSpecificTemplatesRangeEnd)) {
        // this.value = this.value.copyWith(paymentSystemSpecific: []);
        throw InvalidId(title: "PaymentSystemSpecific");
      }

      if (this.value.paymentSystemSpecific != null) {
        this.value.paymentSystemSpecific?.add(setTLV(value, id));
      } else {
        List<TLVModel> tlv = [];
        tlv.add(setTLV(value, id));
        this.value = this.value.copyWith(paymentSystemSpecific: tlv);
      }
    }
  }
}
