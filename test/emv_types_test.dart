import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/errors/emv_pattern_err.dart';
import 'package:test/test.dart';

void main() {
  group('getValueLength', () {
    test('pads to two digits', () => expect(getValueLength('abc'), '03'));
    test('empty string is 00', () => expect(getValueLength(''), '00'));
    test('counts UTF-8 bytes, not characters',
        () => expect(getValueLength('最佳'), '06'));
  });

  group('setTLV', () {
    test('builds tag, length and value', () {
      final tlv = setTLV('hello', '59');
      expect(tlv.tag, '59');
      expect(tlv.length, '05');
      expect(tlv.value, 'hello');
    });
  });

  group('tlvToString', () {
    test('null gives empty string', () => expect(tlvToString(null), ''));
    test('concatenates tag, length and value', () {
      expect(tlvToString(TLVModel(tag: '00', length: '02', value: '01')),
          '000201');
    });
  });

  group('format', () {
    test('adds id and byte length',
        () => expect(format('63', 'ABCD'), '6304ABCD'));
    test('length of multi-byte value uses UTF-8 bytes',
        () => expect(format('59', '最'), '5903最'));
  });

  group('between', () {
    test('inside range', () {
      expect(between('12', '10', '20'), {'within': true, 'err': null});
    });
    test('boundaries are inclusive', () {
      expect(between('10', '10', '20')['within'], true);
      expect(between('20', '10', '20')['within'], true);
    });
    test('outside range', () {
      expect(between('21', '10', '20')['within'], false);
      expect(between('09', '10', '20')['within'], false);
    });
    test('non numeric input returns an error', () {
      final r = between('xx', '10', '20');
      expect(r['within'], false);
      expect(r['err'], CheckEmvTypeErr().message);
    });
  });

  group('verifyEmvQr', () {
    const valid =
        '00020101021229300012D156000000000510A93FO3230Q31280012D15600000001030812345678520441115802CN5914BEST TRANSPORT6007BEIJING64200002ZH0104最佳运输0202北京540523.7253031565502016233030412340603***0708A60086670902ME91320016A0112233449988770708123456786304A13A';
    test('accepts a correct checksum', () => expect(verifyEmvQr(valid), true));
    test('rejects a wrong checksum', () {
      expect(verifyEmvQr(valid.substring(0, valid.length - 4) + '0000'), false);
    });
    test('rejects when payload is altered', () {
      expect(verifyEmvQr(valid.replaceFirst('CN', 'JP')), false);
    });
  });

  group('generatePayload / parseEMVQR round trip', () {
    EMVQR build() {
      final emv = EMVQR();
      emv.setPayloadFormatIndicator('01');
      emv.setPointOfInitiationMethod('12');
      final m = MerchantAccountInformation();
      m.setGloballyUniqueIdentifier('D123456');
      m.addPaymentNetworkSpecific(id: '13', value: 'JCB1234567890');
      emv.addMerchantAccountInformation(id: '29', value: m);
      emv.setMerchantCategoryCode('5311');
      emv.setTransactionCurrency('392');
      emv.setTransactionAmount('999.123');
      emv.setCountryCode('JP');
      emv.setMerchantName('DONGRI');
      emv.setMerchantCity('TOKYO');
      return emv;
    }

    test('encoded payload ends with a valid CRC', () {
      final encoded = generatePayload(build().value);
      expect(encoded.error, isNull);
      expect(encoded.value, contains('6304'));
      expect(verifyEmvQr(encoded.value!), true);
    });

    test('decoding an encoded payload restores the fields', () {
      final encoded = generatePayload(build().value).value!;
      final decoded = parseEMVQR(encoded);
      expect(decoded.error, isNull);
      final qr = decoded.emvqr!;
      expect(qr.payloadFormatIndicator?.value, '01');
      expect(qr.pointOfInitiationMethod?.value, '12');
      expect(qr.merchantCategoryCode?.value, '5311');
      expect(qr.transactionCurrency?.value, '392');
      expect(qr.transactionAmount?.value, '999.123');
      expect(qr.countryCode?.value, 'JP');
      expect(qr.merchantName?.value, 'DONGRI');
      expect(qr.merchantCity?.value, 'TOKYO');
      expect(qr.merchantAccountInformation?['29'], isNotNull);
    });

    test('non-numeric garbage is reported as not EMV type', () {
      final r = parseEMVQR('abcdef');
      expect(r.emvqr, isNull);
      expect(r.error, isNotNull);
    });
  });
}
