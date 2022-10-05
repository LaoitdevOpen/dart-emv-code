import 'dart:convert';

import 'package:convert/convert.dart';

import '../../constants/cpm/id.dart';
import '../../constants/cpm/tag.dart';
import '../../models/cpm/ber_tvl.dart';
import 'set_emv_cpm/cpm_emv.dart';

/// emv mpm (Consumer Presented Mode)
class EMVCPM {
  String? generatePayload(CPMQR cpm) {
    try {
      String payload = "";
      payload += _formatBerTvlVal(
            id: ID.payloadFormatIndicator,
            value: _toHex(cpm.dataPayloadFormatIndicator),
          ) ??
          "";
      if (cpm.applicationTemplates.isNotEmpty) {
        for (var applicationTemplate in cpm.applicationTemplates) {
          String _applicationTemplate =
              _formattingTemplate(applicationTemplate.berTvl ?? BerTvl()) ?? "";

          if (applicationTemplate.applicationSpecificTransparentTemplates !=
              null) {
            final specificTransparentTemplates =
                applicationTemplate.applicationSpecificTransparentTemplates ??
                    [];
            for (var specificTransparentTemplate
                in specificTransparentTemplates) {
              String _specificTransparentTemplate =
                  _formattingTemplate(specificTransparentTemplate) ?? "";
              _applicationTemplate += _formatBerTvlVal(
                      id: ID.applicationSpecificTransparentTemplate,
                      value: _specificTransparentTemplate) ??
                  "";
            }
          }
          payload += _formatBerTvlVal(
                  id: ID.applicationTemplate, value: _applicationTemplate) ??
              "";
        }
      }
      if (cpm.commonDataTemplates.isNotEmpty) {
        for (var commonDataTemplate in cpm.commonDataTemplates) {
          String _commonDataTemplate =
              _formattingTemplate(commonDataTemplate.berTvl ?? BerTvl()) ?? "";
          if (commonDataTemplate.commonDataTransparentTemplates != null) {
            final transparentTemplates =
                commonDataTemplate.commonDataTransparentTemplates ?? [];
            for (var transparentTemplate in transparentTemplates) {
              String _transparentTemplate =
                  _formattingTemplate(transparentTemplate) ?? "";
              _commonDataTemplate += _formatBerTvlVal(
                      id: ID.commonDataTransparentTemplate,
                      value: _transparentTemplate) ??
                  "";
            }
          }
          payload += _formatBerTvlVal(
                  id: ID.commonDataTemplate, value: _commonDataTemplate) ??
              "";
        }
      }
      final decoded = hex.decode(payload);
      payload = base64.encode(decoded);

      return payload;
    } catch (e) {
      return null;
    }
  }

  String _toHex(String? value) {
    if (value != null && value.isNotEmpty) {
      // gen byte data
      final _src = utf8.encode(value);

      // hex
      final hexCode = hex.encode(_src);
      return hexCode;
    }
    return "";
  }

  String? _formatBerTvlVal({String? id, String? value}) {
    if (id != null && id.isNotEmpty && value != null && value.isNotEmpty) {
      final length = (value.length ~/ 2);
      String hexLength = length.toRadixString(16);
      hexLength = "00" + hexLength;

      return id +
          hexLength.substring((hexLength.length - 2)).toUpperCase() +
          value;
    }
    return null;
  }

  String? _formattingTemplate(BerTvl berTvl) {
    try {
      // if (berTvl != null) {
      String template = "";
      // format file name
      if (berTvl.dataApplicationDefinitionFileName != null) {
        template += _formatBerTvlVal(
                id: TAG.applicationDefinitionFileName,
                value: berTvl.dataApplicationDefinitionFileName) ??
            "";
      }
      // format label
      if (berTvl.dataApplicationLabel != null) {
        template += _formatBerTvlVal(
                id: TAG.applicationLabel,
                value: _toHex(berTvl.dataApplicationLabel)) ??
            "";
      }

      // format label
      if (berTvl.dataTrack2EquivalentData != null) {
        template += _formatBerTvlVal(
                id: TAG.track2EquivalentData,
                value: berTvl.dataTrack2EquivalentData) ??
            "";
      }

      if (berTvl.dataApplicationPan != null) {
        template += _formatBerTvlVal(
                id: TAG.applicationPAN, value: berTvl.dataApplicationPan) ??
            "";
      }
      if (berTvl.dataCardholderName != null) {
        template += _formatBerTvlVal(
                id: TAG.cardholderName,
                value: _toHex(berTvl.dataCardholderName)) ??
            "";
      }
      if (berTvl.dataLanguagePreference != null) {
        template += _formatBerTvlVal(
                id: TAG.languagePreference,
                value: _toHex(berTvl.dataLanguagePreference)) ??
            "";
      }
      if (berTvl.dataIssuerUrl != null) {
        template += _formatBerTvlVal(
                id: TAG.issuerURL, value: _toHex(berTvl.dataIssuerUrl)) ??
            "";
      }
      if (berTvl.dataApplicationVersionNumber != null) {
        template += _formatBerTvlVal(
                id: TAG.applicationVersionNumber,
                value: berTvl.dataApplicationVersionNumber) ??
            "";
      }
      if (berTvl.dataIssuerApplicationData != null) {
        template += _formatBerTvlVal(
                id: TAG.issuerApplicationData,
                value: berTvl.dataIssuerApplicationData) ??
            "";
      }
      if (berTvl.dataTokenRequestorId != null) {
        template += _formatBerTvlVal(
                id: TAG.tokenRequestorID, value: berTvl.dataTokenRequestorId) ??
            "";
      }
      if (berTvl.dataPaymentAccountReference != null) {
        template += _formatBerTvlVal(
                id: TAG.paymentAccountReference,
                value: berTvl.dataPaymentAccountReference) ??
            "";
      }
      if (berTvl.dataLast4DigitsOfPan != null) {
        template += _formatBerTvlVal(
                id: TAG.last4DigitsOfPAN, value: berTvl.dataLast4DigitsOfPan) ??
            "";
      }
      if (berTvl.dataApplicationCryptogram != null) {
        template += _formatBerTvlVal(
                id: TAG.applicationCryptogram,
                value: berTvl.dataApplicationCryptogram) ??
            "";
      }
      if (berTvl.dataApplicationTransactionCounter != null) {
        template += _formatBerTvlVal(
                id: TAG.applicationTransactionCounter,
                value: berTvl.dataApplicationTransactionCounter) ??
            "";
      }
      if (berTvl.dataUnpredictableNumber != null) {
        template += _formatBerTvlVal(
                id: TAG.unpredictableNumber,
                value: berTvl.dataUnpredictableNumber) ??
            "";
      }
      return template;
      // }
    } catch (e) {
      return null;
    }
  }
}