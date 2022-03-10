import 'package:emvqrcode/src/constants/merchant_information_id.dart';
import 'package:emvqrcode/src/models/merchant_information_langage_template.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/mpm/emv_types.dart';

class MerchantInformationLanguageTemplate {
  late MerchantInformationLanguageTemplateModel value =
      MerchantInformationLanguageTemplateModel();

  setLanguagePreferencer(String value) {
    final languagePreference =
        setTLV(value, MerchantInformationID.languagePreference);
    this.value = this.value.copyWith(languagePreference: languagePreference);
  }

  setMerchantName(String value) {
    final merchantName = setTLV(value, MerchantInformationID.merchantName);
    this.value = this.value.copyWith(merchantName: merchantName);
  }

  setMerchantCity(String value) {
    final merchantCity = setTLV(value, MerchantInformationID.merchantCity);
    this.value = this.value.copyWith(merchantCity: merchantCity);
  }

  setRfuForEMVCo({String? id, String? value}) {
    if (id != null && value != null) {
      if (int.parse(id) <
              int.parse(MerchantInformationID.rfuForEMVCoRangeStart) ||
          int.parse(id) >
              int.parse(MerchantInformationID.rfuForEMVCoRangeEnd)) {
        this.value = this.value.copyWith(rfuForEMVCo: []);
        return;
      }

      if (this.value.rfuForEMVCo != null) {
        this.value.rfuForEMVCo?.add(setTLV(value, id));
      } else {
        List<TLVModel> tlv = [];
        tlv.add(setTLV(value, id));
        this.value =
            this.value.copyWith(rfuForEMVCo: tlv);
      }
    }
  }
}
