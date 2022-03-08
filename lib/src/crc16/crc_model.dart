// To parse this JSON data, do
//
//     final table = tableFromJson(jsonString);

import 'dart:convert';

Table tableFromJson(String str) => Table.fromJson(json.decode(str));

String tableToJson(Table data) => json.encode(data.toJson());

class Table {
  Table({
    this.params,
    this.data,
  });

  Params? params;
  List<int>? data;

  Table copyWith({
    Params? params,
    List<int>? data,
  }) =>
      Table(
        params: params ?? this.params,
        data: data ?? this.data,
      );

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        params: Params.fromJson(json["Params"]),
        data: List<int>.from(json["Data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Params": params?.toJson(),
        "Data": List<dynamic>.from(data!.map((x) => x)),
      };
}

class Params {
  Params({
    required this.poly,
    required this.init,
    required this.refIn,
    required this.refOut,
    required this.xorOut,
    required this.check,
    required this.name,
  });

  int poly;
  int init;
  bool refIn;
  bool refOut;
  int xorOut;
  int check;
  String name;

  Params copyWith({
    int? poly,
    int? init,
    bool? refIn,
    bool? refOut,
    int? xorOut,
    int? check,
    String? name,
  }) =>
      Params(
        poly: poly ?? this.poly,
        init: init ?? this.init,
        refIn: refIn ?? this.refIn,
        refOut: refOut ?? this.refOut,
        xorOut: xorOut ?? this.xorOut,
        check: check ?? this.check,
        name: name ?? this.name,
      );

  factory Params.fromJson(Map<String, dynamic> json) => Params(
        poly: json["poly"],
        init: json["init"],
        refIn: json["refIn"],
        refOut: json["refOut"],
        xorOut: json["xorOut"],
        check: json["check"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "poly": poly,
        "init": init,
        "refIn": refIn,
        "refOut": refOut,
        "xorOut": xorOut,
        "check": check,
        "name": name,
      };
}

// checksum res
class ChecksumRes {
    ChecksumRes({
       required this.value,
        this.err,
    });

    int value;
    String? err;

    ChecksumRes copyWith({
        required int value,
        String? err,
    }) => 
        ChecksumRes(
            value: value ,
            err: err ?? this.err,
        );

    factory ChecksumRes.fromJson(Map<String, dynamic> json) => ChecksumRes(
        value: json["value"],
        err: json["err"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "err": err,
    };
}


// func res

class FuncRes {
  FuncRes({
    this.func,
    required this.value,
    this.err,
  });

  String? func;
  int value;
  String? err;

  FuncRes copyWith({
    String? func,
    required int value,
    String? err,
  }) =>
      FuncRes(
        func: func ?? this.func,
        value: value,
        err: err ?? this.err,
      );

  factory FuncRes.fromJson(Map<String, dynamic> json) => FuncRes(
        func: json["func"],
        value: json["value"],
        err: json["err"],
      );

  Map<String, dynamic> toJson() => {
        "func": func,
        "value": value,
        "err": err,
      };
}
