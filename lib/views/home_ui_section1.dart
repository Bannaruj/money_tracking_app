// ignore_for_file: use_full_hex_values_for_flutter_colors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        incomeDateCtrl.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'เงินเข้า',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  controller: moneyDetailCtrl,
                  validator: (value) => value == null || value.isEmpty ? 'กรุณากรอกรายการ' : null,
                  decoration: InputDecoration(
                    labelText: 'รายการเงินเข้า',
                    labelStyle: const TextStyle(color: Colors.teal),
                    hintText: 'DETAIL',
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 23,
                      horizontal: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.teal, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  controller: incomeAmoutCtrl,
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'กรุณากรอกจำนวนเงิน' : null,
                  decoration: InputDecoration(
                    labelText: 'จำนวนเงินเข้า',
                    labelStyle: const TextStyle(color: Colors.teal),
                    hintText: '0.00',
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 23,
                      horizontal: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.teal, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  controller: incomeDateCtrl,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (value) => value == null || value.isEmpty ? 'กรุณาเลือกวันที่' : null,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_month, color: Colors.teal),
                    ),
                    labelText: 'วัน เดือน ปีที่เงินเข้า',
                    labelStyle: const TextStyle(color: Colors.teal),
                    hintText: 'DATE INCOME',
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 23,
                      horizontal: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.teal, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shadowColor: Colors.black,
                  backgroundColor: const Color(0xFF0D9488),
                  minimumSize: const Size(370, 80),
                ),
                onPressed: _isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            Money moneyIncome = Money(
                              moneyDetail: moneyDetailCtrl.text.trim(),
                              moneyInOut: double.parse(incomeAmoutCtrl.text.trim()),
                              moneyDate: incomeDateCtrl.text.trim(),
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
                          } catch (e) {
                            showWarningSnackBar(context, 'เกิดข้อผิดพลาด: $e');
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'บันทึกเงินเข้า',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
