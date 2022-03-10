import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/constants/unreserved_template_id.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/models/unreserved_template.dart';

class UnreservedTemplate {
  late UnreservedTemplateValue value = UnreservedTemplateValue();

  setGloballyUniqueIdentifier(String value) {
    final globallyUniqueIdentifier =
        setTLV(value, UnreservedTemplateID.globallyUniqueIdentifier);
    this.value =
        this.value.copyWith(globallyUniqueIdentifier: globallyUniqueIdentifier);
  }

  setContextSpecificData({String? id, String? value}) {
    if (id != null && value != null) {
      if (int.parse(id) <
              int.parse(UnreservedTemplateID.contextSpecificDataStart) ||
          int.parse(id) >
              int.parse(UnreservedTemplateID.contextSpecificDataEnd)) {
        this.value = this.value.copyWith(contextSpecificData: []);
        return;
      }

      if (this.value.contextSpecificData != null) {
        this.value.contextSpecificData?.add(setTLV(value, id));
      } else {
        List<TLVModel> tlv = [];
        tlv.add(setTLV(value, id));
        this.value = this.value.copyWith(contextSpecificData: tlv);
      }
    }
  }
}
