import '../../../models/cpm/application_template_model.dart';
import '../../../models/cpm/common_data_template_model.dart';
import 'application_template.dart';
import 'common_data_template.dart';

class CPMQR {
  String? _dataPayloadFormatIndicator;
  final List<ApplicationTemplateModel> _applicationTemplates = [];
  final List<CommonDataTemplateModel> _commonDataTemplates = [];

  String? get dataPayloadFormatIndicator => _dataPayloadFormatIndicator;
  List<ApplicationTemplateModel> get applicationTemplates =>
      _applicationTemplates;
  List<CommonDataTemplateModel> get commonDataTemplates => _commonDataTemplates;

  setDataPayloadFormatIndicator(String value) {
    _dataPayloadFormatIndicator = value;
  }

  addApplicationTemplate(ApplicationTemplate applicationTemplate) {
    _applicationTemplates.add(ApplicationTemplateModel(
        berTvl: applicationTemplate.berTvl,
        applicationSpecificTransparentTemplates:
            applicationTemplate.applicationSpecificTransparentTemplates));
  }

  addCommonDataTemplate(CommonDataTemplate commonDataTemplate) {
    _commonDataTemplates.add(CommonDataTemplateModel(
      berTvl: commonDataTemplate.berTvl,
      commonDataTransparentTemplates:
          commonDataTemplate.commonDataTransparentTemplates,
    ));
  }

  Map<String, dynamic> toJson() => {
        "DataPayloadFormatIndicator": _dataPayloadFormatIndicator,
        "ApplicationTemplates": _applicationTemplates.isEmpty
            ? _applicationTemplates
            : List<dynamic>.from(_applicationTemplates.map((x) => x.toJson())),
        "CommonDataTemplates": _commonDataTemplates.isEmpty
            ? _commonDataTemplates
            : List<dynamic>.from(_commonDataTemplates.map((x) => x.toJson())),
      };
}
