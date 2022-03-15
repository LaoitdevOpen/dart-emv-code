class ValueLengthErr implements Exception {
  final String? title;
  final String? length;
  ValueLengthErr({this.title, this.length});

  String get message => "length of $title value must be $length";

  @override
  String toString() {
    return message;
  }
}

class MaxValueLengthErr implements Exception {
  final String? title;
  final String? length;
  MaxValueLengthErr({this.title, this.length});

  String get message => "max length of $title value is $length";

  @override
  String toString() {
    return message;
  }
}

class InvalidId implements Exception {
  final String? title;
  InvalidId({this.title});

  String get message => "$title id is invalid.";

  @override
  String toString() {
    return message;
  }
}
