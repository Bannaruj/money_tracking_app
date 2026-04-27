// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:money_service_server/models/money.dart';
import 'package:money_service_server/services/money_api.dart';
import 'package:money_service_server/views/home_ui_section1.dart';
import 'package:money_service_server/views/home_ui_section2.dart';
import 'package:money_service_server/views/home_ui_section3.dart';
import 'package:money_service_server/views/profile_ui.dart';
import 'package:money_service_server/models/user.dart';

class HomeUI extends StatefulWidget {
  String? userName;
  String? userImage;
  final int? userId;

  HomeUI({super.key, this.userName, this.userImage, this.userId});

  @override
  State<HomeUI> createState() => _HomeUI();
}

class _HomeUI extends State<HomeUI> {
  int _selectedIndex = 1;
  late Future<List<Money>> moneyAllData;
  List<Widget> showUI = [];

  // Teal Theme Colors
  final Color tealLight = const Color(0xFF2DD4BF);
  final Color tealPrimary = const Color(0xFF0D9488);
  final Color tealDark = const Color(0xFF0F766E);
  final Color bgLight = const Color(0xFFF3F4F6);

  Future<List<Money>> getMoneyByUserId() async {
    return await MoneyApi().getMoneyByUserId(widget.userId!);
  }

  void refreshData() {
    setState(() {
      moneyAllData = getMoneyByUserId();
    });
  }

  @override
  void initState() {
    refreshData();
    showUI = [
      HomeUISection1(userId: widget.userId!, refreshData: refreshData),
      HomeUISection2(userId: widget.userId!),
      HomeUISection3(userId: widget.userId!, refreshData: refreshData),
    ];
    super.initState();
  }

  Widget _buildIncomeExpenseChip({
    required IconData icon,
    required String title,
    required double amount,
    required Color color,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "฿${amount.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalMoney = 0.0;
    double totalIncome = 0.0;
    double totalExpanse = 0.0;

    return Scaffold(
      backgroundColor: bgLight,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 0,
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              currentIndex: _selectedIndex,
              selectedItemColor: tealPrimary,
              unselectedItemColor: Colors.grey[400],
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.wallet, size: 24),
                  activeIcon: Icon(FontAwesomeIcons.wallet, size: 28),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.house, size: 24),
                  activeIcon: Icon(FontAwesomeIcons.house, size: 28),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient:
                          _selectedIndex == 2
                              ? LinearGradient(
                                colors: [tealLight, tealPrimary],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                              : null,
                      color: _selectedIndex == 2 ? null : Colors.grey[200],
                      shape: BoxShape.circle,
                      boxShadow:
                          _selectedIndex == 2
                              ? [
                                BoxShadow(
                                  color: tealPrimary.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                              : [],
                    ),
                    child: Icon(
                      Icons.add,
                      size: 24,
                      color:
                          _selectedIndex == 2 ? Colors.white : Colors.grey[600],
                    ),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // 1. Curved Teal Header Background
          Container(
            height: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [tealLight, tealPrimary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),

          // 2. Main Content
          SafeArea(
            child: Column(
              children: [
                // -- Header Area --
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ยินดีต้อนรับกลับมา",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.userName ?? "User",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ProfileUI(
                                    userId: widget.userId!,
                                    userName: widget.userName!,
                                    userImage: widget.userImage,
                                  ),
                            ),
                          );

                          if (result != null && result is User) {
                            setState(() {
                              widget.userName = result.userFullname;
                              widget.userImage = result.userImage;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey[200],
                            backgroundImage:
                                (widget.userImage == null ||
                                        widget.userImage!.isEmpty)
                                    ? const AssetImage(
                                          'assets/images/TahmKench_0.jpg',
                                        )
                                        as ImageProvider
                                    : NetworkImage(
                                      Supabase.instance.client.storage
                                          .from('user_images')
                                          .getPublicUrl(widget.userImage!),
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // -- Balance Card --
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: FutureBuilder<List<Money>>(
                    future: moneyAllData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF0D9488),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Center(
                            child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        for (var x in snapshot.data!) {
                          if (x.moneyType == 1) {
                            totalMoney += x.moneyInOut!;
                            totalIncome += x.moneyInOut!;
                          } else {
                            totalExpanse += x.moneyInOut!;
                            totalMoney -= x.moneyInOut!;
                          }
                        }

                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: tealPrimary.withOpacity(0.15),
                                blurRadius: 25,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "ยอดเงินคงเหลือรวม",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "฿ ${totalMoney.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: tealDark,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  _buildIncomeExpenseChip(
                                    icon: Icons.arrow_downward_rounded,
                                    title: "รายรับ",
                                    amount: totalIncome,
                                    color: const Color(0xFF10B981), // Green
                                    bgColor: const Color(0xFFECFDF5),
                                  ),
                                  const SizedBox(width: 15),
                                  _buildIncomeExpenseChip(
                                    icon: Icons.arrow_upward_rounded,
                                    title: "รายจ่าย",
                                    amount: totalExpanse,
                                    color: const Color(0xFFEF4444), // Red
                                    bgColor: const Color(0xFFFEF2F2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return const Center(child: Text('ไม่มีข้อมูล'));
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // -- Sections Content --
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    child: showUI[_selectedIndex],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
