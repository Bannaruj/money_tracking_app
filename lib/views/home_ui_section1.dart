// ignore_for_file: use_full_hex_values_for_flutter_colors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_service_server/models/money.dart';
import 'package:money_service_server/services/money_api.dart';

class HomeUISection1 extends StatefulWidget {
  final int userId;
  final Function refreshData;
  const HomeUISection1({
    required this.userId,
    required this.refreshData,
    super.key,
  });

  @override
  State<HomeUISection1> createState() => _HomeUISection1State();
}

class _HomeUISection1State extends State<HomeUISection1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController moneyDetailCtrl = TextEditingController();
  TextEditingController incomeAmoutCtrl = TextEditingController();
  TextEditingController incomeDateCtrl = TextEditingController();

  showWarningSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  showCompleteSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              'เงินเข้า',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                controller: moneyDetailCtrl,
                decoration: InputDecoration(
                  labelText: 'รายการเงินเข้า',
                  labelStyle: TextStyle(color: Colors.teal),
                  hintText: 'DETAIL',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 23,
                    horizontal: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                controller: incomeAmoutCtrl,
                decoration: InputDecoration(
                  labelText: 'จำนวนเงินเข้า',
                  labelStyle: TextStyle(color: Colors.teal),
                  hintText: '0.00',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 23,
                    horizontal: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                controller: incomeDateCtrl,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_month, color: Colors.grey),
                  labelText: 'วัน เดือน ปีที่เงินเข้า',
                  labelStyle: TextStyle(color: Colors.teal),
                  hintText: 'DATE INCOME',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 23,
                    horizontal: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 10,
                shadowColor: Colors.black,
                backgroundColor: Color(0xffe438883),
                minimumSize: Size(370, 80),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Money moneyIncome = Money(
                    moneyDetail: moneyDetailCtrl.text.trim(),
                    moneyInOut: double.parse(incomeAmoutCtrl.text.trim()),
                    moneyDate: incomeAmoutCtrl.text.trim(),
                    moneyType: 1,
                    userId: widget.userId,
                  );
                  if (await MoneyApi().inOutMoney(moneyIncome)) {
                    showCompleteSnackBar(context, 'บันทึกสำเร็จ');
                    moneyDetailCtrl.clear();
                    incomeAmoutCtrl.clear();
                    incomeDateCtrl.clear();
                    widget.refreshData();
                  } else {
                    showWarningSnackBar(context, 'บันทึกไม่สำเร็จ');
                  }
                }
              },

              child: Text(
                'บันทึกเงินเข้า',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
