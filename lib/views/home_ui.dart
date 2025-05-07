// ignore_for_file: avoid_function_literals_in_foreach_calls

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
  State<HomeUI> createState() => _HomeUI();
}

class _HomeUI extends State<HomeUI> {
  int _selectedIndex = 1;
  late Future<List<Money>> moneyAllData;
  List showUI = [];
  Future<List<Money>> getMoneyByUserId() async {
    return await MoneyApi().getMoneyByUserId(widget.userId!);
  }

  void refreshData() {
    setState(() {
      moneyAllData = getMoneyByUserId(); // Trigger a refresh of the data
    });
  }

  @override
  void initState() {
    // moneyAllData = getMoneyByUserId();
    refreshData();
    showUI = [
      HomeUISection1(userId: widget.userId!, refreshData: refreshData),
      HomeUISection2(userId: widget.userId!),
      HomeUISection3(userId: widget.userId!, refreshData: refreshData),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalMoney = 0.0;
    double totalIncome = 0.0;
    double totalExpanse = 0.0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          SizedBox(width: 25),
        ],
        backgroundColor: Color(mainColor),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Color(mainColor)),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[350],
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.piggyBank, size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house, size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_up_outlined, size: 45),
              label: '',
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          children: [
            FutureBuilder(
              future: moneyAllData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  ); // แสดง loading
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  // ตัวแปรนี้จะทำการคำนวณยอดเงินคงเหลือ
                  snapshot.data!.forEach((x) {
                    if (x.moneyType == 1) {
                      totalMoney += x.moneyInOut!;
                      totalIncome += x.moneyInOut!;
                    } else {
                      totalExpanse += x.moneyInOut!;
                      totalMoney -= x.moneyInOut!;
                    }
                  });
                  return Container(
                    width: double.infinity,
                    height: 200,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 25,
                    ),
                    decoration: BoxDecoration(
                      color: Color(mainColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "ยอดเงินคงเหลือ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          "$totalMoney บาท",
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_down_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5),

                                    Text(
                                      "ยอดเงินเข้าร่วม",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "$totalIncome บาท",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "ยอดเงินออกร่วม",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.arrow_circle_up_outlined,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                Text(
                                  "$totalExpanse บาท",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Center(child: Text('ไม่มีข้อมูล'));
              },
              // childre:
            ),
            Expanded(child: showUI[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}
