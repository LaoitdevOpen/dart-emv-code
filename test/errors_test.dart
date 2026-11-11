import 'package:emvqrcode/src/errors/checksum_err.dart';
import 'package:emvqrcode/src/errors/emv_error_model.dart';
import 'package:emvqrcode/src/errors/emv_pattern_err.dart';
import 'package:emvqrcode/src/errors/func_error.dart';
import 'package:emvqrcode/src/errors/set_emv_value_err.dart';
import 'package:test/test.dart';

void main() {
  test('ValueLengthErr message and toString', () {
    final e = ValueLengthErr(title: 'Foo', length: '2');
    expect(e.message, 'length of Foo value must be 2');
    expect(e.toString(), e.message);
  });

  test('MaxValueLengthErr message and toString', () {
    final e = MaxValueLengthErr(title: 'Foo', length: '25');
    expect(e.message, 'max length of Foo value is 25');
    expect(e.toString(), e.message);
  });

  test('InvalidId message and toString', () {
    final e = InvalidId(title: 'Foo');
    expect(e.message, 'Foo id is invalid.');
    expect(e.toString(), e.message);
  });

  test('checksum errors expose messages and the wrapped error', () {
    expect(ChecksumErr(error: 'x').error, 'x');
    expect(ChecksumErr().message, 'checksum err');
    expect(CreateCrcTableErr().message, 'create crc table err');
    expect(CompleteChecksumErr().message, 'complete checksum err');
  });

  test('CheckEmvTypeErr and FunctionErr messages', () {
    expect(CheckEmvTypeErr().message, 'qrcode not emvCo type');
    expect(FunctionErr().message, 'function err');
  });

  group('EmvError', () {
    test('copyWith overrides given fields only', () {
      final e = EmvError(type: EmvErrorType.idErr, message: 'a');
      final c = e.copyWith(message: 'b');
      expect(c.type, EmvErrorType.idErr);
      expect(c.message, 'b');
    });
    test('toJson', () {
      final j = EmvError(type: EmvErrorType.value, message: 'm').toJson();
      expect(j, {'type': EmvErrorType.value, 'message': 'm'});
    });
    test('fromJson', () {
      final e =
          EmvError.fromJson({'type': EmvErrorType.valueLength, 'message': 'm'});
      expect(e.type, EmvErrorType.valueLength);
      expect(e.message, 'm');
    });
  });
}
