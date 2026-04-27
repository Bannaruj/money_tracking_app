// ignore_for_file: use_full_hex_values_for_flutter_colors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        outgoingDateCtrl.text = DateFormat('dd MMMM yyyy').format(picked);
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
              const SizedBox(height: 10),
              const SizedBox(height: 40),
              const Text(
                'เงินออก',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  controller: moneyDetailCtrl,
                  validator: (value) => value == null || value.isEmpty ? 'กรุณากรอกรายการ' : null,
                  decoration: InputDecoration(
                    labelText: 'รายการเงินออก',
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
                  controller: outgoingAmountCtrl,
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'กรุณากรอกจำนวนเงิน' : null,
                  decoration: InputDecoration(
                    labelText: 'จำนวนเงินออก',
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
                  controller: outgoingDateCtrl,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (value) => value == null || value.isEmpty ? 'กรุณาเลือกวันที่' : null,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_month, color: Colors.teal),
                    ),
                    labelText: 'วัน เดือน ปีที่เงินออก',
                    labelStyle: const TextStyle(color: Colors.teal),
                    hintText: 'DATE OUTGOING',
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
                        'บันทึกเงินออก',
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
