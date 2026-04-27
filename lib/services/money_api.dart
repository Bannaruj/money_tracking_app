// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:money_service_server/models/money.dart';

class MoneyApi {
  final supabase = Supabase.instance.client;

  Future<List<Money>> getMoneyByUserId(int userId) async {
    try {
      final List<dynamic> data = await supabase
          .from('money_tb')
          .select()
          .eq('userId', userId);
          
      if (data.isNotEmpty) {
        return data.map((money) => Money.fromJson(money)).toList();
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

      await supabase.from('money_tb').insert(requestBody);

      return true;
    } catch (err) {
      print('ERROR: ${err.toString()}');
      return false;
    }
  }
}
