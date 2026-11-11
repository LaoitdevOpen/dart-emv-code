import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/models/cmp/application_template_model.dart';
import 'package:emvqrcode/src/models/cmp/common_data_template_model.dart';
import 'package:emvqrcode/src/models/cmp/cmp_model.dart';
import 'package:test/test.dart';

void main() {
  group('BerTvl', () {
    test('defaults to all null', () {
      expect(BerTvl().toJson().values.every((v) => v == null), true);
    });
    test('copyWith overrides only given fields', () {
      final b = BerTvl(dataApplicationPan: '1', dataCardholderName: 'A');
      final c = b.copyWith(dataCardholderName: 'B');
      expect(c.dataApplicationPan, '1');
      expect(c.dataCardholderName, 'B');
    });
    test('toJson / fromJson round trip for every field', () {
      final b = BerTvl(
        dataApplicationDefinitionFileName: 'a',
        dataApplicationLabel: 'b',
        dataTrack2EquivalentData: 'c',
        dataApplicationPan: 'd',
        dataCardholderName: 'e',
        dataLanguagePreference: 'f',
        dataIssuerUrl: 'g',
        dataApplicationVersionNumber: 'h',
        dataIssuerApplicationData: 'i',
        dataTokenRequestorId: 'j',
        dataPaymentAccountReference: 'k',
        dataLast4DigitsOfPan: 'l',
        dataApplicationCryptogram: 'm',
        dataApplicationTransactionCounter: 'n',
        dataUnpredictableNumber: 'o',
      );
      final back = BerTvl.fromJson(b.toJson());
      expect(back.toJson(), b.toJson());
      expect(back.dataUnpredictableNumber, 'o');
      expect(back.dataApplicationDefinitionFileName, 'a');
    });
    test('berTvlToJson / berTvlFromJson round trip', () {
      final b = BerTvl(dataApplicationPan: '1234');
      expect(berTvlFromJson(berTvlToJson(b)).dataApplicationPan, '1234');
    });
  });

  group('ApplicationTemplate / CommonDataTemplate', () {
    test('ApplicationTemplate stores berTvl and transparent templates', () {
      final t = ApplicationTemplate();
      expect(t.berTvl, isNull);
      expect(t.applicationSpecificTransparentTemplates, isEmpty);
      final b = BerTvl(dataApplicationLabel: 'x');
      t.setBerTvl(b);
      t.addApplicationSpecificTransparentTemplates(b);
      expect(t.berTvl, same(b));
      expect(t.applicationSpecificTransparentTemplates, [b]);
    });
    test('CommonDataTemplate stores berTvl and transparent templates', () {
      final t = CommonDataTemplate();
      expect(t.berTvl, isNull);
      expect(t.commonDataTransparentTemplates, isEmpty);
      final b = BerTvl(dataApplicationPan: 'x');
      t.setBerTvl(b);
      t.addCommonDataTransparentTemplates(b);
      expect(t.berTvl, same(b));
      expect(t.commonDataTransparentTemplates, [b]);
    });
  });

  group('CPM', () {
    test('starts empty', () {
      final c = CPM();
      expect(c.dataPayloadFormatIndicator, isNull);
      expect(c.applicationTemplates, isEmpty);
      expect(c.commonDataTemplates, isEmpty);
    });
    test('setDataPayloadFormatIndicator', () {
      final c = CPM()..setDataPayloadFormatIndicator('CPV01');
      expect(c.dataPayloadFormatIndicator, 'CPV01');
    });
    test('addApplicationTemplate copies template data', () {
      final t = ApplicationTemplate()
        ..setBerTvl(BerTvl(dataApplicationLabel: 'P1'));
      final c = CPM()..addApplicationTemplate(t);
      expect(c.applicationTemplates, hasLength(1));
      expect(c.applicationTemplates.first.berTvl?.dataApplicationLabel, 'P1');
    });
    test('addCommonDataTemplate copies template data', () {
      final t = CommonDataTemplate()
        ..setBerTvl(BerTvl(dataApplicationPan: '1'));
      final c = CPM()..addCommonDataTemplate(t);
      expect(c.commonDataTemplates, hasLength(1));
      expect(c.commonDataTemplates.first.berTvl?.dataApplicationPan, '1');
    });
  });

  group('template models', () {
    test('ApplicationTemplateModel copyWith and toJson', () {
      final m =
          ApplicationTemplateModel(berTvl: BerTvl(dataApplicationLabel: 'a'));
      final c = m.copyWith(applicationSpecificTransparentTemplates: [BerTvl()]);
      expect(c.berTvl?.dataApplicationLabel, 'a');
      expect(c.applicationSpecificTransparentTemplates, hasLength(1));
      expect(m.toJson()['ApplicationSpecificTransparentTemplates'], isEmpty);
      expect((c.toJson()['BERTLV'] as Map)['DataApplicationLabel'], 'a');
    });
    test('CommonDataTemplateModel copyWith and toJson', () {
      final m =
          CommonDataTemplateModel(berTvl: BerTvl(dataApplicationPan: 'p'));
      final c = m.copyWith(commonDataTransparentTemplates: [BerTvl()]);
      expect(c.berTvl?.dataApplicationPan, 'p');
      expect(c.commonDataTransparentTemplates, hasLength(1));
      expect(m.toJson()['CommonDataTransparentTemplates'], isEmpty);
    });
    test('CpmModel copyWith and toJson', () {
      final m = CpmModel(dataPayloadFormatIndicator: 'CPV01');
      final c = m.copyWith(applicationTemplates: [ApplicationTemplateModel()]);
      expect(c.dataPayloadFormatIndicator, 'CPV01');
      expect(c.applicationTemplates, hasLength(1));
      final j = m.toJson();
      expect(j['DataPayloadFormatIndicator'], 'CPV01');
      expect(j['ApplicationTemplates'], isEmpty);
      expect(j['CommonDataTemplates'], isEmpty);
    });
  });
}
