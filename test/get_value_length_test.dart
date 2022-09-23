import 'package:emvqrcode/emvqrcode.dart';
import 'package:test/test.dart';

void main() {
  test("get value length <= 10", () {
    final valLength = getValueLength("12345678");
    expect(valLength, "08");
  });

  test("get value length >= 10", () {
    final valLength = getValueLength("ABCDEFGHIJ");
    expect(valLength, "10");
  });

  test("format crc value length <= 10", () {
    final valLength = format("123", "12345678");
    expect(valLength, "1230812345678");
  });

  test("format crc value length >= 10", () {
    final crcValue = format("123", "1234567890");
    expect(crcValue, "123101234567890");
  });
}
