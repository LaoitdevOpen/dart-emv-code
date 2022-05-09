import 'package:emvqrcode/src/models/cmp/ber_tvl.dart';

class CommonDataTemplate {
  BerTvl? _berTvl;
  final List<BerTvl> _commonDataTransparentTemplates = [];

  BerTvl? get berTvl => _berTvl;

  List<BerTvl>? get commonDataTransparentTemplates =>
      _commonDataTransparentTemplates;

  addCommonDataTransparentTemplates(BerTvl berTvl) {
    _commonDataTransparentTemplates.add(berTvl);
  }

  setBerTvl(BerTvl? berTvl) {
    _berTvl = berTvl;
  }
}
