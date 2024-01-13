import 'package:appdemo/modules/employee/model/employee_model.dart';

abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  EmployeeModel employee;
  EmployeeLoaded({required this.employee});
}

class EmployeeError extends EmployeeState {}

class EmployeeErrorApi extends EmployeeState {
  String error;
  EmployeeErrorApi({required this.error});
}
