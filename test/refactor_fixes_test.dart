import 'dart:convert';

import 'package:emvqrcode/emvqrcode.dart';
import 'package:emvqrcode/src/errors/set_emv_value_err.dart';
import 'package:test/test.dart';

void main() {
  test('EmvqrModel.toJson serialises postalCode as a TLV map', () {
    final qr = EMVQR()..setPostalCode('12345');
    final json = qr.value.toJson();
    expect(json['postalCode'], isA<Map>());
    expect(json['postalCode']['value'], '12345');
    expect(() => jsonEncode(json), returnsNormally);
  });

  test('MerchantAccountInformationValue.toJson works without payment items', () {
    final mai = MerchantAccountInformation()..setGloballyUniqueIdentifier('A');
    final json = mai.value.toJson();
    expect(json['paymentNetworkSpecific'], isNull);
  });

  test('setTransactionCurrency error names the right field', () {
    expect(
      () => EMVQR().setTransactionCurrency('12'),
      throwsA(predicate((e) => e.toString().contains('TransactionCurrency'))),
    );
  });

  test('addPaymentNetworkSpecific rejects values over 99 characters', () {
    expect(
      () => MerchantAccountInformation()
          .addPaymentNetworkSpecific(id: '01', value: 'A' * 100),
      throwsA(isA<MaxValueLengthErr>()),
    );
  });
}
