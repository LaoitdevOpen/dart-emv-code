import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/models/emv_decode_model.dart';
import 'package:emvqrcode/src/models/emv_encode_mode.dart';
import 'package:test/test.dart';

void main() {
  group('EMVMPM', () {
    test('decode returns an error and no model for a non-EMV string', () {
      final d = EMVMPM.decode('0002013');
      expect(d.emvqr, isNull);
      expect(d.error?.type, EmvErrorType.notEmvType);
    });

    test('decode returns a model and no error for a valid payload', () {
      final d = EMVMPM.decode('00020101021263041234');
      expect(d.error, isNull);
      expect(d.emvqr?.payloadFormatIndicator?.value, '01');
      expect(d.emvqr?.pointOfInitiationMethod?.value, '12');
    });

    test('encode appends a CRC tag', () {
      final qr = EMVQR()
        ..setPayloadFormatIndicator('01')
        ..setPointOfInitiationMethod('11');
      final enc = EMVMPM.encode(qr);
      expect(enc.error, isNull);
      expect(enc.value, startsWith('00020101021163'));
      expect(verifyEmvQr(enc.value!), true);
    });

    test('encode then decode keeps merchant info', () {
      final qr = EMVQR()
        ..setPayloadFormatIndicator('01')
        ..setMerchantName('SHOP')
        ..setMerchantCity('VTE');
      final d = EMVMPM.decode(EMVMPM.encode(qr).value!);
      expect(d.emvqr?.merchantName?.value, 'SHOP');
      expect(d.emvqr?.merchantCity?.value, 'VTE');
    });

    test('encode then decode keeps additional data and unreserved templates',
        () {
      final add = AdditionalDataFieldTemplate()
        ..setBillNumber('B1')
        ..setTerminalLabel('T1');
      final un = UnreservedTemplate()
        ..setGloballyUniqueIdentifier('abs')
        ..addContextSpecificData(id: '01', value: 'qw12');
      final qr = EMVQR()
        ..setPayloadFormatIndicator('01')
        ..setAdditionalDataFieldTemplate(add)
        ..addUnreservedTemplate(id: '89', value: un);
      final d = EMVMPM.decode(EMVMPM.encode(qr).value!);
      final a = d.emvqr?.additionalDataFieldTemplate?.value;
      expect(a?.billNumber?.value, 'B1');
      expect(a?.terminalLabel?.value, 'T1');
      expect(d.emvqr?.unreservedTemplates?['89'], isNotNull);
    });
  });

  group('EmvEncode / EMVDeCode models', () {
    test('EmvEncode copyWith and toJson', () {
      final e = EmvEncode(value: 'abc');
      expect(e.copyWith(value: 'x').value, 'x');
      expect(e.toJson()['emvqr'], 'abc');
      expect(e.toJson()['error'], isNull);
    });
    test('EMVDeCode copyWith and toJson', () {
      final d = EMVDeCode(error: EmvError(message: 'm'));
      expect(d.copyWith(emvqr: EmvqrModel()).emvqr, isNotNull);
      expect(d.toJson()['emvqr'], isNull);
      expect((d.toJson()['error'] as Map)['message'], 'm');
    });
  });
}
