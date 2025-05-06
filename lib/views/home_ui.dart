import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_service_server/constant/baseurl_constant.dart';
import 'package:money_service_server/constant/color_constant.dart';
import 'package:money_service_server/models/money.dart';
import 'package:money_service_server/services/money_api.dart';
import 'package:money_service_server/views/home_ui_section1.dart';
import 'package:money_service_server/views/home_ui_section2.dart';
import 'package:money_service_server/views/home_ui_section3.dart';

class HomeUI extends StatefulWidget {
  final String? userName;
  final String? userImage;
  final int? userId;
  const HomeUI({super.key, this.userName, this.userImage, this.userId});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int _currentIndex = 0;

  Future<List<Money>> getMoneyByUserId() async {
    return await MoneyApi().getMoneyByUserId(widget.userId!);
  }

  final List<Widget> _pages = [
    HomeUISection1(),
    HomeUISection2(),
    HomeUISection3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Row(
          children: [
            Text(
              widget.userName.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          widget.userImage == null
              ? Image.asset(
                'assets/images/TahmKench_0.jpg',
                width: 50,
                height: 50,
              )
              : ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  '$baseUrl/images/users/${widget.userImage}',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(mainColor),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.piggyBank,
              color: Colors.grey,
              size: 35,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.piggyBank,
              color: Colors.white,
              size: 35,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house, color: Colors.grey, size: 30),
            activeIcon: Icon(
              FontAwesomeIcons.house,
              color: Colors.white,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.handHoldingDollar,
              color: Colors.grey,
              size: 35,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.handHoldingDollar,
              color: Colors.white,
              size: 35,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
