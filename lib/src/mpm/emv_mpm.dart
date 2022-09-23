import '../models/emv_decode_model.dart';
import '../models/emv_encode_mode.dart';
import 'emv_types.dart';
import 'set_emv_data_helper/set_emv_info.dart';

/// emv mpm type
class EMVMPM {
  /// mpm decode
  static EMVDeCode decode(String payLoad) {
    var emvqr = parseEMVQR(payLoad);
    if (emvqr.error != null) {
      return EMVDeCode(emvqr: null, error: emvqr.error);
    }
    return EMVDeCode(emvqr: emvqr.emvqr, error: null);
  }

  /// mpm encode
  static EmvEncode encode(EMVQR emv) {
    var emvqr = generatePayload(emv.value);
    return emvqr;
  }
}
