import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/notification/bloc/notification_bloc.dart';
import 'package:appdemo/modules/notification/bloc/notification_bloc_event.dart';
import 'package:appdemo/modules/notification/bloc/notification_bloc_state.dart';
import 'package:appdemo/modules/notification/widget/show_notification.dart';
import 'package:appdemo/service/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  static String routeName = "notificaton_screen";
  @override
  State<NotificationScreen> createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    NotificationBloc fetchNotification =
        BlocProvider.of<NotificationBloc>(context);
    fetchNotification.add(FetchNotification());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Thông Báo',
        ),
      ),
      backgroundColor: Colors.blue,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Flexible(
                child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                fetchNotification.add(FetchNotification());
              },
              child: BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is NotificationLoaded) {
                    return ShowNotification(
                        notification: state.notification.data!,
                        employees: state.employee.data!);
                  } else {
                    return Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              fetchNotification.add(FetchNotification());
                            },
                            child: const Text(AppLoadDataTerm.reload)),
                        const Text(AppLoadDataTerm.errorLoad)
                      ],
                    );
                  }
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}
