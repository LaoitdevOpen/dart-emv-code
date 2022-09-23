import '../../models/cmp/application_template_model.dart';
import '../../models/cmp/common_data_template_model.dart';
import 'application_template.dart';
import 'common_data_template.dart';

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
