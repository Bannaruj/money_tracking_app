// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:money_service_server/views/login_ui.dart';
import 'package:money_service_server/views/register_ui.dart';

class WelcomeUI extends StatefulWidget {
  const WelcomeUI({super.key});

  @override
  State<WelcomeUI> createState() => _WelcomeUIState();
}

class _WelcomeUIState extends State<WelcomeUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeFFFFF),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              Image.asset('assets/images/Group 1.png'),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '       บันทึก\nรายรับรายจ่าย',
                  style: TextStyle(fontSize: 30, color: Color(0xffe438883)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10, // ความสูงของเงา ยิ่งมากยิ่งเงาเข้ม
                  shadowColor: Colors.black, // สีเงา// สีปุ่ม
                  backgroundColor: Color(0xffe438883),
                  minimumSize: Size(400, 70),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginUI()),
                  );
                },
                child: Text(
                  'เริ่มใช้งานแอปพลิเคชั่น',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ยังไม่ได้ลงทะเบียน? '),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterUI()),
                      );
                    },
                    child: Text(
                      'ลงทะเบียน',
                      style: TextStyle(color: Color(0xffe438883)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
