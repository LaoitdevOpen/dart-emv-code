import 'package:emvqrcode/src/cpm/set_emv_cpm/application_template.dart';
import 'package:emvqrcode/src/cpm/set_emv_cpm/common_data_template.dart';
import 'package:emvqrcode/src/models/cmp/application_template_model.dart';
import 'package:emvqrcode/src/models/cmp/common_data_template_model.dart';

class CPM {
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
}
