class ChecksumErr implements Exception {
  final String? error;
  ChecksumErr({this.error});

  String get message => "checksum err";
}

class CreateCrcTableErr implements Exception {
  final String? error;
  CreateCrcTableErr({this.error});

  String get message => "create crc table err";
}


class CompleteChecksumErr implements Exception {
  final String? error;
  CompleteChecksumErr({this.error});

  String get message => "complete checksum err";
}