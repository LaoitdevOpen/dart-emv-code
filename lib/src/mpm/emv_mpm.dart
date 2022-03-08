import 'package:emvqrcode/src/models/emv_decode_model.dart';
import 'package:emvqrcode/src/models/emv_encode_mode.dart';
import 'package:emvqrcode/src/models/emvqr_model.dart';
import 'package:emvqrcode/src/mpm/emv_types.dart';

EMVDeCode emvQRDeCode(String payLoad) {
  var emvqr = ParseEMVQR().parseEMVQR(payLoad);
  if (emvqr.error != null) {
    return EMVDeCode(emvqr: null, error: emvqr.error);
  }
  return EMVDeCode(emvqr: emvqr.emvqr, error: null);
}

EmvEncode emvQrEncode(EMVQR emv) {
  var emvqr = ParseEMVQR().generatePayload(emv);
  return emvqr;
}
