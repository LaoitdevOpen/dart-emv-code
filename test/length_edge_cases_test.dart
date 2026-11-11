import 'package:emvqrcode/emvqrcode.dart';
import 'package:test/test.dart';

// Regression tests for length handling: >99 rejected, non-ASCII round trip.
void main() {
  group('getValueLength over 99 characters', () {
    test('rejects values that do not fit in a 2-digit length', () {
      expect(() => getValueLength('A' * 100), throwsA(anything));
    });

    test('still accepts exactly 99 bytes', () {
      expect(getValueLength('A' * 99), '99');
    });
  });

  group('non-ASCII round trip', () {
    test('merchant name with multi-byte characters survives encode/decode', () {
      final qr = EMVQR()
        ..setPayloadFormatIndicator('01')
        ..setMerchantName('ຮ້ານກາເຟ')
        ..setMerchantCity('VTE');
      final enc = EMVMPM.encode(qr);
      expect(enc.error, isNull);

      final d = EMVMPM.decode(enc.value!);
      expect(d.error, isNull);
      expect(d.emvqr?.merchantName?.value, 'ຮ້ານກາເຟ');
      expect(d.emvqr?.merchantCity?.value, 'VTE');
    });
  });
}
