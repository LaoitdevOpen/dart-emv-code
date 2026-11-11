import 'package:emvqrcode/emvqrcode.dart';
import 'package:test/test.dart';

void main() {
  group('TLVModel', () {
    test('constructor leaves fields null by default', () {
      final tlv = TLVModel();
      expect(tlv.tag, isNull);
      expect(tlv.length, isNull);
      expect(tlv.value, isNull);
    });

    test('copyWith overrides only the given fields', () {
      final tlv = TLVModel(tag: '00', length: '02', value: '01');
      final copy = tlv.copyWith(value: '99');
      expect(copy.tag, '00');
      expect(copy.length, '02');
      expect(copy.value, '99');
    });

    test('toJson uses the "lenght" key', () {
      final json = TLVModel(tag: '00', length: '02', value: '01').toJson();
      expect(json, {'tag': '00', 'lenght': '02', 'value': '01'});
    });

    test('fromJson / toJson round trip', () {
      final tlv =
          TLVModel.fromJson({'tag': '59', 'lenght': '04', 'value': 'ABCD'});
      expect(tlv.tag, '59');
      expect(tlv.length, '04');
      expect(tlv.value, 'ABCD');
    });

    test('tlvModelToJson / tlvModelFromJson round trip', () {
      final src = TLVModel(tag: '58', length: '02', value: 'LA');
      final back = tlvModelFromJson(tlvModelToJson(src));
      expect(back.tag, src.tag);
      expect(back.length, src.length);
      expect(back.value, src.value);
    });
  });
}
