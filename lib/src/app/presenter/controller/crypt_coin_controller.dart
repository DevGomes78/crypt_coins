import 'dart:convert';

import 'package:crypt_coins/src/core/crypt_coin_constants.dart';
import 'package:crypt_coins/src/data/models/crypt_coin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';

class CryptCoinController extends ChangeNotifier {
  CryptCoinModel cryptCoinModel = CryptCoinModel();

  bool isVisibleBalance = true;
  bool enableShimmer = true;

  Future<void> init() async {
    //Obtem o json local
    final dataJson = await _getLocalJson();

    //pega as informações do json e tranforma em um model
    cryptCoinModel = _takeJsonInforTransformsIntoModel(dataJson);
    notifyListeners();
  }

  CryptCoinModel _takeJsonInforTransformsIntoModel(String dataJson) {
    final parseDataJson = json.decode(dataJson);
    final cryptCoinModel = CryptCoinModel.fromJson(parseDataJson);
    return cryptCoinModel;
  }

  Future<String> _getLocalJson() async {
    final dataJson = await rootBundle.loadString(CryptCoinConstants.pathJson);
    return dataJson;
  }

  void visibleBalance() {
    isVisibleBalance = !isVisibleBalance;
    notifyListeners();
  }

  String formatValue({String? value}) {
    final numberDecimal = Decimal.tryParse(value ?? '0');
    final decimalValue = Decimal.parse('1000');
    if (numberDecimal?.scale == 3) {
      final value = (decimalValue * (numberDecimal ?? Decimal.parse('0')))
          .toStringAsFixed(2);
      return _numberFormat(value);
    } else {
      return _numberFormat(numberDecimal?.toStringAsFixed(2));
    }
  }

  String _numberFormat(String? value) => NumberFormat.currency(
        locale: CryptCoinConstants.locale,
        symbol: CryptCoinConstants.symbol,
        decimalDigits: 2,
      ).format(
        double.parse(value ?? '0'),
      );
}
