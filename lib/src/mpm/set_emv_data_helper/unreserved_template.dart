import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/constants/unreserved_template_id.dart';
import 'package:emvqrcode/src/errors/set_emv_value_err.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/models/unreserved_template.dart';

/// set unreserved template value
class UnreservedTemplate {
  late UnreservedTemplateValue value = UnreservedTemplateValue();

  /// globally unique indentifier
  ///
  /// length of [value] is 1 up to 32
  setGloballyUniqueIdentifier(String value) {
    if (value.length > 32) {
      throw MaxValueLengthErr(title: "GloballyUniqueIdentifier", length: "32");
    }
    final globallyUniqueIdentifier =
        setTLV(value, UnreservedTemplateID.globallyUniqueIdentifier);
    this.value =
        this.value.copyWith(globallyUniqueIdentifier: globallyUniqueIdentifier);
  }

  /// Context Specific Data
  ///
  /// context specific d ata is list type. u can add more than one item.
  /// [id] id is "01" to "99"
  addContextSpecificData({String? id, String? value}) {
    if (id != null && value != null) {
      if (int.parse(id) <
              int.parse(UnreservedTemplateID.contextSpecificDataStart) ||
          int.parse(id) >
              int.parse(UnreservedTemplateID.contextSpecificDataEnd)) {
        // this.value = this.value.copyWith(contextSpecificData: []);
        throw InvalidId(title: "ContextSpecificData");
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
