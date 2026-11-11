import 'package:emvqrcode/emvqrcode.dart';
import 'package:test/test.dart';

void main() {
  group('AdditionalDataFieldTemplate', () {
    final maxSetters = <String, List<dynamic>>{
      'billNumber': [
        (AdditionalDataFieldTemplate t, String v) => t.setBillNumber(v),
        (AdditionalDataFieldTemplate t) => t.value.billNumber,
        '01',
        25
      ],
      'mobileNumber': [
        (AdditionalDataFieldTemplate t, String v) => t.setMobileNumber(v),
        (AdditionalDataFieldTemplate t) => t.value.mobileNumber,
        '02',
        25
      ],
      'storeLabel': [
        (AdditionalDataFieldTemplate t, String v) => t.setStoreLabel(v),
        (AdditionalDataFieldTemplate t) => t.value.storeLabel,
        '03',
        25
      ],
      'loyaltyNumber': [
        (AdditionalDataFieldTemplate t, String v) => t.setLoyaltyNumber(v),
        (AdditionalDataFieldTemplate t) => t.value.loyaltyNumber,
        '04',
        25
      ],
      'referenceLabel': [
        (AdditionalDataFieldTemplate t, String v) => t.setReferenceLabel(v),
        (AdditionalDataFieldTemplate t) => t.value.referenceLabel,
        '05',
        25
      ],
      'customerLabel': [
        (AdditionalDataFieldTemplate t, String v) => t.setCustomerLabel(v),
        (AdditionalDataFieldTemplate t) => t.value.customerLabel,
        '06',
        25
      ],
      'terminalLabel': [
        (AdditionalDataFieldTemplate t, String v) => t.setTerminalLabel(v),
        (AdditionalDataFieldTemplate t) => t.value.terminalLabel,
        '07',
        25
      ],
      'purposeTransaction': [
        (AdditionalDataFieldTemplate t, String v) => t.setPurposeTransaction(v),
        (AdditionalDataFieldTemplate t) => t.value.purposeTransaction,
        '08',
        25
      ],
      'additionalConsumerDataRequest': [
        (AdditionalDataFieldTemplate t, String v) =>
            t.setAdditionalConsumerDataRequest(v),
        (AdditionalDataFieldTemplate t) =>
            t.value.additionalConsumerDataRequest,
        '09',
        3
      ],
      'merchantTaxID': [
        (AdditionalDataFieldTemplate t, String v) => t.setMerchantTaxID(v),
        (AdditionalDataFieldTemplate t) => t.value.merchantTaxId,
        '10',
        20
      ],
    };
    maxSetters.forEach((name, c) {
      final set = c[0] as void Function(AdditionalDataFieldTemplate, String);
      final get = c[1] as TLVModel? Function(AdditionalDataFieldTemplate);
      final tag = c[2] as String;
      final max = c[3] as int;
      test('$name uses tag $tag and accepts $max chars', () {
        final t = AdditionalDataFieldTemplate();
        set(t, 'a' * max);
        expect(get(t)?.tag, tag);
        expect(get(t)?.value, 'a' * max);
      });
      test('$name rejects ${max + 1} chars', () {
        expect(() => set(AdditionalDataFieldTemplate(), 'a' * (max + 1)),
            throwsA(isA<MaxValueLengthErr>()));
      });
    });

    test('merchantChannel requires exactly 3 chars', () {
      final t = AdditionalDataFieldTemplate()..setMerchantChannel('abc');
      expect(t.value.merchantChannel?.tag, '11');
      expect(() => AdditionalDataFieldTemplate().setMerchantChannel('ab'),
          throwsA(isA<ValueLengthErr>()));
      expect(() => AdditionalDataFieldTemplate().setMerchantChannel('abcd'),
          throwsA(isA<ValueLengthErr>()));
    });

    test('addRfuForEMVCo accepts 12..49 only', () {
      final t = AdditionalDataFieldTemplate()
        ..addRfuForEMVCo(id: '12', value: 'a')
        ..addRfuForEMVCo(id: '49', value: 'b');
      expect(t.value.rfuForEMVCo!.map((e) => e.tag), ['12', '49']);
      expect(
          () => AdditionalDataFieldTemplate()
              .addRfuForEMVCo(id: '11', value: 'a'),
          throwsA(isA<InvalidId>()));
      expect(
          () => AdditionalDataFieldTemplate()
              .addRfuForEMVCo(id: '50', value: 'a'),
          throwsA(isA<InvalidId>()));
    });

    test('addPaymentSystemSpecific accepts 50..99 only', () {
      final t = AdditionalDataFieldTemplate()
        ..addPaymentSystemSpecific(id: '50', value: 'a')
        ..addPaymentSystemSpecific(id: '99', value: 'b');
      expect(t.value.paymentSystemSpecific!.map((e) => e.tag), ['50', '99']);
      expect(
          () => AdditionalDataFieldTemplate()
              .addPaymentSystemSpecific(id: '49', value: 'a'),
          throwsA(isA<InvalidId>()));
    });

    test('null id/value are ignored', () {
      final t = AdditionalDataFieldTemplate()
        ..addRfuForEMVCo(id: null, value: 'a')
        ..addPaymentSystemSpecific(id: '50', value: null);
      expect(t.value.rfuForEMVCo, isNull);
      expect(t.value.paymentSystemSpecific, isNull);
    });
  });

  group('MerchantAccountInformation', () {
    test('globally unique identifier uses tag 00, max 32', () {
      final m = MerchantAccountInformation()
        ..setGloballyUniqueIdentifier('a' * 32);
      expect(m.value.globallyUniqueIdentifier?.tag, '00');
      expect(
          () => MerchantAccountInformation()
              .setGloballyUniqueIdentifier('a' * 33),
          throwsA(isA<MaxValueLengthErr>()));
    });
    test('payment network specific accepts 01..99', () {
      final m = MerchantAccountInformation()
        ..addPaymentNetworkSpecific(id: '01', value: 'a')
        ..addPaymentNetworkSpecific(id: '99', value: 'b');
      expect(m.value.paymentNetworkSpecific, hasLength(2));
    });
    test('payment network specific rejects 00', () {
      expect(
          () => MerchantAccountInformation()
              .addPaymentNetworkSpecific(id: '00', value: 'a'),
          throwsA(isA<InvalidId>()));
    });
    test('null id/value are ignored', () {
      final m = MerchantAccountInformation()
        ..addPaymentNetworkSpecific(id: null, value: 'a');
      expect(m.value.paymentNetworkSpecific, isNull);
    });
  });

  group('MerchantInformationLanguageTemplate', () {
    test('language preference needs exactly 2 chars', () {
      final t = MerchantInformationLanguageTemplate()
        ..setLanguagePreferencer('LA');
      expect(t.value.languagePreference?.tag, '00');
      expect(
          () =>
              MerchantInformationLanguageTemplate().setLanguagePreferencer('L'),
          throwsA(isA<ValueLengthErr>()));
    });
    test('merchant name max 25', () {
      final t = MerchantInformationLanguageTemplate()
        ..setMerchantName('a' * 25);
      expect(t.value.merchantName?.tag, '01');
      expect(
          () => MerchantInformationLanguageTemplate().setMerchantName('a' * 26),
          throwsA(isA<MaxValueLengthErr>()));
    });
    test('merchant city max 15', () {
      final t = MerchantInformationLanguageTemplate()
        ..setMerchantCity('a' * 15);
      expect(t.value.merchantCity?.tag, '02');
      expect(
          () => MerchantInformationLanguageTemplate().setMerchantCity('a' * 16),
          throwsA(isA<MaxValueLengthErr>()));
    });
    test('rfu accepts 03..99 only', () {
      final t = MerchantInformationLanguageTemplate()
        ..addRfuForEMVCo(id: '03', value: 'a');
      expect(t.value.rfuForEMVCo, hasLength(1));
      expect(
          () => MerchantInformationLanguageTemplate()
              .addRfuForEMVCo(id: '02', value: 'a'),
          throwsA(isA<InvalidId>()));
    });
  });

  group('UnreservedTemplate', () {
    test('globally unique identifier uses tag 00, max 32', () {
      final u = UnreservedTemplate()..setGloballyUniqueIdentifier('a' * 32);
      expect(u.value.globallyUniqueIdentifier?.tag, '00');
      expect(() => UnreservedTemplate().setGloballyUniqueIdentifier('a' * 33),
          throwsA(isA<MaxValueLengthErr>()));
    });
    test('context specific data accepts 01..99', () {
      final u = UnreservedTemplate()
        ..addContextSpecificData(id: '01', value: 'a')
        ..addContextSpecificData(id: '99', value: 'b');
      expect(u.value.contextSpecificData, hasLength(2));
    });
    test('context specific data rejects 00', () {
      expect(
          () =>
              UnreservedTemplate().addContextSpecificData(id: '00', value: 'a'),
          throwsA(isA<InvalidId>()));
    });
  });
}
