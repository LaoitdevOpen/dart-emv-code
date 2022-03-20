
enum EmvErrorType{
  notEmvType,
  generateQrErr,
  valueLength,
  verifyqrErr,
  idErr,
  value,
}

class EmvError {
  EmvError({
    this.type,
    this.message,
  });
  EmvErrorType? type;
  dynamic message;

  EmvError copyWith({
    EmvErrorType? type,
    dynamic message,
  }) =>
      EmvError(
        type: type ?? this.type,
        message: message ?? this.message,
      );

  factory EmvError.fromJson(Map<String, dynamic> json) => EmvError(
        type: json["type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
      };
}
