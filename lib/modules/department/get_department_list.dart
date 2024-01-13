import 'package:appdemo/modules/department/repo/department_repo.dart';
import 'package:appdemo/modules/department/model/department_model.dart';

Future<List<DepartmentData>?> getDataDepartmentFromApi() async {
  final DepartmentModel? apiResponse =
      await DepartmentRepo.dioGetDepartmentData();
  final List<DepartmentData> dataJsonList = apiResponse!.data!.toList();
  return dataJsonList;
}
