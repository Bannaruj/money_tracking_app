import 'package:flutter/material.dart';
import 'package:money_service_server/color_constant/color_constant.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(mainColor),
      appBar: AppBar(
        title: Text('เข้าสู่ระบบ', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(mainColor),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Image.asset(
                  'assets/images/Group 1.png',
                  width: 1,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
