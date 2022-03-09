import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/models/set_tlv_model.dart';

class SetMerchantAccountInformation {
  late MerchantAccountInformation value = MerchantAccountInformation();

  TLVModel _setGloballyUniqueIdentifier(String value) {
    return setTLV(value, MerchantAccountInformationID.globallyUniqueIdentifier);
  }

  List<TLVModel> _setPaymentNetworkSpecific(List<SetTlvModel> value) {
    List<TLVModel> paymentNetworkSpecific = [];
    for (var element in value) {
      paymentNetworkSpecific.add(setTLV(element.value, element.id));
    }
    return paymentNetworkSpecific;
  }

  addMerchantAccountInformation({
    String? id,
    String? globallyUniqueIdentifierValue,
    List<SetTlvModel>? paymentNetworkSpecificValue,
  }) {
    if (id != null &&
        globallyUniqueIdentifierValue != null &&
        paymentNetworkSpecificValue != null) {
      if (int.parse(id) <
              int.parse(
                  ID.merchantAccountInformationRangeStart) ||
          int.parse(id) >
              int.parse(
                  ID.merchantAccountInformationRangeEnd)) {
        return;
      }
      //set globallyUniqueIdentifier tlv
      TLVModel _globallyUniqueIdentifier =
          _setGloballyUniqueIdentifier(globallyUniqueIdentifierValue);

      //set paymentNetworkSpecific tlv
      List<TLVModel> _paymentNetworkSpecific =
          _setPaymentNetworkSpecific(paymentNetworkSpecificValue);

      String _globally =
          "${_globallyUniqueIdentifier.tag}${_globallyUniqueIdentifier.length}${_globallyUniqueIdentifier.value}";
      String _payment = "";
      for (var element in _paymentNetworkSpecific) {
        _payment += "${element.tag}${element.length}${element.value}";
      }

      // set merchant account information tlv
      // final mtlv = MerchantAccountInformation(
      //   tag: id,
      //   length: l(_globally + _payment),
      //   value: MerchantAccountInformationValue(
      //     globallyUniqueIdentifier: _globallyUniqueIdentifier,
      //     paymentNetworkSpecific: _paymentNetworkSpecific,
      //   ),
      // );
      value = value.copyWith(
            tag: id,
            length: l(_globally + _payment),
            value: MerchantAccountInformationValue(
              globallyUniqueIdentifier: _globallyUniqueIdentifier,
              paymentNetworkSpecific: _paymentNetworkSpecific,
            ),
          );
    }
  }
}
