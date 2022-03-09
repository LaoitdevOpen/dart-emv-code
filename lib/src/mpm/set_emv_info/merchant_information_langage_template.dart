import 'package:emvqrcode/src/constants/merchant_information_id.dart';
import 'package:emvqrcode/src/models/merchant_information_langage_template.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/models/set_tlv_model.dart';
import 'package:emvqrcode/src/mpm/emv_types.dart';

class SetMerchantInformationLangageTemplate {
  late MerchantInformationLanguageTemplate value =
      MerchantInformationLanguageTemplate();
  // TLVModel? languagePreference;
  // TLVModel? merchantName;
  // TLVModel? merchantCity;
  // List<TLVModel>? rfuForEMVCo;

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

  setRfuForEMVCo(List<SetTlvModel> value) {
    List<TLVModel> tlv = [];
    for (var element in value) {
      if (int.parse(element.id) <
              int.parse(MerchantInformationID.rfuForEMVCoRangeStart) ||
          int.parse(element.id) >
              int.parse(MerchantInformationID.rfuForEMVCoRangeEnd)) {
        this.value = this.value.copyWith(rfuForEMVCo: []);
        return;
      }
      tlv.add(setTLV(element.value, element.id));
    }
    // rfuForEMVCo = paymentNetworkSpecific;
    this.value = this.value.copyWith(rfuForEMVCo: tlv);
  }
}
