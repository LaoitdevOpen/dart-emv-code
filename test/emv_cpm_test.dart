import 'package:emvqrcode/emvqrcode.dart';
import 'package:test/test.dart';

void main() {
  test("encode cmp qrcode", () {
    final qr = CPMQR();
    qr.setDataPayloadFormatIndicator("CPV01");

    final appTemplate1 = ApplicationTemplate();
    appTemplate1.setBerTvl(
      BerTvl(
          dataApplicationDefinitionFileName: "A0000000555555",
          dataApplicationLabel: "Product1"),
    );

    qr.addApplicationTemplate(appTemplate1);

    final appTemplate2 = ApplicationTemplate();
    appTemplate2.setBerTvl(BerTvl(
        dataApplicationDefinitionFileName: "A0000000666666",
        dataApplicationLabel: "Product2"));
    qr.addApplicationTemplate(appTemplate2);

    final cdt = CommonDataTemplate();
    cdt.setBerTvl(
      BerTvl(
          dataApplicationPan: "1234567890123458",
          dataCardholderName: "CARDHOLDER/EMV",
          dataLanguagePreference: "ruesdeen"),
    );

    cdt.addCommonDataTransparentTemplates(
      BerTvl(
        dataIssuerApplicationData: '06010A03000000',
        dataApplicationCryptogram: "584FD385FA234BCC",
        dataApplicationTransactionCounter: "0001",
        dataUnpredictableNumber: "6D58EF13",
      ),
    );
    qr.addCommonDataTemplate(cdt);

    final cpm = EMVCPM();
    final value = cpm.generatePayload(qr);

    expect(value,
        "hQVDUFYwMWETTwegAAAAVVVVUAhQcm9kdWN0MWETTwegAAAAZmZmUAhQcm9kdWN0MmJJWggSNFZ4kBI0WF8gDkNBUkRIT0xERVIvRU1WXy0IcnVlc2RlZW5kIZ8QBwYBCgMAAACfJghYT9OF+iNLzJ82AgABnzcEbVjvEw==");
  });
}
