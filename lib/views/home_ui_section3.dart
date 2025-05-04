import 'package:flutter/material.dart';
import 'package:money_service_server/color_constant/color_constant.dart';

class HomeUISection3 extends StatefulWidget {
  const HomeUISection3({super.key});

  @override
  State<HomeUISection3> createState() => _HomeUISection3State();
}

class _HomeUISection3State extends State<HomeUISection3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          'Firstname Lastname',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(radius: 20),
          ),
        ],
      ),
    );
  }
}
