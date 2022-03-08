class FunctionErr implements Exception {
  final String? error;
  FunctionErr({this.error});

  String get message => "function err";
}