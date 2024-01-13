import 'package:appdemo/modules/employee/model/employee_model.dart';
import 'package:appdemo/modules/notification/model/notification_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  NotificationModel notification;
  EmployeeModel employee;
  NotificationLoaded({required this.notification,required this.employee});
}

class NotificationError extends NotificationState {}

class NotificationErrorApi extends NotificationState {
  String error;
  NotificationErrorApi({required this.error});
}
