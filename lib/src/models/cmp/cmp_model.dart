import 'package:emvqrcode/src/models/cmp/application_template_model.dart';
import 'package:emvqrcode/src/models/cmp/common_data_template_model.dart';

class CpmModel {
  CpmModel(
      {this.dataPayloadFormatIndicator,
      this.applicationTemplates,
      this.commonDataTemplates});

  String? dataPayloadFormatIndicator;
  List<ApplicationTemplateModel>? applicationTemplates;
  List<CommonDataTemplateModel>? commonDataTemplates;

  CpmModel copyWith({
    String? dataPayloadFormatIndicator,
    List<ApplicationTemplateModel>? applicationTemplates,
    List<CommonDataTemplateModel>? commonDataTemplates,
  }) =>
      CpmModel(
        dataPayloadFormatIndicator:
            dataPayloadFormatIndicator ?? this.dataPayloadFormatIndicator,
        applicationTemplates: applicationTemplates ?? this.applicationTemplates,
        commonDataTemplates: commonDataTemplates ?? this.commonDataTemplates,
      );

  factory CpmModel.fromJson(Map<String, dynamic> json) => CpmModel(
      dataPayloadFormatIndicator: json["DataPayloadFormatIndicator"],
      applicationTemplates: List<ApplicationTemplateModel>.from(
          json["ApplicationTemplates"]
              .map((x) => ApplicationTemplateModel.fromJson(x))),
      commonDataTemplates: List<CommonDataTemplateModel>.from(
          json["CommonDataTemplates"]
              .map((x) => CommonDataTemplateModel.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "DataPayloadFormatIndicator": dataPayloadFormatIndicator,
        "ApplicationTemplates": applicationTemplates == null
            ? []
            : List<dynamic>.from(applicationTemplates!.map((x) => x.toJson())),
        "CommonDataTemplates": commonDataTemplates == null
            ? []
            : List<dynamic>.from(commonDataTemplates!.map((x) => x.toJson())),
      };
}
