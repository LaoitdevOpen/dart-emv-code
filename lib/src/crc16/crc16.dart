import 'package:emvqrcode/src/crc16/crc_model.dart';
// 65535 is int maxvalue
// 65536 is int maxLength
class CRC16 {
  Table makeTable(Params params) {
    List<int> data = [];
    for (int n = 0; n < 256; n++) {
      int crc = n << 8;
      for (var i = 0; i < 8; i++) {
        bool bit = (crc & 0x8000) != 0;

        if ((crc << 1) > 65535) {
          crc = (crc << 1) - 65536;
        } else {
          crc <<= 1;
        }
        if (bit) {
          crc ^= params.poly;
        }
      }
      data.insert(n, crc);
    }
    return Table(params: params, data: data);
  }

  // init(Table table) {
  //   return table.params?.init ?? null;
  // }

  FuncRes updateCrc(int crc, List<int> data, Table table) {
    try {
      for (var element in data) {
        if (table.params!.refIn) {
          element = reverseByte(element);
        }
        // if (crc > 65536) {
        final tb = table.data!.elementAt((crc >> 8) ^ element);
        crc <<= 8;
        while (crc > 65535) {
          crc -= 65536;
        }

        crc = crc ^ tb;
      }
      return FuncRes(value: crc, err: null, func: "updateCrc");
    } catch (e) {
      return FuncRes(value: 0, err: "can not check sum", func: "updateCrc");
    }
  }

  FuncRes complete(int crc, Table table) {
    try {
      if (table.params!.refOut) {
        return FuncRes.fromJson({
          "func": "complete",
          "value": reverseUint16(crc) ^ table.params!.xorOut,
          "err": null
        });
      }

      return FuncRes(
          value: crc ^ table.params!.xorOut, err: null, func: "complete");
    } catch (e) {
      return FuncRes(
          value: 0, err: "check sum last check err", func: "complete");
    }
  }

  ChecksumRes checkSum(List<int> data, Table table) {
    int crc = 0;
    try {
      crc = table.params!.init;

      final update = updateCrc(crc, data, table);
      if (update.err != null) {
        return ChecksumRes(value: 0, err: "${update.func}:${update.err}");
      } else {
        crc = update.value;
      }

      final comp = complete(crc, table);
      if (comp.err != null) {
        return ChecksumRes(value: 0, err: "${comp.func}:${comp.err}");
      } else {
        crc = comp.value;
      }

      return ChecksumRes(value: crc, err: null);
    } catch (e) {
      return ChecksumRes(value: 0, err: "checksum err");
    }
  }

  int reverseUint16(int val) {
    int rval = 0;
    for (var i = 0; i < 16; i++) {
      if (val & (1 << i) != 0) {
        rval |= 0x8000 >> i;
      }
    }
    return rval;
  }

  int reverseByte(int val) {
    int rval = 0;
    for (var i = 0; i < 8; i++) {
      if (val & (1 << i) != 0) {
        rval |= 0x80 >> i;
      }
    }
    return rval;
  }
}
