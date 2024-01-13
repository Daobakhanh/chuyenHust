// ignore_for_file: unused_import

import 'package:appdemo/modules/authentication/bloc/authentication_bloc.dart';
import 'package:appdemo/modules/department/bloc/department_bloc.dart';
import 'package:appdemo/modules/device/bloc/device_bloc.dart';
import 'package:appdemo/modules/device/page/history_inventory/bloc/history_inventory_bloc.dart';
import 'package:appdemo/modules/employee/bloc/employee_bloc.dart';
import 'package:appdemo/modules/error/bloc/report_error_bloc.dart';
import 'package:appdemo/modules/home/cubit/cubit.dart';
import 'package:appdemo/modules/inventory/bloc/create_inventory_bloc.dart';
import 'package:appdemo/modules/notification/bloc/notification_bloc.dart';
import 'package:appdemo/modules/personal/bloc/logout_bloc.dart';
import 'package:appdemo/modules/screens/splash_screen.dart';
import 'package:appdemo/modules/statistic/bloc/static_bloc.dart';
import 'package:appdemo/service/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await dotenv.load();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<UserDataCubit>(
      create: (BuildContext context) => UserDataCubit(),
    ),
    BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => AuthenticationBloc(),
    ),
    BlocProvider<DeviceBloc>(
      create: (BuildContext context) => DeviceBloc(),
    ),
    BlocProvider<ReportErrorBloc>(
      create: (BuildContext context) => ReportErrorBloc(),
    ),
    BlocProvider<DepartmentBloc>(
      create: (BuildContext context) => DepartmentBloc(),
    ),
    BlocProvider<EmployeeBloc>(
      create: (BuildContext context) => EmployeeBloc(),
    ),
    BlocProvider<StatisticBloc>(
      create: (BuildContext context) => StatisticBloc(),
    ),
    BlocProvider<CreateInventoryBloc>(
      create: (BuildContext context) => CreateInventoryBloc(),
    ),
    BlocProvider<HistoryInventoryBloc>(
      create: (BuildContext context) => HistoryInventoryBloc(),
    ),
    BlocProvider<LogoutBloc>(
      create: (BuildContext context) => LogoutBloc(),
    ),
    BlocProvider<NotificationBloc>(
      create: (BuildContext context) => NotificationBloc(),
    ),
  ], child:EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/translations', // <-- change the path of the translation files 
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()
    ),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: routes,
      home: const Scaffold(body: SplashScreen()),
    );
  }
}
