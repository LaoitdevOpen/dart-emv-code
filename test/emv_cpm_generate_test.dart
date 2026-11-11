import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:emvqrcode/emvqrcode.dart';
import 'package:test/test.dart';

String _hex(String payload) => hex.encode(base64.decode(payload)).toUpperCase();

void main() {
  group('EMVCPM.generatePayload', () {
    test('empty CPM yields an empty payload', () {
      expect(EMVCPM().generatePayload(CPM()), '');
    });

    test('payload format indicator is tag 85 with hex of ASCII', () {
      final cpm = CPM()..setDataPayloadFormatIndicator('CPV01');
      final payload = EMVCPM().generatePayload(cpm)!;
      // 'CPV01' -> 43 50 56 30 31
      expect(_hex(payload), '85054350563031');
    });

    test('application template wraps definition file name and label', () {
      final cpm = CPM()..setDataPayloadFormatIndicator('CPV01');
      final app = ApplicationTemplate()
        ..setBerTvl(BerTvl(
            dataApplicationDefinitionFileName: 'A0000000555555',
            dataApplicationLabel: 'Product1'));
      cpm.addApplicationTemplate(app);
      final h = _hex(EMVCPM().generatePayload(cpm)!);
      expect(h, contains('611'));
      expect(h, contains('4F07A0000000555555'));
      expect(h,
          contains('5008${hex.encode(utf8.encode('Product1')).toUpperCase()}'));
    });

    test('application specific transparent templates use tag 63', () {
      final cpm = CPM();
      final app = ApplicationTemplate()
        ..setBerTvl(BerTvl(dataApplicationLabel: 'A'))
        ..addApplicationSpecificTransparentTemplates(
            BerTvl(dataApplicationLabel: 'B'));
      cpm.addApplicationTemplate(app);
      final h = _hex(EMVCPM().generatePayload(cpm)!);
      // 61 08 | 50 01 41 | 63 03 50 01 42
      expect(h, '610850014163035001' '42');
    });

    test('common data template uses tag 62 with transparent tag 64', () {
      final cpm = CPM();
      final cdt = CommonDataTemplate()
        ..setBerTvl(BerTvl(dataApplicationPan: '1234'))
        ..addCommonDataTransparentTemplates(
            BerTvl(dataUnpredictableNumber: '6D58EF13'));
      cpm.addCommonDataTemplate(cdt);
      final h = _hex(EMVCPM().generatePayload(cpm)!);
      expect(h.startsWith('62'), true);
      expect(h, contains('5A021234'));
      expect(h, contains('64079F37046D58EF13'));
    });

    test('every BerTvl field is emitted with its tag', () {
      final cpm = CPM();
      final cdt = CommonDataTemplate()
        ..setBerTvl(BerTvl(
          dataTrack2EquivalentData: '1234',
          dataApplicationPan: '1234',
          dataCardholderName: 'A',
          dataLanguagePreference: 'en',
          dataIssuerUrl: 'u',
          dataApplicationVersionNumber: '0001',
          dataIssuerApplicationData: '0A',
          dataTokenRequestorId: '0B',
          dataPaymentAccountReference: '0C',
          dataLast4DigitsOfPan: '1234',
          dataApplicationCryptogram: '0D',
          dataApplicationTransactionCounter: '0001',
          dataUnpredictableNumber: '0E',
        ));
      cpm.addCommonDataTemplate(cdt);
      final h = _hex(EMVCPM().generatePayload(cpm)!);
      for (final tag in [
        '57',
        '5A',
        '5F20',
        '5F2D',
        '5F50',
        '9F08',
        '9F10',
        '9F19',
        '9F24',
        '9F25',
        '9F26',
        '9F36',
        '9F37'
      ]) {
        expect(h, contains(tag), reason: 'missing tag $tag');
      }
    });

    test('invalid hex input makes generatePayload return null', () {
      final cpm = CPM();
      cpm.addApplicationTemplate(ApplicationTemplate()
        ..setBerTvl(BerTvl(dataApplicationDefinitionFileName: 'ZZ')));
      expect(EMVCPM().generatePayload(cpm), isNull);
    });

    test('output is valid base64', () {
      final cpm = CPM()..setDataPayloadFormatIndicator('CPV01');
      expect(
          () => base64.decode(EMVCPM().generatePayload(cpm)!), returnsNormally);
    });
  });
}
