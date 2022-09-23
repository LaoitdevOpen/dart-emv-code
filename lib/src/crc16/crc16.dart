import 'package:crclib/catalog.dart';

import 'crc_model.dart';

// 65535 is int maxvalue
// 65536 is int maxLength
class CRC16 {
  ChecksumRes checkSum(List<int> data) {
    int crc = 0;
    try {
      crc = Crc16CcittFalse().convert(data).toBigInt().toInt();
      return ChecksumRes(value: crc, err: null);
    } catch (e) {
      return ChecksumRes(value: 0, err: "checksum err");
    }
  }
}
