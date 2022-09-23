import '../errors/emv_error_model.dart';
import '../models/parser_model.dart';

const int idWordCount = 2;
const int valueLengthWordCount = 2;

// new parser
ParserModel newParser(String payload) {
  return ParserModel(
    current: -1,
    max: payload.codeUnits.length,
    source: payload.codeUnits,
    error: null,
  );
}

// next
bool next(ParserModel p) {
  if (p.error != null) {
    return false;
  }
  if (p.current! < 0) {
    p.current = 0;
  } else {
    int valueLen = valueLength(p);
    if (p.error != null) {
      return false;
    }
    p.current = p.current! + valueLen + idWordCount + valueLengthWordCount;
  }
  if (p.current! >= p.max!) {
    return false;
  }
  return true;
}

int valueLength(ParserModel? p) {
  const String fnValueLength = "ValueLength";

  if (p != null) {
    int current = p.current ?? 0;
    int max = p.max ?? 0;
    int start = current + idWordCount;
    int end = start + valueLengthWordCount;

    if (p.current! < 0) {
      p.error = notCallErr(fnValueLength);
      return 0;
    }

    if (max < end) {
      p.error = outOfRangeErr(fnValueLength, p.current!, p.max!, start, end);
      return 0;
    }

    String strValueLength = String.fromCharCodes(p.source!.sublist(start, end));

    try {
      final len = int.parse(strValueLength, radix: 10);
      return len;
    } catch (e) {
      return 0;
    }
  }
  return 0;
}

String pid(ParserModel? p) {
  const fnID = "ID";
  if (p != null) {
    int current = p.current ?? 0;
    int max = p.max ?? 0;
    int start = current;
    int end = start + idWordCount;

    if (current < 0) {
      p.error = notCallErr(fnID);
      return "";
    }

    if (max < end) {
      p.error = outOfRangeErr(fnID, p.current!, p.max!, start, end);
      return "";
    }

    String id = String.fromCharCodes(p.source!.sublist(start, end));
    return id;
  }
  return "";
}

String pValue(ParserModel? p) {
  const fnValue = "Value";

  if (p != null) {
    int current = p.current ?? 0;
    int max = p.max ?? 0;
    int start = current + idWordCount + valueLengthWordCount;
    int end = start + valueLength(p);

    if (current < 0) {
      p.error = notCallErr(fnValue);
      return "";
    }
    if (max < end) {
      p.error = outOfRangeErr(fnValue, p.current!, p.max!, start, end);
      return "";
    }
    return String.fromCharCodes(p.source!.sublist(start, end));
  }
  return "";
}

EmvError notCallErr(String fn) {
  return EmvError(type: EmvErrorType.notEmvType, message: "not call Next()");
}

EmvError outOfRangeErr(String fn, int current, int max, int start, int end) {
  return EmvError(
      type: EmvErrorType.notEmvType,
      message:
          "bounds out of range. current: $current, max: $max, start: $start, end: $end");
}
