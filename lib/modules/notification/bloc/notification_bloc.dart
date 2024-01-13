import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/employee/model/employee_model.dart';
import 'package:appdemo/modules/employee/repo/employee_repo.dart';
import 'package:appdemo/modules/notification/bloc/notification_bloc_event.dart';
import 'package:appdemo/modules/notification/bloc/notification_bloc_state.dart';
import 'package:appdemo/modules/notification/model/notification_model.dart';
import 'package:appdemo/modules/notification/repo/notification_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationEvent>(
      (event, emit) async {
        if (event is FetchNotification) {
          emit(NotificationLoading());
          try {
            NotificationModel? notification =
                await NotificationRepo.dioGetNotificationData();
            EmployeeModel? employee = await EmployeeRepo.dioGetEmployeeData();
            if (notification!.status == 200) {
              emit(NotificationLoaded(
                  notification: notification, employee: employee!));
            } else {
              emit(NotificationErrorApi(error: AppLoadDataTerm.errorLoad));
            }
          } catch (e) {
            emit(NotificationError());
          }
        }
      },
    );
  }
}
