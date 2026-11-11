import 'package:emvqrcode/emvqrcode.dart';
import 'package:test/test.dart';

void main() {
  group('EMVQR exact-length setters', () {
    final cases = <String, List<dynamic>>{
      'payloadFormatIndicator': [
        (EMVQR e, String v) => e.setPayloadFormatIndicator(v),
        (EMVQR e) => e.value.payloadFormatIndicator,
        '00',
        2
      ],
      'pointOfInitiationMethod': [
        (EMVQR e, String v) => e.setPointOfInitiationMethod(v),
        (EMVQR e) => e.value.pointOfInitiationMethod,
        '12',
        2
      ],
      'merchantCategoryCode': [
        (EMVQR e, String v) => e.setMerchantCategoryCode(v),
        (EMVQR e) => e.value.merchantCategoryCode,
        '5311',
        4
      ],
      'transactionCurrency': [
        (EMVQR e, String v) => e.setTransactionCurrency(v),
        (EMVQR e) => e.value.transactionCurrency,
        '392',
        3
      ],
      'tipOrConvenienceIndicator': [
        (EMVQR e, String v) => e.setTipOrConvenienceIndicator(v),
        (EMVQR e) => e.value.tipOrConvenienceIndicator,
        '01',
        2
      ],
      'countryCode': [
        (EMVQR e, String v) => e.setCountryCode(v),
        (EMVQR e) => e.value.countryCode,
        'LA',
        2
      ],
    };
    cases.forEach((name, c) {
      final set = c[0] as void Function(EMVQR, String);
      final get = c[1] as TLVModel? Function(EMVQR);
      final ok = c[2] as String;
      final len = c[3] as int;
      test('$name stores a TLV of length $len', () {
        final e = EMVQR();
        set(e, ok);
        expect(get(e)?.value, ok);
        expect(get(e)?.length, len.toString().padLeft(2, '0'));
      });
      test('$name rejects wrong length', () {
        expect(() => set(EMVQR(), '${ok}x'), throwsA(isA<ValueLengthErr>()));
        expect(() => set(EMVQR(), ok.substring(1)),
            throwsA(isA<ValueLengthErr>()));
      });
    });
  });

  group('EMVQR max-length setters', () {
    final cases = <String, List<dynamic>>{
      'transactionAmount': [
        (EMVQR e, String v) => e.setTransactionAmount(v),
        (EMVQR e) => e.value.transactionAmount,
        13
      ],
      'valueOfConvenienceFeeFixed': [
        (EMVQR e, String v) => e.setValueOfConvenienceFeeFixed(v),
        (EMVQR e) => e.value.valueOfConvenienceFeeFixed,
        13
      ],
      'valueOfConvenienceFeePercentage': [
        (EMVQR e, String v) => e.setValueOfConvenienceFeePercentage(v),
        (EMVQR e) => e.value.valueOfConvenienceFeePercentage,
        5
      ],
      'merchantName': [
        (EMVQR e, String v) => e.setMerchantName(v),
        (EMVQR e) => e.value.merchantName,
        25
      ],
      'merchantCity': [
        (EMVQR e, String v) => e.setMerchantCity(v),
        (EMVQR e) => e.value.merchantCity,
        15
      ],
      'postalCode': [
        (EMVQR e, String v) => e.setPostalCode(v),
        (EMVQR e) => e.value.postalCode,
        10
      ],
    };
    cases.forEach((name, c) {
      final set = c[0] as void Function(EMVQR, String);
      final get = c[1] as TLVModel? Function(EMVQR);
      final max = c[2] as int;
      test('$name accepts exactly $max chars', () {
        final e = EMVQR();
        set(e, 'a' * max);
        expect(get(e)?.value, 'a' * max);
      });
      test('$name rejects ${max + 1} chars', () {
        expect(() => set(EMVQR(), 'a' * (max + 1)),
            throwsA(isA<MaxValueLengthErr>()));
      });
    });
  });

  test('setters ignore null', () {
    final e = EMVQR();
    e.setPayloadFormatIndicator(null);
    e.setPointOfInitiationMethod(null);
    e.setMerchantCategoryCode(null);
    e.setTransactionCurrency(null);
    e.setTransactionAmount(null);
    e.setTipOrConvenienceIndicator(null);
    e.setValueOfConvenienceFeeFixed(null);
    e.setValueOfConvenienceFeePercentage(null);
    e.setCountryCode(null);
    e.setMerchantName(null);
    e.setMerchantCity(null);
    e.setPostalCode(null);
    expect(e.value.payloadFormatIndicator, isNull);
    expect(e.value.merchantName, isNull);
    expect(e.value.postalCode, isNull);
  });

  group('addMerchantAccountInformation', () {
    MerchantAccountInformation info() {
      final m = MerchantAccountInformation();
      m.setGloballyUniqueIdentifier('IT');
      m.addPaymentNetworkSpecific(id: '01', value: 'abc');
      return m;
    }

    test('stores by id with computed length', () {
      final e = EMVQR();
      e.addMerchantAccountInformation(id: '29', value: info());
      final m = e.value.merchantAccountInformation!['29']!;
      expect(m.tag, '29');
      // 0002IT + 0103abc
      expect(m.length, '13');
    });
    test('accepts boundary ids 02 and 51', () {
      final e = EMVQR();
      e.addMerchantAccountInformation(id: '02', value: info());
      e.addMerchantAccountInformation(id: '51', value: info());
      expect(
          e.value.merchantAccountInformation!.keys, containsAll(['02', '51']));
    });
    test('rejects ids outside 02..51', () {
      expect(
          () => EMVQR().addMerchantAccountInformation(id: '01', value: info()),
          throwsA(isA<InvalidId>()));
      expect(
          () => EMVQR().addMerchantAccountInformation(id: '52', value: info()),
          throwsA(isA<InvalidId>()));
    });
    test('same id is overwritten', () {
      final e = EMVQR();
      e.addMerchantAccountInformation(id: '29', value: info());
      e.addMerchantAccountInformation(id: '29', value: info());
      expect(e.value.merchantAccountInformation, hasLength(1));
    });
    test('null args are ignored', () {
      final e = EMVQR();
      e.addMerchantAccountInformation(id: null, value: info());
      e.addMerchantAccountInformation(id: '29', value: null);
      expect(e.value.merchantAccountInformation, isNull);
    });
  });

  group('addRfuForEMVCo', () {
    test('appends in order', () {
      final e = EMVQR();
      e.addRfuForEMVCo(id: '65', value: 'a');
      e.addRfuForEMVCo(id: '79', value: 'b');
      expect(e.value.rfuForEmvCo!.map((t) => t.tag), ['65', '79']);
    });
    test('rejects ids outside 65..79', () {
      expect(() => EMVQR().addRfuForEMVCo(id: '64', value: 'a'),
          throwsA(isA<InvalidId>()));
      expect(() => EMVQR().addRfuForEMVCo(id: '80', value: 'a'),
          throwsA(isA<InvalidId>()));
    });
    test('rejects values over 99 chars', () {
      expect(() => EMVQR().addRfuForEMVCo(id: '65', value: 'a' * 100),
          throwsA(isA<MaxValueLengthErr>()));
    });
  });

  group('addUnreservedTemplate', () {
    UnreservedTemplate tpl() {
      final u = UnreservedTemplate();
      u.setGloballyUniqueIdentifier('abs');
      u.addContextSpecificData(id: '01', value: 'qw12');
      return u;
    }

    test('stores by id with computed length', () {
      final e = EMVQR();
      e.addUnreservedTemplate(id: '89', value: tpl());
      // 0003abs + 0104qw12
      expect(e.value.unreservedTemplates!['89']!.length, '15');
    });
    test('rejects ids outside 80..99', () {
      expect(() => EMVQR().addUnreservedTemplate(id: '79', value: tpl()),
          throwsA(isA<InvalidId>()));
      expect(() => EMVQR().addUnreservedTemplate(id: '100', value: tpl()),
          throwsA(isA<InvalidId>()));
    });
    test('null args are ignored', () {
      final e = EMVQR();
      e.addUnreservedTemplate(id: '89', value: null);
      expect(e.value.unreservedTemplates, isNull);
    });
  });

  group('templates attached to EMVQR', () {
    test('setAdditionalDataFieldTemplate computes length', () {
      final a = AdditionalDataFieldTemplate()..setBillNumber('hoge');
      final e = EMVQR()..setAdditionalDataFieldTemplate(a);
      expect(e.value.additionalDataFieldTemplate?.tag, '62');
      expect(e.value.additionalDataFieldTemplate?.length, '08');
    });
    test('setMerchantInformationLanguageTemplate computes length', () {
      final m = MerchantInformationLanguageTemplate()
        ..setLanguagePreferencer('LA')
        ..setMerchantName('MW');
      final e = EMVQR()..setMerchantInformationLanguageTemplate(m);
      expect(e.value.merchantInformationLanguageTemplate?.tag, '64');
      expect(e.value.merchantInformationLanguageTemplate?.length, '12');
    });
    test('null templates are ignored', () {
      final e = EMVQR()
        ..setAdditionalDataFieldTemplate(null)
        ..setMerchantInformationLanguageTemplate(null);
      expect(e.value.additionalDataFieldTemplate, isNull);
      expect(e.value.merchantInformationLanguageTemplate, isNull);
    });
  });
}
