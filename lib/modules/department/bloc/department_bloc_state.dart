import 'package:appdemo/modules/department/model/department_model.dart';
import 'package:appdemo/modules/device/model/device_model.dart';

abstract class DepartmentState {}

class DepartmentInitial extends DepartmentState {}

class DepartmentLoading extends DepartmentState {}

class DepartmentLoaded extends DepartmentState {
  DepartmentModel department;
  DeviceModel device;
  DepartmentLoaded({required this.department,required this.device});
}

class DepartmentError extends DepartmentState {}

class DepartmentErrorApi extends DepartmentState {
  String error;
  DepartmentErrorApi({required this.error});
}
