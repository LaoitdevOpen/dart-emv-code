import 'dart:convert';

import 'package:emvqrcode/src/constants/additional_id.dart';
import 'package:emvqrcode/src/constants/emv_id.dart';
import 'package:emvqrcode/src/constants/merchant_account_information_id.dart';
import 'package:emvqrcode/src/constants/merchant_information_id.dart';
import 'package:emvqrcode/src/constants/unreserved_template_id.dart';
import 'package:emvqrcode/src/crc16/crc.dart';
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

/// emv decode
EMVDeCode parseEMVQR(String payload) {
  ParserModel p = newParser(payload);
  EmvqrModel emvqr = EmvqrModel();
  TLVModel? payloadFormatIndicator;
  TLVModel? pointOfInitiationMethod;
  Map<String, MerchantAccountInformationModel>? merchantAccountInformation;
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
  Map<String, UnreservedTemplateModel>? unreservedTemplates;

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
        additionalDataFieldTemplate = parseAdditionalDataFieldTemplate(value);
        break;
      case ID.crc:
        crc = setTLV(value, id);
        break;
      case ID.merchantInformationLanguageTemplate:
        merchantInformationLanguageTemplate =
            parseMerchantInformationLanguageTemplate(value);

        break;
      default:
        Map<String, dynamic> betweenRes;
        betweenRes = between(id, ID.merchantAccountInformationRangeStart,
            ID.merchantAccountInformationRangeEnd);
        if (betweenRes["err"] != null) {
          return EMVDeCode(
              emvqr: null,
              error: EmvError(
                  type: EmvErrorType.notEmvType, message: betweenRes["err"]));
        }
        if (betweenRes["within"]) {
          MerchantAccountInformationValue merchantValue =
              parseMerchantAccountInformation(value);
          MerchantAccountInformationModel mTLV =
              addMerchantAccountInformation(id, merchantValue);
          merchantAccountInformation = {id: mTLV};
          continue;
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
          continue;
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
              parseUnreservedTemplate(value);
          UnreservedTemplateModel uTLV =
              addUnreservedTemplates(id, unreservedTemplate);
          unreservedTemplates = {id: uTLV};
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

MerchantAccountInformationModel addMerchantAccountInformation(
    String id, MerchantAccountInformationValue value) {
  String _globally =
      "${value.globallyUniqueIdentifier?.tag}${value.globallyUniqueIdentifier?.length}${value.globallyUniqueIdentifier?.value}";
  String _payment = "";
  value.paymentNetworkSpecific?.forEach((element) {
    _payment += "${element.tag}${element.length}${element.value}";
  });

  MerchantAccountInformationModel mTLV = MerchantAccountInformationModel(
      tag: id, length: l(_globally + _payment), value: value);
  return mTLV;
}

UnreservedTemplateModel addUnreservedTemplates(
    String id, UnreservedTemplateValue value) {
  String _globally =
      "${value.globallyUniqueIdentifier?.tag}${value.globallyUniqueIdentifier?.length}${value.globallyUniqueIdentifier?.value}";
  String _contextSpec = "";
  value.contextSpecificData?.forEach((element) {
    _contextSpec += "${element.tag}${element.length}${element.value}";
  });
  UnreservedTemplateModel uTLV = UnreservedTemplateModel(
    tag: id,
    length: l(_globally + _contextSpec),
    value: value,
  );
  return uTLV;
}

String l(String value) {
  if (utf8.encode(value).length > 10) {
    return "${utf8.encode(value).length}";
  }
  return "0${utf8.encode(value).length}";
}

/// set tlv value

TLVModel setTLV(String v, String id) {
  TLVModel tlv = TLVModel(tag: id, length: l(v), value: v);
  return tlv;
}

String tlvToString(TLVModel? tlv) =>
    "${tlv?.tag ?? ""}${tlv?.length ?? ""}${tlv?.value ?? ""}";

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

AdditionalDataFieldTemplateModel parseAdditionalDataFieldTemplate(String payLoad) {
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
  List<TLVModel>? rfuForEMVCo;
  List<TLVModel>? paymentSystemSpecific;

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
      default:
    }
  }

  return AdditionalDataFieldTemplateModel(
    billNumber: billNumber,
    mobileNumber: mobileNumber,
    storeLabel: storeLabel,
    loyaltyNumber: loyaltyNumber,
    referenceLabel: referenceLabel,
    customerLabel: customerLabel,
    terminalLabel: terminalLabel,
    purposeTransaction: purposeTransaction,
    additionalConsumerDataRequest: additionalConsumerDataRequest,
    rfuForEMVCo: rfuForEMVCo,
    paymentSystemSpecific: paymentSystemSpecific,
  );
}

MerchantInformationLanguageTemplateModel parseMerchantInformationLanguageTemplate(
    String payLoad) {
  ParserModel p = newParser(payLoad);

  // AdditionalDataFieldTemplate data
  TLVModel? languagePreference;
  TLVModel? merchantName;
  TLVModel? merchantCity;

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
    }
  }

  return MerchantInformationLanguageTemplateModel(
    languagePreference: languagePreference,
    merchantName: merchantName,
    merchantCity: merchantCity,
  );
}

MerchantAccountInformationValue parseMerchantAccountInformation(
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

UnreservedTemplateValue parseUnreservedTemplate(String payLoad) {
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

/// emv encode
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
    s += tlvToString(emv.merchantCity);
    s += tlvToString(emv.postalCode);

    // addition data
    s += additionalTemplateToString(emv.additionalDataFieldTemplate);

    // merchant Info Language Template
    s +
        merchantInfoLanguageTemplateToStrng(
            emv.merchantInformationLanguageTemplate);

    // rfu
    emv.rfuForEmvCo?.forEach((tlv) {
      s += tlvToString(tlv);
    });

    // unreserverved templates
    emv.unreservedTemplates?.forEach((key, value) {
      s += "${value.tag}";
      s += "${value.length}";
      s += tlvToString(value.value?.globallyUniqueIdentifier);
      s += tlvToString(value.value?.globallyUniqueIdentifier);
      value.value?.contextSpecificData?.forEach((element) {
        s += tlvToString(element);
      });
    });

    final crcFormat = formatCrc(s);

    if (crcFormat["err"] != null) {
      return EmvEncode(
          value: s,
          error: EmvError(
              message: "can not get crc value",
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

// set emv value
EmvqrModel setEMVData({
  String? payloadFormatIndicator,
  String? pointOfInitiationMethod,
  Map<String, MerchantAccountInformationModel>? merchantAccountInformation,
  String? merchantCategoryCode,
  String? transactionCurrency,
  String? transactionAmount,
  String? tipOrConvenienceIndicator,
  String? valueOfConvenienceFeeFixed,
  String? valueOfConvenienceFeePercentage,
  String? countryCode,
  String? merchantName,
  String? merchantCity,
  String? postalCode,
  AdditionalDataFieldTemplateModel? additionalDataFieldTemplate,
  MerchantInformationLanguageTemplateModel? merchantInformationLanguageTemplate,
  List<TLVModel>? rfuForEmvCo,
  Map<String, UnreservedTemplateModel>? unreservedTemplates,
}) {
  ///set emv value
  ///
  // payloadLoadFormat
  var payloadFormatIndicatorTlv = payloadFormatIndicator != null
      ? setTLV(payloadFormatIndicator, ID.payloadFormatIndicator)
      : null;
  // point of initiation method
  var pointOfInitiationMethodTlv = pointOfInitiationMethod != null
      ? setTLV(pointOfInitiationMethod, ID.pointOfInitiationMethod)
      : null;
  // merchant category code
  var merchantCategoryCodeTlv = merchantCategoryCode != null
      ? setTLV(merchantCategoryCode, ID.merchantCategoryCode)
      : null;
  // transaction currency
  var transactionCurrencyTLv = transactionCurrency != null
      ? setTLV(transactionCurrency, ID.transactionCurrency)
      : null;
  // transaction amount
  var transactionAmountTlv = transactionAmount != null
      ? setTLV(transactionAmount, ID.transactionAmount)
      : null;
  var tipOrConvenienceIndicatorTlv = tipOrConvenienceIndicator != null
      ? setTLV(tipOrConvenienceIndicator, ID.tipOrConvenienceIndicator)
      : null;
  var valueOfConvenienceFeeFixedTlv = valueOfConvenienceFeeFixed != null
      ? setTLV(valueOfConvenienceFeeFixed, ID.valueOfConvenienceFeeFixed)
      : null;
  var valueOfConvenienceFeePercentageTlv = valueOfConvenienceFeePercentage !=
          null
      ? setTLV(
          valueOfConvenienceFeePercentage, ID.valueOfConvenienceFeePercentage)
      : null;
  // country code
  var countryCodeTlv = countryCode != null
      ? setTLV(countryCode.toUpperCase(), ID.countryCode)
      : null;
  // merchant name
  var merchantNameTlv =
      merchantName != null ? setTLV(merchantName, ID.merchantName) : null;
  // merchant city
  var merchantCityTlv =
      merchantCity != null ? setTLV(merchantCity, ID.merchantCity) : null;

  var postalCodeTlv =
      postalCode != null ? setTLV(postalCode, ID.postalCode) : null;

  // emv data
  EmvqrModel emvData = EmvqrModel(
    payloadFormatIndicator: payloadFormatIndicatorTlv,
    pointOfInitiationMethod: pointOfInitiationMethodTlv,
    merchantAccountInformation: merchantAccountInformation,
    merchantCategoryCode: merchantCategoryCodeTlv,
    transactionCurrency: transactionCurrencyTLv,
    transactionAmount: transactionAmountTlv,
    tipOrConvenienceIndicator: tipOrConvenienceIndicatorTlv,
    valueOfConvenienceFeeFixed: valueOfConvenienceFeeFixedTlv,
    valueOfConvenienceFeePercentage: valueOfConvenienceFeePercentageTlv,
    countryCode: countryCodeTlv,
    merchantName: merchantNameTlv,
    merchantCity: merchantCityTlv,
    postalCode: postalCodeTlv,
    additionalDataFieldTemplate: additionalDataFieldTemplate,
    merchantInformationLanguageTemplate: merchantInformationLanguageTemplate,
    rfuForEmvCo: rfuForEmvCo,
    unreservedTemplates: unreservedTemplates,
  );

  return emvData;
}

// additional templete to string
String additionalTemplateToString(
    AdditionalDataFieldTemplateModel? additionalDataFieldTemplate) {
  String billNo = tlvToString(additionalDataFieldTemplate?.billNumber);
  String mobileNo = tlvToString(additionalDataFieldTemplate?.mobileNumber);
  String storeLabel = tlvToString(additionalDataFieldTemplate?.storeLabel);
  String layaltyNo = tlvToString(additionalDataFieldTemplate?.loyaltyNumber);
  String referenceLabel =
      tlvToString(additionalDataFieldTemplate?.referenceLabel);
  String customerLabel =
      tlvToString(additionalDataFieldTemplate?.customerLabel);
  String terminalLabel =
      tlvToString(additionalDataFieldTemplate?.terminalLabel);
  String purposeTransaction =
      tlvToString(additionalDataFieldTemplate?.purposeTransaction);
  String additionalConsumerDataRequest =
      tlvToString(additionalDataFieldTemplate?.additionalConsumerDataRequest);

  String rfuForEMVCo = "";
  additionalDataFieldTemplate?.rfuForEMVCo?.forEach((tlv) {
    rfuForEMVCo += tlvToString(tlv);
  });
  String paymentSystemSpecific = "";
  additionalDataFieldTemplate?.paymentSystemSpecific?.forEach((tlv) {
    rfuForEMVCo += tlvToString(tlv);
  });

  return billNo +
      mobileNo +
      storeLabel +
      layaltyNo +
      referenceLabel +
      customerLabel +
      terminalLabel +
      purposeTransaction +
      additionalConsumerDataRequest +
      rfuForEMVCo +
      paymentSystemSpecific;
}

// merchant info language to string
merchantInfoLanguageTemplateToStrng(
    MerchantInformationLanguageTemplateModel? merchantInfoLang) {
  String languagePreference = tlvToString(merchantInfoLang?.languagePreference);
  String merchantName = tlvToString(merchantInfoLang?.merchantName);
  String merchantCity = tlvToString(merchantInfoLang?.merchantCity);
  String rfuForEMVCo = "";

  merchantInfoLang?.rfuForEMVCo?.forEach((tlv) {
    rfuForEMVCo += tlvToString(tlv);
  });

  return languagePreference + merchantName + merchantCity + rfuForEMVCo;
}

Map<String, dynamic> formatCrc(String value) {
  // create crc16 table
  var table = CRC16().makeTable(CRC().crc16CcittFalse);

  // checksum
  final crcValue = CRC16().checkSum("$value${ID.crc}04".codeUnits, table);

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
  final valueLength = utf8.encode(value).length;
  if (valueLength > 10) {
    return "$id$valueLength$value".trim();
  }
  return "${id}0$valueLength$value".trim();
}

bool checkEmvQr(String value) {
  final emqrForChecksum = value.substring(0, value.length - 4);
  final emqrForCheckEmv = value.substring(value.length - 4, value.length);
  var table = CRC16().makeTable(CRC().crc16CcittFalse);
  var checksum = CRC16().checkSum(emqrForChecksum.codeUnits, table);

  if (checksum.err != null) {
    return false;
  }
  var checkSumValue = checksum.value.toRadixString(16);

  for (var i = checkSumValue.length; i < 4; i++) {
    checkSumValue = "0$checkSumValue";
  }
  return emqrForCheckEmv == checkSumValue.toUpperCase();
}
