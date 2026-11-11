import 'dart:convert';

import 'package:emvqrcode/src/crc16/crc16.dart';
import 'package:emvqrcode/src/crc16/crc.dart';
import 'package:emvqrcode/src/crc16/crc_model.dart';
import 'package:test/test.dart';

void main() {
  group('CRC16.checkSum', () {
    test('matches the CRC-16/CCITT-FALSE check value', () {
      final r = CRC16().checkSum(utf8.encode('123456789'));
      expect(r.err, isNull);
      expect(r.value, 0x29B1);
    });
    test('empty input returns the init value', () {
      final r = CRC16().checkSum([]);
      expect(r.err, isNull);
      expect(r.value, 0xFFFF);
    });
    test('different input gives different checksum', () {
      final a = CRC16().checkSum(utf8.encode('abc')).value;
      final b = CRC16().checkSum(utf8.encode('abd')).value;
      expect(a, isNot(b));
    });
  });

  group('CRC params', () {
    final crc = CRC();
    test('crc16CcittFalse parameters', () {
      final p = crc.crc16CcittFalse;
      expect(p.poly, 0x1021);
      expect(p.init, 0xFFFF);
      expect(p.check, 0x29B1);
      expect(p.name, 'CRC-16/CCITT-FALSE');
    });
    test('crc16Arc parameters', () {
      final p = crc.crc16Arc;
      expect(p.poly, 0x8005);
      expect(p.refIn, true);
      expect(p.check, 0xBB3D);
    });
    test('Params copyWith and json round trip', () {
      final p = crc.crc16Arc.copyWith(name: 'x');
      expect(p.name, 'x');
      final back = Params.fromJson(p.toJson());
      expect(back.poly, p.poly);
      expect(back.name, 'x');
    });
  });

  group('ChecksumRes', () {
    test('holds value and err', () {
      final r = ChecksumRes(value: 1, err: 'e');
      expect(r.value, 1);
      expect(r.err, 'e');
    });
  });
}
