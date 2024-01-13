import 'package:appdemo/data/term/network_term.dart';
import 'package:appdemo/modules/personal/model/logout_model.dart';
import 'package:appdemo/service/dio_base.dart';
import 'package:appdemo/service/store.dart';
import 'package:dio/dio.dart';

class LogoutRepo{
  static Future<LogoutModel?> dioLogout() async {
    final dio = await DioBase.dioWithBaseOption();
    try {
      dio.options.headers['Authorization'] = 'Bearer ${Store.getToken()}';
      final response = await dio.post(ApiConstants.logoutUrl,
          options: Options(
            method: 'get',
            headers: {
              "Authorization": "Bearer ${await Store.getToken()}",
              "Content-Type": "application/json",
            },
          ),
          data: {
            'email': await StoreLogin.getEmail(),
            'password': await StoreLogin.getPassword()
          });
      try {
        return LogoutModel.fromJson(response.data);
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}