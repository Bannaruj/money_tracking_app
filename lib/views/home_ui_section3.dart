// ignore_for_file: use_full_hex_values_for_flutter_colors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_service_server/models/money.dart';
import 'package:money_service_server/services/money_api.dart';

class HomeUISection3 extends StatefulWidget {
  final int userId;
  final Function refreshData;
  const HomeUISection3({
    required this.userId,
    required this.refreshData,
    super.key,
  });

  @override
  State<HomeUISection3> createState() => _HomeUISection3State();
}

class _HomeUISection3State extends State<HomeUISection3> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController moneyDetailCtrl = TextEditingController();
  TextEditingController outgoingAmountCtrl = TextEditingController();
  TextEditingController outgoingDateCtrl = TextEditingController();

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
            SizedBox(height: 10),
            SizedBox(height: 40),
            Text(
              'เงินออก',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                controller: moneyDetailCtrl,
                decoration: InputDecoration(
                  labelText: 'รายการเงินออก',
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
                controller: outgoingAmountCtrl,
                decoration: InputDecoration(
                  labelText: 'จำนวนเงินออก',
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
                controller: outgoingDateCtrl,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_month, color: Colors.grey),
                  labelText: 'วัน เดือน ปีที่เงินออก',
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
                  Money moneyExpanse = Money(
                    moneyDetail: moneyDetailCtrl.text.trim(),
                    moneyInOut: double.parse(outgoingAmountCtrl.text.trim()),
                    moneyDate: outgoingDateCtrl.text.trim(),
                    moneyType: 2,
                    userId: widget.userId,
                  );
                  if (await MoneyApi().inOutMoney(moneyExpanse)) {
                    showCompleteSnackBar(context, "บันทึกเงินออก");
                    moneyDetailCtrl.clear();
                    outgoingAmountCtrl.clear();
                    outgoingDateCtrl.clear();
                    widget.refreshData();
                  } else {
                    showWarningSnackBar(context, "บันทึกไม่สําเร็จ");
                  }
                }
              },
              child: Text(
                'บันทึกเงินออก',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
