import 'package:emvqrcode/src/models/cmp/ber_tvl.dart';

class ApplicationTemplateModel {
  ApplicationTemplateModel(
      {this.berTvl, this.applicationSpecificTransparentTemplates});

  BerTvl? berTvl;
  List<BerTvl>? applicationSpecificTransparentTemplates;

  ApplicationTemplateModel copyWith(
          {BerTvl? berTvl,
          List<BerTvl>? applicationSpecificTransparentTemplates}) =>
      ApplicationTemplateModel(
          berTvl: berTvl ?? this.berTvl,
          applicationSpecificTransparentTemplates:
              applicationSpecificTransparentTemplates ??
                  this.applicationSpecificTransparentTemplates);

  factory ApplicationTemplateModel.fromJson(Map<String, dynamic> json) =>
      ApplicationTemplateModel(
        berTvl: json["BERTLV"],
        applicationSpecificTransparentTemplates: List<BerTvl>.from(
            json["ApplicationSpecificTransparentTemplates"]
                .map((x) => BerTvl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "BERTLV": berTvl?.toJson(),
        "ApplicationSpecificTransparentTemplates":
            applicationSpecificTransparentTemplates == null
                ? []
                : List<dynamic>.from(
                    applicationSpecificTransparentTemplates!.map((x) => x.toJson())),
      };
}
