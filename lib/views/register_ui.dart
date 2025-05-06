// ignore_for_file: use_full_hex_values_for_flutter_colors, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_service_server/constant/color_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_service_server/models/user.dart';
import 'package:money_service_server/services/user_api.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  TextEditingController userFullnameCtrl = TextEditingController();
  TextEditingController userBirthDateCtrl = TextEditingController();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();

  bool isVisible = true;
  File? userFile;

  Future<void> openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return;

    setState(() {
      userFile = File(image.path);
    });
  }

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
      backgroundColor: Color(mainColor),
      appBar: AppBar(
        title: Text('ลงทะเบียน', style: TextStyle(color: Colors.white)),
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Text(
                              'ข้อมูลผู้ใช้งาน',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff666666),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: () async {
                          await openCamera();
                        },
                        child:
                            userFile == null
                                ? Icon(
                                  Icons.person_add,
                                  size: 100,
                                  color: Colors.grey,
                                )
                                : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    userFile!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          controller: userFullnameCtrl,
                          decoration: InputDecoration(
                            labelText: 'ชื่อ-สกุล',
                            labelStyle: TextStyle(color: Colors.teal),
                            hintText: 'YOUR NAME',
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
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          controller: userBirthDateCtrl,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                            ),
                            labelText: 'วัน-เดือน-ปีเกิด',
                            labelStyle: TextStyle(color: Colors.teal),
                            hintText: 'YOUR BIRTHDAY',
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
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          obscureText: isVisible,
                          controller: userPasswordCtrl,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible ? Icons.lock : Icons.lock_open,
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
                          if (userFullnameCtrl.text.trim().isEmpty) {
                            showWarningSnackBar(context, 'กรุณากรอกชื่อ-สกุล');
                          } else if (userBirthDateCtrl.text.trim().isEmpty) {
                            showWarningSnackBar(
                              context,
                              'กรุณากรอกวัน-เดือน-ปีเกิด',
                            );
                          } else if (userNameCtrl.text.trim().isEmpty) {
                            showWarningSnackBar(context, 'กรุณากรอกชื่อผู้ใช้');
                          } else if (userPasswordCtrl.text.trim().isEmpty) {
                            showWarningSnackBar(context, 'กรุณากรอกรหัสผ่าน');
                          } else {
                            User user = User(
                              userFullname: userFullnameCtrl.text.trim(),
                              userBirthDate: userBirthDateCtrl.text.trim(),
                              userName: userNameCtrl.text.trim(),
                              userPassword: userPasswordCtrl.text.trim(),
                            );
                            if (await UserApi().registerUser(user, userFile)) {
                              showCompleteSnackBar(context, 'ลงทะเบียนสําเร็จ');
                              Navigator.pop(context);
                            } else {
                              showWarningSnackBar(
                                context,
                                'ลงทะเบียนไม่สำเร็จ',
                              );
                            }
                          }
                        },
                        child: Text(
                          'บันทึกการลงทะเบียน',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
