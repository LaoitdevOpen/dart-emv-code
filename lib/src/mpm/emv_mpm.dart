import 'package:emvqrcode/src/models/emv_decode_model.dart';
import 'package:emvqrcode/src/models/emv_encode_mode.dart';
import 'package:emvqrcode/src/models/emvqr_model.dart';
import 'package:emvqrcode/src/mpm/emv_types.dart';

class EMVMPM {
  
  static EMVDeCode decode(String payLoad) {
    var emvqr = parseEMVQR(payLoad);
    if (emvqr.error != null) {
      return EMVDeCode(emvqr: null, error: emvqr.error);
    }
    return EMVDeCode(emvqr: emvqr.emvqr, error: null);
  }

  static EmvEncode encode(EMVQR emv) {
    var emvqr = generatePayload(emv);
    return emvqr;
  }
}
