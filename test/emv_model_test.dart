import 'package:emvqrcode/emvqrcode.dart';
import 'package:test/test.dart';

void main() {
  test("postalvalueToJson", () {
    // set only postalcode value
    final emv = EMVQR();
    emv.setPostalCode("00001122");
    print("emv code to json =====> ${emv.value.toJson()}");
    final encode = EMVMPM.encode(emv);
    print("endcode ===> ${encode.value}");
  });
}
