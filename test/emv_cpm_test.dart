import 'package:emvqrcode/src/cpm/set_emv_cpm/application_template.dart';
import 'package:emvqrcode/src/cpm/emv_cpm.dart';
import 'package:emvqrcode/src/cpm/set_emv_cpm/common_data_template.dart';
import 'package:emvqrcode/src/cpm/set_emv_cpm/cpm_emv.dart';
import 'package:emvqrcode/src/models/cmp/ber_tvl.dart';
import 'package:test/test.dart';

void main() {
  test("to hex fuction", () {
    final qr = CPM();
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
    print("value -----------> $value");
    expect(
        "8505435056303161134F07A0000000555555500850726f647563743161134F07A0000000666666500850726f647563743262495A0812345678901234585F200E43415244484f4c4445522f454d565F2D08727565736465656e64219F100706010A030000009F2608584FD385FA234BCC9F360200019F37046D58EF13",
        "8505435056303161134F07A0000000555555500850726f647563743161134F07A0000000666666500850726f647563743262495A0812345678901234585F200E43415244484f4c4445522f454d565F2D08727565736465656e64219F100706010A030000009F2608584FD385FA234BCC9F360200019F37046D58EF13");
    expect(value,
        "hQVDUFYwMWETTwegAAAAVVVVUAhQcm9kdWN0MWETTwegAAAAZmZmUAhQcm9kdWN0MmJJWggSNFZ4kBI0WF8gDkNBUkRIT0xERVIvRU1WXy0IcnVlc2RlZW5kIZ8QBwYBCgMAAACfJghYT9OF+iNLzJ82AgABnzcEbVjvEw==");
  });
}
