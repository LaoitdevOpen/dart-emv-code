import 'package:emvqrcode/src/constants/additional_id.dart';
import 'package:emvqrcode/src/models/additoinal_data_field_template.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/models/set_tlv_model.dart';
import 'package:emvqrcode/src/mpm/emv_types.dart';

class SetAdditionalDataFieldTemplate {
  // TLVModel? billNumber;
  // TLVModel? mobileNumber;
  // TLVModel? storeLabel;
  // TLVModel? loyaltyNumber;
  // TLVModel? referenceLabel;
  // TLVModel? customerLabel;
  // TLVModel? terminalLabel;
  // TLVModel? purposeTransaction;
  // TLVModel? additionalConsumerDataRequest;
  // List<TLVModel>? rfuForEMVCo;
  // List<TLVModel>? paymentSystemSpecific;

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

  setRfuForEMVCo(List<SetTlvModel>? value) {
    List<TLVModel> tlv = [];
    if (value != null) {
      for (var element in value) {
        if (int.parse(element.id) <
                int.parse(AdditionalID.rfuForEMVCoRangeStart) ||
            int.parse(element.id) >
                int.parse(AdditionalID.rfuForEMVCoRangeEnd)) {
          this.value = this.value.copyWith(rfuForEMVCo: []);
          return;
        }
        tlv.add(setTLV(element.value, element.id));
      }
    }
    // rfuForEMVCo = tlv;
    this.value = this.value.copyWith(rfuForEMVCo: tlv);
  }

  setPaymentSystemSpecific(List<SetTlvModel>? value) {
    List<TLVModel> tlv = [];
    if (value != null) {
      for (var element in value) {
        if (int.parse(element.id) <
                int.parse(AdditionalID.paymentSystemSpecificTemplatesRangeStart) ||
            int.parse(element.id) >
                int.parse(AdditionalID.paymentSystemSpecificTemplatesRangeEnd)) {
          this.value = this.value.copyWith(rfuForEMVCo: []);
          return;
        }
        tlv.add(setTLV(element.value, element.id));
      }
    }
    // paymentSystemSpecific = tlv;
    this.value = this.value.copyWith(paymentSystemSpecific: tlv);
  }
}
