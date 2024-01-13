import 'package:appdemo/data/term/network_term.dart';
import 'package:appdemo/modules/department/model/department_model.dart';
import 'package:appdemo/service/dio_base.dart';
import 'package:appdemo/service/store.dart';
import 'package:dio/dio.dart';

class DepartmentRepo {
  static Future<DepartmentModel?> dioGetDepartmentData() async {
    final dio = await DioBase.dioWithBaseOption();
    try {
      final token = await Store.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        ApiConstants.departmentUrl,
        options: Options(
          method: 'get',
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      try {
        return DepartmentModel.fromJson(response.data);
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
