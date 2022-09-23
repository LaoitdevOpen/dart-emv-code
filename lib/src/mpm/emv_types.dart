import 'dart:convert';

import 'package:emvqrcode/src/constants/additional_id.dart';
import 'package:emvqrcode/src/constants/emv_id.dart';
import 'package:emvqrcode/src/constants/merchant_account_information_id.dart';
import 'package:emvqrcode/src/constants/merchant_information_id.dart';
import 'package:emvqrcode/src/constants/unreserved_template_id.dart';
import 'package:emvqrcode/src/crc16/crc16.dart';
import 'package:emvqrcode/src/errors/emv_error_model.dart';
import 'package:emvqrcode/src/errors/emv_pattern_err.dart';
import 'package:emvqrcode/src/models/additoinal_data_field_template.dart';
import 'package:emvqrcode/src/models/emv_decode_model.dart';
import 'package:emvqrcode/src/models/emv_encode_mode.dart';
import 'package:emvqrcode/src/models/emvqr_model.dart';
import 'package:emvqrcode/src/models/merchant_account_information.dart';
import 'package:emvqrcode/src/models/merchant_information_langage_template.dart';
import 'package:emvqrcode/src/models/parser_model.dart';
import 'package:emvqrcode/src/models/tlv_model.dart';
import 'package:emvqrcode/src/models/unreserved_template.dart';
import 'package:emvqrcode/src/mpm/emv_parser.dart';

// ========================  emv decode ==============================
EMVDeCode parseEMVQR(String payload) {
  TLVModel? payloadFormatIndicator;
  TLVModel? pointOfInitiationMethod;
  Map<String, MerchantAccountInformationModel>? merchantAccountInformation = {};
  TLVModel? merchantCategoryCode;
  TLVModel? transactionCurrency;
  TLVModel? transactionAmount;
  TLVModel? tipOrConvenienceIndicator;
  TLVModel? valueOfConvenienceFeeFixed;
  TLVModel? valueOfConvenienceFeePercentage;
  TLVModel? countryCode;
  TLVModel? merchantName;
  TLVModel? merchantCity;
  TLVModel? postalCode;
  AdditionalDataFieldTemplateModel? additionalDataFieldTemplate;
  TLVModel? crc;
  MerchantInformationLanguageTemplateModel? merchantInformationLanguageTemplate;
  List<TLVModel> rfuForEMVCo = [];
  Map<String, UnreservedTemplateModel>? unreservedTemplates = {};

  ParserModel p = newParser(payload);
  EmvqrModel emvqr = EmvqrModel();

  while (next(p)) {
    String? id = pid(p);
    String? value = pValue(p);

    switch (id) {
      case ID.payloadFormatIndicator:
        payloadFormatIndicator = setTLV(value, id);
        break;
      case ID.pointOfInitiationMethod:
        pointOfInitiationMethod = setTLV(value, id);
        break;
      case ID.merchantCategoryCode:
        merchantCategoryCode = setTLV(value, id);
        break;
      case ID.transactionCurrency:
        transactionCurrency = setTLV(value, id);
        break;
      case ID.transactionAmount:
        transactionAmount = setTLV(value, id);
        break;
      case ID.tipOrConvenienceIndicator:
        tipOrConvenienceIndicator = setTLV(value, id);
        break;
      case ID.valueOfConvenienceFeeFixed:
        valueOfConvenienceFeeFixed = setTLV(value, id);
        break;
      case ID.valueOfConvenienceFeePercentage:
        valueOfConvenienceFeePercentage = setTLV(value, id);
        break;
      case ID.countryCode:
        countryCode = setTLV(value, id);
        break;
      case ID.merchantName:
        merchantName = setTLV(value, id);
        break;
      case ID.merchantCity:
        merchantCity = setTLV(value, id);
        break;
      case ID.postalCode:
        postalCode = setTLV(value, id);
        break;
      case ID.additionalDataFieldTemplate:
        final additionalValue = _parseAdditionalDataFieldTemplate(value);
        additionalDataFieldTemplate =
            _setAdditionalDataFieldTemplate(additionalValue);
        break;
      case ID.crc:
        crc = setTLV(value, id);
        break;
      case ID.merchantInformationLanguageTemplate:
        final merchantInfoLanguageTemplateValue =
            _parseMerchantInformationLanguageTemplate(value);
        merchantInformationLanguageTemplate =
            _setMerchantInformationLanguageTemplate(
                merchantInfoLanguageTemplateValue);

        break;

      default:
        Map<String, dynamic> betweenRes;
        betweenRes = between(id, ID.merchantAccountInformationRangeStart,
            ID.merchantAccountInformationRangeEnd);
        if (betweenRes["within"]) {
          MerchantAccountInformationValue merchantValue =
              _parseMerchantAccountInformation(value);
          MerchantAccountInformationModel mTLV =
              _addMerchantAccountInformation(id, merchantValue);
          merchantAccountInformation[id] = mTLV;
          break;
        }
        betweenRes =
            between(id, ID.rfuForEMVCoRangeStart, ID.rfuForEMVCoRangeEnd);
        if (betweenRes["err"] != null) {
          return EMVDeCode(
              emvqr: null,
              error: EmvError(
                  type: EmvErrorType.notEmvType, message: betweenRes["err"]));
        }
        if (betweenRes["within"]) {
          TLVModel tlv = setTLV(value, id);
          rfuForEMVCo.add(tlv);
          break;
        }

        betweenRes = between(id, ID.unreservedTemplatesRangeStart,
            ID.unreservedTemplatesRangeEnd);
        if (betweenRes["err"] != null) {
          return EMVDeCode(
              emvqr: null,
              error: EmvError(
                  type: EmvErrorType.notEmvType, message: betweenRes["err"]));
        }
        if (betweenRes["within"]) {
          UnreservedTemplateValue unreservedTemplate =
              _parseUnreservedTemplate(value);
          UnreservedTemplateModel uTLV =
              _addUnreservedTemplates(id, unreservedTemplate);
          unreservedTemplates[id] = uTLV;
          break;
        }
    }
  }

  emvqr = EmvqrModel(
      payloadFormatIndicator: payloadFormatIndicator,
      pointOfInitiationMethod: pointOfInitiationMethod,
      merchantAccountInformation: merchantAccountInformation,
      merchantCategoryCode: merchantCategoryCode,
      transactionCurrency: transactionCurrency,
      transactionAmount: transactionAmount,
      tipOrConvenienceIndicator: tipOrConvenienceIndicator,
      valueOfConvenienceFeeFixed: valueOfConvenienceFeeFixed,
      valueOfConvenienceFeePercentage: valueOfConvenienceFeePercentage,
      countryCode: countryCode,
      merchantName: merchantName,
      merchantCity: merchantCity,
      postalCode: postalCode,
      additionalDataFieldTemplate: additionalDataFieldTemplate,
      crc: crc,
      merchantInformationLanguageTemplate: merchantInformationLanguageTemplate,
      rfuForEmvCo: rfuForEMVCo,
      unreservedTemplates: unreservedTemplates);
  return EMVDeCode(emvqr: emvqr, error: null);
}

String getValueLength(String value) {
  return "${utf8.encode(value).length}".padLeft(2, '0');
}

/// set tlv value

TLVModel setTLV(String v, String id) {
  TLVModel tlv = TLVModel(tag: id, length: getValueLength(v), value: v);
  return tlv;
}

String tlvToString(TLVModel? tlv) {
  if (tlv != null && tlv.tag != null && tlv.tag != null && tlv.tag != null) {
    return "${tlv.tag}${tlv.length}${tlv.value}";
  }
  return "";
}

Map<String, dynamic> between(String id, String start, String end) {
  int idNum;
  int startNum;
  int endNum;

  try {
    idNum = int.parse(id);
    startNum = int.parse(start);
    endNum = int.parse(end);
  } catch (e) {
    return {
      "within": false,
      "err": CheckEmvTypeErr().message,
    };
  }
  return {
    "within": idNum >= startNum && idNum <= endNum,
    "err": null,
  };
}

AdditionalDataFieldTemplateValue _parseAdditionalDataFieldTemplate(
    String payLoad) {
  ParserModel p = newParser(payLoad);

  // AdditionalDataFieldTemplate data
  TLVModel? billNumber;
  TLVModel? mobileNumber;
  TLVModel? storeLabel;
  TLVModel? loyaltyNumber;
  TLVModel? referenceLabel;
  TLVModel? customerLabel;
  TLVModel? terminalLabel;
  TLVModel? purposeTransaction;
  TLVModel? additionalConsumerDataRequest;
  TLVModel? merchantTaxId;
  TLVModel? merchantChannel;
  List<TLVModel> rfuForEMVCo = [];
  List<TLVModel> paymentSystemSpecific = [];

  while (next(p)) {
    String id = pid(p);
    String value = pValue(p);
    switch (id) {
      case AdditionalID.billNumber:
        billNumber = setTLV(value, id);
        break;
      case AdditionalID.mobileNumber:
        mobileNumber = setTLV(value, id);
        break;
      case AdditionalID.storeLabel:
        storeLabel = setTLV(value, id);
        break;
      case AdditionalID.loyaltyNumber:
        loyaltyNumber = setTLV(value, id);
        break;
      case AdditionalID.referenceLabel:
        referenceLabel = setTLV(value, id);
        break;
      case AdditionalID.customerLabel:
        customerLabel = setTLV(value, id);
        break;
      case AdditionalID.terminalLabel:
        terminalLabel = setTLV(value, id);
        break;
      case AdditionalID.purposeTransaction:
        purposeTransaction = setTLV(value, id);
        break;
      case AdditionalID.additionalConsumerDataRequest:
        additionalConsumerDataRequest = setTLV(value, id);
        break;
      case AdditionalID.merchantTaxId:
        merchantTaxId = setTLV(value, id);
        break;
      case AdditionalID.merchantChannel:
        merchantChannel = setTLV(value, id);
        break;
      default:
        Map<String, dynamic> betweenRes;
        betweenRes = between(id, AdditionalID.rfuForEMVCoRangeStart,
            AdditionalID.rfuForEMVCoRangeEnd);
        if (betweenRes["within"]) {
          TLVModel tlv = setTLV(value, id);
          rfuForEMVCo.add(tlv);
          break;
        }
        betweenRes = between(
            id,
            AdditionalID.paymentSystemSpecificTemplatesRangeStart,
            AdditionalID.paymentSystemSpecificTemplatesRangeEnd);
        if (betweenRes["within"]) {
          TLVModel tlv = setTLV(value, id);
          paymentSystemSpecific.add(tlv);
          break;
        }
    }
  }

  return AdditionalDataFieldTemplateValue(
    billNumber: billNumber,
    mobileNumber: mobileNumber,
    storeLabel: storeLabel,
    loyaltyNumber: loyaltyNumber,
    referenceLabel: referenceLabel,
    customerLabel: customerLabel,
    terminalLabel: terminalLabel,
    purposeTransaction: purposeTransaction,
    additionalConsumerDataRequest: additionalConsumerDataRequest,
    merchantTaxId: merchantTaxId,
    merchantChannel: merchantChannel,
    rfuForEMVCo: rfuForEMVCo,
    paymentSystemSpecific: paymentSystemSpecific,
  );
}

AdditionalDataFieldTemplateModel _setAdditionalDataFieldTemplate(
    AdditionalDataFieldTemplateValue value) {
  String billNumber = tlvToString(value.billNumber);
  String mobileNumber = tlvToString(value.mobileNumber);
  String storeLabel = tlvToString(value.storeLabel);
  String loyaltyNumber = tlvToString(value.loyaltyNumber);
  String referenceLabel = tlvToString(value.referenceLabel);
  String customerLabel = tlvToString(value.customerLabel);
  String terminalLabel = tlvToString(value.terminalLabel);
  String purposeTransaction = tlvToString(value.purposeTransaction);
  String additionalConsumerDataRequest =
      tlvToString(value.additionalConsumerDataRequest);
  String merchantTaxId = tlvToString(value.merchantTaxId);
  String merchantChannel = tlvToString(value.merchantChannel);

  String rfuForEMVCo = "";
  value.rfuForEMVCo?.forEach((element) {
    rfuForEMVCo += tlvToString(element);
  });

  String paymentSystemSpecific = "";
  value.paymentSystemSpecific?.forEach((element) {
    paymentSystemSpecific += tlvToString(element);
  });
  String length = getValueLength(billNumber +
      mobileNumber +
      storeLabel +
      loyaltyNumber +
      referenceLabel +
      customerLabel +
      terminalLabel +
      purposeTransaction +
      additionalConsumerDataRequest +
      merchantTaxId +
      merchantChannel +
      rfuForEMVCo +
      paymentSystemSpecific);
  AdditionalDataFieldTemplateModel additionalDataFieldTemplate =
      AdditionalDataFieldTemplateModel(
          tag: ID.additionalDataFieldTemplate, length: length, value: value);
  return additionalDataFieldTemplate;
}

MerchantInformationLanguageTemplateValue
    _parseMerchantInformationLanguageTemplate(String payLoad) {
  ParserModel p = newParser(payLoad);

  // AdditionalDataFieldTemplate data
  TLVModel? languagePreference;
  TLVModel? merchantName;
  TLVModel? merchantCity;
  List<TLVModel> rfuForEMVCo = [];

  while (next(p)) {
    String id = pid(p);
    String value = pValue(p);
    switch (id) {
      case MerchantInformationID.languagePreference:
        languagePreference = setTLV(value, id);
        break;
      case MerchantInformationID.merchantName:
        merchantName = setTLV(value, id);
        break;
      case MerchantInformationID.merchantCity:
        merchantCity = setTLV(value, id);
        break;
      default:
        Map<String, dynamic> betweenRes;
        betweenRes = between(id, MerchantInformationID.rfuForEMVCoRangeStart,
            MerchantInformationID.rfuForEMVCoRangeEnd);
        if (betweenRes["within"]) {
          TLVModel tlv = setTLV(value, id);
          rfuForEMVCo.add(tlv);
          continue;
        }
    }
  }
  MerchantInformationLanguageTemplateValue value =
      MerchantInformationLanguageTemplateValue(
          languagePreference: languagePreference,
          merchantName: merchantName,
          merchantCity: merchantCity,
          rfuForEMVCo: rfuForEMVCo);

  return value;
}

MerchantInformationLanguageTemplateModel
    _setMerchantInformationLanguageTemplate(
        MerchantInformationLanguageTemplateValue value) {
  String languagePreference = tlvToString(value.languagePreference);
  String merchantName = tlvToString(value.merchantName);
  String merchantCity = tlvToString(value.merchantCity);
  String rfuForEMVCo = "";
  value.rfuForEMVCo?.forEach((element) {
    rfuForEMVCo += tlvToString(element);
  });
  MerchantInformationLanguageTemplateModel merchantInfoLanguageTemplate =
      MerchantInformationLanguageTemplateModel(
          tag: ID.merchantInformationLanguageTemplate,
          length: getValueLength(
              languagePreference + merchantName + merchantCity + rfuForEMVCo),
          value: value);

  return merchantInfoLanguageTemplate;
}

MerchantAccountInformationValue _parseMerchantAccountInformation(
    String payLoad) {
  ParserModel p = newParser(payLoad);

  // AdditionalDataFieldTemplate data
  TLVModel? globallyUniqueIdentifier;
  List<TLVModel> paymentNetworkSpecific = [];
  while (next(p)) {
    String id = pid(p);
    String value = pValue(p);
    switch (id) {
      case MerchantAccountInformationID.globallyUniqueIdentifier:
        globallyUniqueIdentifier = setTLV(value, id);
        break;
      default:
        Map<String, dynamic> betweenRes;
        betweenRes = between(
            id,
            MerchantAccountInformationID.paymentNetworkSpecificStart,
            MerchantAccountInformationID.paymentNetworkSpecificEnd);
        if (betweenRes["within"]) {
          TLVModel tlv = setTLV(value, id);
          paymentNetworkSpecific.add(tlv);
          continue;
        }
    }
  }

  return MerchantAccountInformationValue(
    globallyUniqueIdentifier: globallyUniqueIdentifier,
    paymentNetworkSpecific: paymentNetworkSpecific,
  );
}

MerchantAccountInformationModel _addMerchantAccountInformation(
    String id, MerchantAccountInformationValue value) {
  String _globally =
      "${value.globallyUniqueIdentifier?.tag}${value.globallyUniqueIdentifier?.length}${value.globallyUniqueIdentifier?.value}";
  String _payment = "";
  value.paymentNetworkSpecific?.forEach((element) {
    _payment += "${element.tag}${element.length}${element.value}";
  });

  MerchantAccountInformationModel mTLV = MerchantAccountInformationModel(
      tag: id, length: getValueLength(_globally + _payment), value: value);
  return mTLV;
}

UnreservedTemplateValue _parseUnreservedTemplate(String payLoad) {
  ParserModel p = newParser(payLoad);

  // AdditionalDataFieldTemplate data
  TLVModel? globallyUniqueIdentifier;
  List<TLVModel> contextSpecificData = [];
  while (next(p)) {
    String id = pid(p);
    String value = pValue(p);
    switch (id) {
      case UnreservedTemplateID.globallyUniqueIdentifier:
        globallyUniqueIdentifier = setTLV(value, id);
        break;
      default:
        Map<String, dynamic> betweenRes;
        betweenRes = between(id, UnreservedTemplateID.contextSpecificDataStart,
            UnreservedTemplateID.contextSpecificDataEnd);
        if (betweenRes["within"]) {
          TLVModel tlv = setTLV(value, id);
          contextSpecificData.add(tlv);
          continue;
        }
    }
  }

  return UnreservedTemplateValue(
    globallyUniqueIdentifier: globallyUniqueIdentifier,
    contextSpecificData: contextSpecificData,
  );
}

UnreservedTemplateModel _addUnreservedTemplates(
    String id, UnreservedTemplateValue value) {
  String _globally =
      "${value.globallyUniqueIdentifier?.tag}${value.globallyUniqueIdentifier?.length}${value.globallyUniqueIdentifier?.value}";
  String _contextSpec = "";
  value.contextSpecificData?.forEach((element) {
    _contextSpec += "${element.tag}${element.length}${element.value}";
  });
  UnreservedTemplateModel uTLV = UnreservedTemplateModel(
    tag: id,
    length: getValueLength(_globally + _contextSpec),
    value: value,
  );
  return uTLV;
}

// ============================ emv encode ========================================
EmvEncode generatePayload(EmvqrModel emv) {
  String s = "";
  try {
    s += tlvToString(emv.payloadFormatIndicator);
    s += tlvToString(emv.pointOfInitiationMethod);
    List<String> keys = [];

    if (emv.merchantAccountInformation != null) {
      final merchantAccountInformation = emv.merchantAccountInformation ?? {};
      merchantAccountInformation.forEach((key, value) {
        keys.add(key);
      });
    }

    keys.sort();
    for (var key in keys) {
      final merchantAcInfo = emv.merchantAccountInformation?.entries
          .firstWhere((element) => element.key == key);

      String _globallyUnique =
          tlvToString(merchantAcInfo?.value.value?.globallyUniqueIdentifier);
      String _paymentNS = "";
      merchantAcInfo?.value.value?.paymentNetworkSpecific?.forEach((tlv) {
        _paymentNS += tlvToString(tlv);
      });
      s +=
          "${merchantAcInfo?.value.tag}${merchantAcInfo?.value.length}$_globallyUnique$_paymentNS";
    }
    s += tlvToString(emv.merchantCategoryCode);
    s += tlvToString(emv.transactionCurrency);
    s += tlvToString(emv.transactionAmount);
    s += tlvToString(emv.tipOrConvenienceIndicator);
    s += tlvToString(emv.valueOfConvenienceFeeFixed);
    s += tlvToString(emv.valueOfConvenienceFeePercentage);
    s += tlvToString(emv.countryCode);
    s += tlvToString(emv.merchantName);
    s += tlvToString(emv.merchantCity);
    s += tlvToString(emv.postalCode);

    // addition data
    s += _additionalTemplateToString(emv.additionalDataFieldTemplate);

    // merchant Info Language Template
    s += _merchantInfoLanguageTemplateToStrng(
        emv.merchantInformationLanguageTemplate);

    // rfu
    emv.rfuForEmvCo?.forEach((tlv) {
      s += tlvToString(tlv);
    });

    // unreserverved templates
    emv.unreservedTemplates?.forEach((key, value) {
      if (value.tag != null && value.length != null && value.value != null) {
        s += value.tag ?? "";
        s += value.length ?? "";
        s += tlvToString(value.value?.globallyUniqueIdentifier);
        value.value?.contextSpecificData?.forEach((element) {
          s += tlvToString(element);
        });
      }
    });

    final crcFormat = _formatCrc(s);

    if (crcFormat["err"] != null) {
      return EmvEncode(
          value: s,
          error: EmvError(
              message: "generate emvqr error",
              type: EmvErrorType.generateQrErr));
    }

    s += crcFormat["value"];
    return EmvEncode(value: s, error: null);
  } catch (e) {
    return EmvEncode(
        value: null,
        error: EmvError(
            message: "generate qr error ", type: EmvErrorType.generateQrErr));
  }
}

// additional templete to string
String _additionalTemplateToString(AdditionalDataFieldTemplateModel? value) {
  if (value != null &&
      value.tag != null &&
      value.length != null &&
      value.value != null) {
    String billNumber = tlvToString(value.value?.billNumber);
    String mobileNumber = tlvToString(value.value?.mobileNumber);
    String storeLabel = tlvToString(value.value?.storeLabel);
    String loyaltyNumber = tlvToString(value.value?.loyaltyNumber);
    String referenceLabel = tlvToString(value.value?.referenceLabel);
    String customerLabel = tlvToString(value.value?.customerLabel);
    String terminalLabel = tlvToString(value.value?.terminalLabel);
    String purposeTransaction = tlvToString(value.value?.purposeTransaction);
    String additionalConsumerDataRequest =
        tlvToString(value.value?.additionalConsumerDataRequest);
    String merchantTaxId = tlvToString(value.value?.merchantTaxId);
    String merchantChannel = tlvToString(value.value?.merchantChannel);

    String rfuForEMVCo = "";
    value.value?.rfuForEMVCo?.forEach((element) {
      rfuForEMVCo += tlvToString(element);
    });

    String paymentSystemSpecific = "";
    value.value?.paymentSystemSpecific?.forEach((element) {
      paymentSystemSpecific += tlvToString(element);
    });
    String additionStr = billNumber +
        mobileNumber +
        storeLabel +
        loyaltyNumber +
        referenceLabel +
        customerLabel +
        terminalLabel +
        purposeTransaction +
        additionalConsumerDataRequest +
        merchantTaxId +
        merchantChannel +
        rfuForEMVCo +
        paymentSystemSpecific;

    return "${value.tag}${value.length}$additionStr";
  } else {
    return '';
  }
}

// merchant info language to string
String _merchantInfoLanguageTemplateToStrng(
    MerchantInformationLanguageTemplateModel? merchantInfoLang) {
  if (merchantInfoLang != null &&
      merchantInfoLang.tag != null &&
      merchantInfoLang.value != null) {
    final mInfo = merchantInfoLang.value;

    String languagePreference = tlvToString(mInfo?.languagePreference);
    String merchantName = tlvToString(mInfo?.merchantName);
    String merchantCity = tlvToString(mInfo?.merchantCity);
    String rfuForEMVCo = "";

    mInfo?.rfuForEMVCo?.forEach((tlv) {
      rfuForEMVCo += tlvToString(tlv);
    });
    String mStr =
        languagePreference + merchantName + merchantCity + rfuForEMVCo;
    return "${merchantInfoLang.tag}${merchantInfoLang.length}$mStr";
  } else {
    return "";
  }
}

Map<String, dynamic> _formatCrc(String value) {
  // checksum
  final crcValue = CRC16().checkSum(utf8.encode("$value${ID.crc}04"));

  if (crcValue.err != null) {
    return {"value": null, "err": crcValue.err};
  } else {
    var crcValueString = crcValue.value.toRadixString(16);
    for (var i = crcValueString.length; i < 4; i++) {
      crcValueString = "0$crcValueString";
    }
    return {"value": format(ID.crc, crcValueString.toUpperCase()), "err": null};
  }
}

String format(String id, String value) {
  final valueLength = "${utf8.encode(value).length}".padLeft(2, '0');
  return "$id$valueLength$value".trim();
}

/// verify emvqr
///
/// check if emv data is true
bool verifyEmvQr(String value) {
  final emqrForChecksum = value.substring(0, value.length - 4);
  final emqrForCheckEmv = value.substring(value.length - 4, value.length);
  final checksum = CRC16().checkSum(utf8.encode(emqrForChecksum));

  if (checksum.err != null) {
    return false;
  }
  var checkSumValue = checksum.value.toRadixString(16);

  for (var i = checkSumValue.length; i < 4; i++) {
    checkSumValue = "0$checkSumValue";
  }
  return emqrForCheckEmv == checkSumValue.toUpperCase();
}
