import 'package:flutter/material.dart';
import 'package:money_service_server/color_constant/color_constant.dart';

class HomeUISection2 extends StatefulWidget {
  const HomeUISection2({super.key});

  @override
  State<HomeUISection2> createState() => _HomeUISection2State();
}

class _HomeUISection2State extends State<HomeUISection2> {
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
