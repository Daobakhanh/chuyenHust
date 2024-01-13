import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/employee/model/employee_model.dart';
import 'package:appdemo/modules/notification/model/notification_model.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:appdemo/utils/time_format.dart';
import 'package:flutter/material.dart';

class ShowNotification extends StatelessWidget {
  final List<NotificationData> notification;
  final List<EmployeeData> employees;
  const ShowNotification(
      {super.key, required this.notification, required this.employees});

  String getUserNotification(int userId) {
    String name = '';
    for (EmployeeData employee in employees) {
      if (employee.id == userId) {
        name = employee.displayname;
        break;
      }
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return (notification.isEmpty)
        ? Container(
            margin: const EdgeInsets.only(top: 40),
            child: const Text(AppNotificationTerm.emptyNotification))
        : ListView.builder(
            itemCount: notification.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(13),
                        width: 300,
                        decoration: const BoxDecoration(
                            color: AppColors.white5,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Thời gian: ${DateTimeFormat.convertDateTime(notification[index].createdAt!)}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                'Nội dung: ${notification[index].data!.content!}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                'Người gửi: ${getUserNotification(notification[index].data!.userId!)}')
                          ],
                        )),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              );
            });
  }
}
