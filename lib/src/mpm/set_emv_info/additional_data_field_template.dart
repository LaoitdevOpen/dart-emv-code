import 'package:emvqrcode/src/constants/additional_id.dart';
import 'package:emvqrcode/src/models/additoinal_data_field_template.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/mpm/emv_types.dart';

class SetAdditionalDataFieldTemplate {
  late AdditionalDataFieldTemplate value = AdditionalDataFieldTemplate();

  setBillNumber(String value) {
    final billNumber = setTLV(value, AdditionalID.billNumber);
    this.value = this.value.copyWith(billNumber: billNumber);
  }

  setMobileNumber(String value) {
    final mobileNumber = setTLV(value, AdditionalID.mobileNumber);
    this.value = this.value.copyWith(mobileNumber: mobileNumber);
  }

  setStoreLabel(String value) {
    final storeLabel = setTLV(value, AdditionalID.storeLabel);
    this.value = this.value.copyWith(storeLabel: storeLabel);
  }

  setLoyaltyNumber(String value) {
    final loyaltyNumber = setTLV(value, AdditionalID.loyaltyNumber);
    this.value = this.value.copyWith(loyaltyNumber: loyaltyNumber);
  }

  setReferenceLabel(String value) {
    final referenceLabel = setTLV(value, AdditionalID.referenceLabel);
    this.value = this.value.copyWith(referenceLabel: referenceLabel);
  }

  setCustomerLabel(String value) {
    final customerLabel = setTLV(value, AdditionalID.customerLabel);
    this.value = this.value.copyWith(customerLabel: customerLabel);
  }

  setTerminalLabel(String value) {
    final terminalLabel = setTLV(value, AdditionalID.terminalLabel);
    this.value = this.value.copyWith(terminalLabel: terminalLabel);
  }

  setPurposeTransaction(String value) {
    final purposeTransaction = setTLV(value, AdditionalID.purposeTransaction);
    this.value = this.value.copyWith(purposeTransaction: purposeTransaction);
  }

  setAdditionalConsumerDataRequest(String value) {
    final additionalConsumerDataRequest =
        setTLV(value, AdditionalID.additionalConsumerDataRequest);

    this.value = this
        .value
        .copyWith(additionalConsumerDataRequest: additionalConsumerDataRequest);
  }

  setRfuForEMVCo({String? id, String? value}) {
    if (id != null && value != null) {
      if (int.parse(id) < int.parse(AdditionalID.rfuForEMVCoRangeStart) ||
          int.parse(id) > int.parse(AdditionalID.rfuForEMVCoRangeEnd)) {
        this.value = this.value.copyWith(rfuForEMVCo: []);
        return;
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

  setPaymentSystemSpecific({String? id, String? value}) {
    if (id != null && value != null) {
      if (int.parse(id) < int.parse(AdditionalID.paymentSystemSpecificTemplatesRangeStart) ||
          int.parse(id) > int.parse(AdditionalID.paymentSystemSpecificTemplatesRangeEnd)) {
        this.value = this.value.copyWith(paymentSystemSpecific: []);
        return;
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
