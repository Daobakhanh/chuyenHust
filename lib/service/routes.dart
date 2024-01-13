import 'package:appdemo/modules/department/page/department_screen.dart';
import 'package:appdemo/modules/employee/page/employee_screen.dart';
import 'package:appdemo/modules/device/page/devices/device_screen.dart';
import 'package:appdemo/modules/home/page/home_screen.dart';
import 'package:appdemo/modules/personal/page/info_screen.dart';
import 'package:appdemo/modules/screens/intro_screen.dart';
import 'package:appdemo/modules/authentication/page/login_screen.dart';
import 'package:appdemo/modules/screens/myhome_screen.dart';
import 'package:appdemo/modules/notification/page/notification_screen.dart';
import 'package:appdemo/modules/screens/qr_screen.dart';
import 'package:appdemo/modules/screens/setting_screen.dart';
import 'package:appdemo/modules/statistic/page/statistic_screen.dart';
import 'package:flutter/material.dart';
import 'package:appdemo/modules/screens/splash_screen.dart';
import 'package:appdemo/modules/error/page/error_screen.dart';
import 'package:appdemo/modules/inventory/page/inventory_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DeviceScreen.routeName: (context) => const DeviceScreen(),
  ErrorScreen.routeName: (context) => const ErrorScreen(),
  InfoScreen.routeName: (context) => const InfoScreen(),
  MyhomeScreen.routeName: (context) => const MyhomeScreen(),
  SettingScreen.routeName: (context) => const SettingScreen(),
  DepartmentScreen.routeName: (context) => const DepartmentScreen(),
  NotificationScreen.routeName: (context) => const NotificationScreen(),
  EmployeeScreen.routeName: (context) => const EmployeeScreen(),
  StatisticScreen.routeName: (context) => const StatisticScreen(),
  InventoryScreen.routeName: (context) => const InventoryScreen(),
  QRScreen.routeName: (context) => const QRScreen(),
};
