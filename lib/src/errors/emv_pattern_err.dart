class CheckEmvTypeErr implements Exception {
  final String? error;
  CheckEmvTypeErr({this.error});

  String get message => "qrcode not emp type";
}
