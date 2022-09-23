import '../../constants/merchant_information_id.dart';
import '../../errors/set_emv_value_err.dart';
import '../../models/merchant_information_langage_template.dart';
import '../../models/tlv_model.dart';
import '../emv_types.dart';

/// set merchant information language template
class MerchantInformationLanguageTemplate {
  late MerchantInformationLanguageTemplateValue value =
      MerchantInformationLanguageTemplateValue();

  /// Set language preferencer
  ///
  /// length of [value] is 2.
  setLanguagePreferencer(String value) {
    if (value.length != 2) {
      throw ValueLengthErr(title: "LanguagePreferencer", length: "2");
    }
    final languagePreference =
        setTLV(value, MerchantInformationID.languagePreference);
    this.value = this.value.copyWith(languagePreference: languagePreference);
  }

  /// Set merchant name
  ///
  /// length of [value] is 1 up to 25.
  setMerchantName(String value) {
    if (value.length > 25) {
      throw MaxValueLengthErr(title: "MerchantName", length: "25");
    }
    final merchantName = setTLV(value, MerchantInformationID.merchantName);
    this.value = this.value.copyWith(merchantName: merchantName);
  }

  /// Set merchant city
  ///
  /// length of [value] is 1 up to 15.
  setMerchantCity(String value) {
    if (value.length > 15) {
      throw MaxValueLengthErr(title: "MerchantCity", length: "25");
    }
    final merchantCity = setTLV(value, MerchantInformationID.merchantCity);
    this.value = this.value.copyWith(merchantCity: merchantCity);
  }

  /// RFU for EMVCo
  ///
  /// RFU for EMVCo is list type. u can add more than one item.
  /// [id] id is "03" to "99".
  addRfuForEMVCo({String? id, String? value}) {
    if (id != null && value != null) {
      if (int.parse(id) <
              int.parse(MerchantInformationID.rfuForEMVCoRangeStart) ||
          int.parse(id) >
              int.parse(MerchantInformationID.rfuForEMVCoRangeEnd)) {
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
}
