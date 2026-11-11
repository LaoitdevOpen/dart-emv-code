import 'package:emvqrcode/src/errors/emv_error_model.dart';
import 'package:emvqrcode/src/models/parser_model.dart';
import 'package:emvqrcode/src/mpm/emv_parser.dart';
import 'package:test/test.dart';

void main() {
  group('newParser', () {
    test('starts before the first element', () {
      final p = newParser('000201');
      expect(p.current, -1);
      expect(p.max, 6);
      expect(p.error, isNull);
    });
    test('max counts UTF-16 code units', () {
      expect(newParser('abc').max, 3);
    });
  });

  group('next / pid / pValue', () {
    test('iterates over every TLV element', () {
      final p = newParser('0002015903abc');
      final seen = <String>[];
      while (next(p)) {
        seen.add('${pid(p)}=${pValue(p)}');
      }
      expect(seen, ['00=01', '59=abc']);
      expect(p.error, isNull);
    });

    test('next returns false for an empty payload', () {
      expect(next(newParser('')), false);
    });

    test('next returns false once an error is set', () {
      final p = newParser('000201')..error = EmvError(message: 'x');
      expect(next(p), false);
    });

    test('pid before next reports notEmvType', () {
      final p = newParser('000201');
      expect(pid(p), '');
      expect(p.error?.type, EmvErrorType.notEmvType);
    });

    test('pValue before next reports an error', () {
      final p = newParser('000201');
      expect(pValue(p), '');
      expect(p.error, isNotNull);
    });

    test('pValue beyond payload end reports out of range', () {
      final p = newParser('0005ab');
      expect(next(p), true);
      expect(pValue(p), '');
      expect(p.error?.message, contains('out of range'));
    });

    test('pid beyond payload end reports out of range', () {
      final p = newParser('0');
      expect(next(p), true);
      expect(pid(p), '');
      expect(p.error?.message, contains('out of range'));
    });

    test('null parser returns empty values', () {
      expect(pid(null), '');
      expect(pValue(null), '');
    });
  });

  group('valueLength', () {
    test('reads the two digit length', () {
      final p = newParser('5904ABCD');
      next(p);
      expect(valueLength(p), 4);
    });
    test('non numeric length yields 0', () {
      final p = newParser('59abXY');
      next(p);
      expect(valueLength(p), 0);
    });
    test('null parser yields 0', () => expect(valueLength(null), 0));
    test('before next reports an error', () {
      final p = newParser('000201');
      expect(valueLength(p), 0);
      expect(p.error, isNotNull);
    });
    test('truncated length reports out of range', () {
      final p = newParser('00');
      next(p);
      expect(valueLength(p), 0);
      expect(p.error?.message, contains('out of range'));
    });
  });

  group('error helpers', () {
    test('notCallErr', () {
      final e = notCallErr('ID');
      expect(e.type, EmvErrorType.notEmvType);
      expect(e.message, 'not call Next()');
    });
    test('outOfRangeErr includes the bounds', () {
      final e = outOfRangeErr('ID', 1, 2, 3, 4);
      expect(e.type, EmvErrorType.notEmvType);
      expect(e.message,
          'bounds out of range. current: 1, max: 2, start: 3, end: 4');
    });
  });

  group('ParserModel', () {
    test('copyWith overrides given fields', () {
      final p = ParserModel(current: 1, max: 2, source: [1, 2]);
      final c = p.copyWith(current: 5);
      expect(c.current, 5);
      expect(c.max, 2);
      expect(c.source, [1, 2]);
    });
    test('toJson with null source gives empty list', () {
      expect(ParserModel(current: 0, max: 0).toJson()['source'], isEmpty);
    });
    test('toJson includes source and null error', () {
      final j = ParserModel(current: 0, max: 2, source: [65, 66]).toJson();
      expect(j['source'], [65, 66]);
      expect(j['error'], isNull);
    });
  });
}
