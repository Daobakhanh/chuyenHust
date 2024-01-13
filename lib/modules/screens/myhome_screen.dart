import 'package:appdemo/modules/home/page/home_screen.dart';
import 'package:appdemo/modules/screens/qr_screen.dart';
import 'package:appdemo/modules/personal/page/info_screen.dart';
import 'package:appdemo/service/connectivity.dart';
import 'package:flutter/material.dart';

class MyhomeScreen extends StatefulWidget {
  const MyhomeScreen({super.key});
  static String routeName = 'myhome_screen';
  @override
  State<MyhomeScreen> createState() => _MyhomeScreenState();
}

class _MyhomeScreenState extends State<MyhomeScreen> {
  List page = [const HomeScreen(), const QRScreen(), const InfoScreen()];
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: _currentIndex,
          children: const [HomeScreen(), QRScreen(), InfoScreen()]),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.crop_free),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}
