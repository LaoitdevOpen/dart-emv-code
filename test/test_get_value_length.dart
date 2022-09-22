import 'package:emvqrcode/emvqrcode.dart';
import 'package:test/test.dart';

void main() {
  test("get value length <= 10", () {
    final valLength = getValueLength("12345678");

    print("value length ----> $valLength");

    expect(valLength, "08");
  });

  test("get value length >= 10", () {
    final valLength = getValueLength("1234567890");

    print("value length ----> $valLength");

    expect(valLength, "10");
  });

  test("format crc value length <= 10", () {
    final valLength = format("123", "12345678");

    print("value ----> $valLength");

    expect(valLength, "1230812345678");
  });

  test("format crc value length >= 10", () {
    final crcValue = format("123", "1234567890");

    print("value ----> $crcValue");

    expect(crcValue, "123101234567890");
  });
}
