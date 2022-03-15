import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/errors/set_emv_value_err.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';

/// set merchant account information
class MerchantAccountInformation {
  late MerchantAccountInformationValue value =
      MerchantAccountInformationValue();

  /// globally unique indentifier
  ///
  /// length of [value] is 1 up to 32
  setGloballyUniqueIdentifier(String value) {
    if (value.length > 32) {
      throw MaxValueLengthErr(title: "GloballyUniqueIdentifier", length: "32");
    }
    final globallyUniqueIdentifier =
        setTLV(value, MerchantAccountInformationID.globallyUniqueIdentifier);
    this.value =
        this.value.copyWith(globallyUniqueIdentifier: globallyUniqueIdentifier);
  }

  /// payment network specific
  ///
  /// payment network specific is list type. u can add more than one item.
  /// [id] id is "01" to "99"
  addPaymentNetworkSpecific({String? id, String? value}) {
    if (id != null && value != null) {
      if (int.parse(id) <
              int.parse(
                  MerchantAccountInformationID.paymentNetworkSpecificStart) ||
          int.parse(id) >
              int.parse(
                  MerchantAccountInformationID.paymentNetworkSpecificEnd)) {
        // this.value = this.value.copyWith(paymentNetworkSpecific: []);
        throw InvalidId(title: "PaymentNetworkSpecific");
      }

      if (this.value.paymentNetworkSpecific != null) {
        this.value.paymentNetworkSpecific?.add(setTLV(value, id));
      } else {
        List<TLVModel> paymentNetworkSpecific = [];
        paymentNetworkSpecific.add(setTLV(value, id));
        this.value =
            this.value.copyWith(paymentNetworkSpecific: paymentNetworkSpecific);
      }
    }
  }
}
