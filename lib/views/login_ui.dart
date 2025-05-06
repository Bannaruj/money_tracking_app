// ignore_for_file: sort_child_properties_last, use_full_hex_values_for_flutter_colors, prefer_is_empty, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_service_server/constant/color_constant.dart';
import 'package:money_service_server/models/user.dart';
import 'package:money_service_server/services/user_api.dart';
import 'package:money_service_server/views/home_ui.dart';
import 'package:money_service_server/views/home_ui_section1.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();

  bool isShowPassword = true;

  showWarningSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

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
      body: Column(
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // ✅ ภาพอยู่ด้านบนของ Container สีขาว
                      Image.asset(
                        'assets/images/Group 2.png',
                        width: 400,
                        height: 400,
                      ),
                      SizedBox(height: 20),
                      // ✅ ฟอร์มผู้ใช้
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          controller: userNameCtrl,
                          decoration: InputDecoration(
                            labelText: 'ชื่อผู้ใช้',
                            labelStyle: TextStyle(color: Colors.teal),
                            hintText: 'USERNAME',
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
                              borderSide: BorderSide(
                                color: Colors.teal,
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          obscureText: isShowPassword,
                          controller: userPasswordCtrl,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isShowPassword = !isShowPassword;
                                });
                              },
                              icon:
                                  isShowPassword == true
                                      ? Icon(Icons.lock, color: Colors.grey)
                                      : Icon(
                                        Icons.lock_open,
                                        color: Colors.grey,
                                      ),
                            ),
                            labelText: 'รหัสผ่าน',
                            labelStyle: TextStyle(color: Colors.teal),
                            hintText: 'PASSWORD',
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
                              borderSide: BorderSide(
                                color: Colors.teal,
                                width: 2,
                              ),
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
                          minimumSize: Size(400, 70),
                        ),
                        onPressed: () async {
                          if (userNameCtrl.text.length == 0) {
                            showWarningSnackBar(context, 'ป้อนชื่อผู้ใช้....');
                          } else if (userPasswordCtrl.text.length == 0) {
                            showWarningSnackBar(context, 'ป้อนรหัสด้วย');
                          } else {
                            User user = User(
                              userName: userNameCtrl.text,
                              userPassword: userPasswordCtrl.text,
                            );
                            user = await UserApi().loginUser(user);
                            if (user.userId != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => HomeUI(
                                        userName: user.userFullname,
                                        userImage: user.userImage,
                                        userId: int.parse(
                                          user.userId.toString(),
                                        ),
                                      ),
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          'เข้าใช้งาน',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
