import 'package:appdemo/modules/employee/model/employee_model.dart';
import 'package:appdemo/modules/employee/repo/employee_repo.dart';

Future<List<EmployeeData>?> getDataEmployeeFromApi() async {
  final EmployeeModel? apiResponse = await EmployeeRepo.dioGetEmployeeData();
  final List<EmployeeData> dataJsonList = apiResponse!.data!.toList();
  return dataJsonList;
}
