import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/constants/unreserved_template_id.dart';
import 'package:emvqrcode/src/models/set_tlv_model.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/models/unreserved_template.dart';

class SetUnreservedTemplate {
  late UnreservedTemplate value = UnreservedTemplate();

  TLVModel _setGloballyUniqueIdentifier(String value) {
    return setTLV(value, UnreservedTemplateID.globallyUniqueIdentifier);
  }

  List<TLVModel> _setContextSpecificData(List<SetTlvModel> value) {
    List<TLVModel> paymentNetworkSpecific = [];
    for (var element in value) {
      if (int.parse(element.id) <
              int.parse(UnreservedTemplateID.contextSpecificDataStart) ||
          int.parse(element.id) >
              int.parse(UnreservedTemplateID.contextSpecificDataEnd)) {
        return [];
      }
      paymentNetworkSpecific.add(setTLV(element.value, element.id));
    }
    return paymentNetworkSpecific;
  }

  setUnreservedTemplates(
    {String? id,
    String? globallyUniqueIdentifierValue,
    List<SetTlvModel>? contextSpecificDataValue,}
  ) {
    if (id != null &&
        globallyUniqueIdentifierValue != null &&
        contextSpecificDataValue != null) {
      if (int.parse(id) < int.parse(ID.unreservedTemplatesRangeStart) ||
          int.parse(id) > int.parse(ID.unreservedTemplatesRangeEnd)) {
        return;
      }
      //set globallyUniqueIdentifier tlv
      TLVModel globallyUniqueIdentifier =
          _setGloballyUniqueIdentifier(globallyUniqueIdentifierValue);

      //set contextSpecificData tlv
      List<TLVModel> contextSpecificData =
          _setContextSpecificData(contextSpecificDataValue);
      String _globally =
          "${globallyUniqueIdentifier.tag}${globallyUniqueIdentifier.length}${globallyUniqueIdentifier.value}";
      String _contextSpec = "";
      for (var element in contextSpecificData) {
        _contextSpec += "${element.tag}${element.length}${element.value}";
      }
      UnreservedTemplate uTLV = UnreservedTemplate(
        tag: id,
        length: l(_globally + _contextSpec),
        value: UnreservedTemplateValue(
            globallyUniqueIdentifier: globallyUniqueIdentifier,
            contextSpecificData: contextSpecificData),
      );
      value = uTLV;
    }
  }
}
