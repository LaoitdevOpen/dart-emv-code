import 'ber_tvl.dart';

class CommonDataTemplateModel {
  CommonDataTemplateModel({this.berTvl, this.commonDataTransparentTemplates});

  BerTvl? berTvl;
  List<BerTvl>? commonDataTransparentTemplates;

  CommonDataTemplateModel copyWith(
          {BerTvl? berTvl, List<BerTvl>? commonDataTransparentTemplates}) =>
      CommonDataTemplateModel(
          berTvl: berTvl ?? this.berTvl,
          commonDataTransparentTemplates: commonDataTransparentTemplates ??
              this.commonDataTransparentTemplates);

  factory CommonDataTemplateModel.fromJson(Map<String, dynamic> json) =>
      CommonDataTemplateModel(
        berTvl: json["BERTLV"],
        commonDataTransparentTemplates: List<BerTvl>.from(
            json["CommonDataTransparentTemplates"]
                .map((x) => BerTvl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "BERTLV": berTvl?.toJson(),
        "CommonDataTransparentTemplates": commonDataTransparentTemplates == null
            ? []
            : List<dynamic>.from(
                commonDataTransparentTemplates!.map((x) => x.toJson())),
      };
}
