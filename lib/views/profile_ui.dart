import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:money_service_server/models/user.dart' as model;
import 'package:money_service_server/services/user_api.dart';

class ProfileUI extends StatefulWidget {
  final int userId;
  final String userName;
  final String? userImage;

  const ProfileUI({
    super.key,
    required this.userId,
    required this.userName,
    this.userImage,
  });

  @override
  State<ProfileUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  late TextEditingController nameCtrl;
  File? userFile;
  final Color tealPrimary = const Color(0xFF0D9488);

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.userName);
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        userFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('แก้ไขโปรไฟล์', style: TextStyle(color: Colors.white)),
        backgroundColor: tealPrimary,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: userFile != null
                              ? FileImage(userFile!) as ImageProvider
                              : (widget.userImage != null && widget.userImage!.isNotEmpty
                                  ? NetworkImage(Supabase.instance.client.storage
                                      .from('user_images')
                                      .getPublicUrl(widget.userImage!))
                                  : const AssetImage('assets/images/TahmKench_0.jpg')
                                      as ImageProvider),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: tealPrimary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: 'ชื่อ-นามสกุล',
                  prefixIcon: Icon(Icons.person, color: tealPrimary),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    if (nameCtrl.text.isEmpty) return;
                    
                    final updatedUser = await UserApi().updateUser(
                      widget.userId,
                      nameCtrl.text,
                      userFile,
                      widget.userImage,
                    );

                    if (updatedUser != null && mounted) {
                      Navigator.pop(context, updatedUser);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tealPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('บันทึกการเปลี่ยนแปลง',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
