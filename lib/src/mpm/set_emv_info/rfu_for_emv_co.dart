import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/models/set_tlv_model.dart';

List<TLVModel> setRfuForEMVCo(List<SetTlvModel>? value) {
  List<TLVModel> rfuForEMVCo = [];
  if (value != null) {
    for (var element in value) {
      if (int.parse(element.id) < int.parse(ID.rfuForEMVCoRangeStart) ||
          int.parse(element.id) > int.parse(ID.rfuForEMVCoRangeEnd)) {
        return [];
      }
      rfuForEMVCo.add(setTLV(element.value, element.id));
    }
  }
  return rfuForEMVCo;
}
