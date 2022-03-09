import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';

class SetMerchantAccountInformationValue {
  late MerchantAccountInformationValue value =
      MerchantAccountInformationValue();

  setGloballyUniqueIdentifier(String value) {
    final globallyUniqueIdentifier =
        setTLV(value, MerchantAccountInformationID.globallyUniqueIdentifier);
    this.value =
        this.value.copyWith(globallyUniqueIdentifier: globallyUniqueIdentifier);
  }

  setPaymentNetworkSpecific({String? id, String? value}) {
    if (id != null && value != null) {
      if (int.parse(id) <
              int.parse(
                  MerchantAccountInformationID.paymentNetworkSpecificStart) ||
          int.parse(id) >
              int.parse(
                  MerchantAccountInformationID.paymentNetworkSpecificEnd)) {
        this.value = this.value.copyWith(paymentNetworkSpecific: []);
        return;
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
