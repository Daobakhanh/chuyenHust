import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/department/bloc/department_bloc_event.dart';
import 'package:appdemo/modules/department/bloc/department_bloc_state.dart';
import 'package:appdemo/modules/department/model/department_model.dart';
import 'package:appdemo/modules/department/repo/department_repo.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/modules/device/repo/device_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  DepartmentBloc() : super(DepartmentInitial()) {
    on<DepartmentEvent>(
      (event, emit) async {
        if (event is FetchDepartment) {
          emit(DepartmentLoading());
          try {
            DepartmentModel? department =
                await DepartmentRepo.dioGetDepartmentData();
            DeviceModel? device = await DeviceRepo.dioGetDeviceData();
            if (department!.statusCode == 200) {
              emit(DepartmentLoaded(department: department, device: device!));
            } else {
              emit(DepartmentErrorApi(error: AppLoadDataTerm.errorLoad));
            }
          } catch (e) {
            emit(DepartmentError());
          }
        }
      },
    );
  }
}
