import '../../models/cmp/ber_tvl.dart';

class ApplicationTemplate {
  BerTvl? _berTvl;
  final List<BerTvl> _applicationSpecificTransparentTemplates = [];

  BerTvl? get berTvl => _berTvl;

  List<BerTvl> get applicationSpecificTransparentTemplates =>
      _applicationSpecificTransparentTemplates;

  void addApplicationSpecificTransparentTemplates(BerTvl berTvl) {
    _applicationSpecificTransparentTemplates.add(berTvl);
  }

  void setBerTvl(BerTvl? berTvl) {
    _berTvl = berTvl;
  }
}
