// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:money_service_server/constant/baseurl_constant.dart';
import 'package:money_service_server/models/money.dart';

class MoneyApi {
  final dio = Dio();

  Future<List<Money>> getMoneyByUserId(int userId) async {
    try {
      final responseData = await dio.get('$baseUrl/money/$userId');
      if (responseData.statusCode == 200) {
        return (responseData.data['info'] as List)
            .map((money) => Money.fromJson(money))
            .toList();
      } else {
        return <Money>[];
      }
    } catch (err) {
      print('ERRORs: ${err.toString()}');
      return <Money>[];
    }
  }

  Future<bool> inOutMoney(Money money) async {
    try {
      final Map<String, dynamic> requestBody = {
        'moneyDetail': money.moneyDetail,
        'moneyDate': money.moneyDate,
        'moneyInOut': money.moneyInOut,
        'moneyType': money.moneyType,
        'userId': money.userId,
      };

      final responseData = await dio.post(
        '$baseUrl/money/',
        data: requestBody,
        options: Options(headers: {'content-type': 'application/json'}),
      );

      if (responseData.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('ERROR: ${err.toString()}');
      return false;
    }
  }
}
