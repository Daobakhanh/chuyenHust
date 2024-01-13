import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/department/page/department_screen.dart';
import 'package:appdemo/modules/home/cubit/cubit.dart';
import 'package:appdemo/modules/notification/page/notification_screen.dart';
import 'package:appdemo/modules/personal/model/user_model.dart';
import 'package:appdemo/service/connectivity.dart';
import 'package:appdemo/themes/app_color.dart';

import 'package:flutter/material.dart';
import 'package:appdemo/modules/device/page/devices/device_screen.dart';
import 'package:appdemo/modules/error/page/error_screen.dart';
import 'package:appdemo/modules/employee/page/employee_screen.dart';
import 'package:appdemo/modules/statistic/page/statistic_screen.dart';
import 'package:appdemo/modules/inventory/page/inventory_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = 'home_screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime preBackpress = DateTime.now();

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocBuilder<UserDataCubit, UserModel>(builder: (context, user) {
      return WillPopScope(
          onWillPop: () async {
            final timegap = DateTime.now().difference(preBackpress);
            preBackpress = DateTime.now();
            final canExit = timegap >= const Duration(seconds: 2);
            if (canExit) {
              const snack = SnackBar(
                content: Text('Ấn 2 lần để thoát'),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            backgroundColor: Colors.blueAccent,
            body: Stack(children: [
              Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 14,
                                child: Image.asset(
                                    'assets/images/logo-bo-y-te.jpg'),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('Xin chào',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white)),
                                    Icon(
                                      MdiIcons.handWave,
                                      size: 20,
                                      color: Colors.yellow,
                                    )
                                  ],
                                ),
                                Text(
                                  user.data!.displayname!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, NotificationScreen.routeName);
                            },
                            child: Icon(
                              Icons.notifications,
                              color: Colors.yellow,
                              size: screenSize.width * 0.14,
                              //45,
                            ))
                      ],
                    ),
                  ),
                )
              ]),
              const SizedBox(height: 50),
              Positioned.fill(
                  top: 100,
                  child: Container(
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: GridView(
                      padding: const EdgeInsets.only(
                          top: 20, right: 60, left: 60, bottom: 30),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 50,
                              crossAxisSpacing: 50),
                      children: [
                        InkWell(
                          highlightColor: Colors.grey, //hiệu ứng khi giữ lâu
                          splashColor: Colors.red, //hiệu ứng khi chạm vào
                          onTap: () {
                            Navigator.pushNamed(
                                context, DeviceScreen.routeName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.white1,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.medical_services,
                                  size: screenSize.width * 0.16,
                                  color: AppColors.redAccent,
                                ),
                                Text(
                                  AppFunctionTerm.device,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenSize.width * 0.04,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, ErrorScreen.routeName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.white1,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.notification_important,
                                  size: screenSize.width * 0.16,
                                  color: Colors.orange,
                                ),
                                Text(
                                  AppFunctionTerm.reportError,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenSize.width * 0.04,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, DepartmentScreen.routeName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.white1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.business,
                                  size: screenSize.width * 0.16,
                                  color: AppColors.greenAccent,
                                ),
                                Text(
                                  AppFunctionTerm.department,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenSize.width * 0.04,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, EmployeeScreen.routeName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.white1,
                            ),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: screenSize.width * 0.16,
                                  color: AppColors.green1,
                                ),
                                Text(
                                  AppFunctionTerm.employee,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenSize.width * 0.04,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, StatisticScreen.routeName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.white1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.analytics,
                                  size: screenSize.width * 0.16,
                                  color: AppColors.pink1,
                                ),
                                Text(
                                  AppFunctionTerm.statistic,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenSize.width * 0.04,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, InventoryScreen.routeName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.white1,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inventory,
                                  size: screenSize.width * 0.16,
                                  color: AppColors.blue1,
                                ),
                                Text(
                                  AppFunctionTerm.inventory,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenSize.width * 0.04,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ]),
          ));
    });
  }
}
