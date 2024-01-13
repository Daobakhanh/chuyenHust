import 'package:appdemo/data/term/network_term.dart';
import 'package:appdemo/modules/personal/model/user_model.dart';
import 'package:appdemo/service/dio_base.dart';
import 'package:appdemo/service/store.dart';

class AuhthenticationRepo {
  static Future<void> _saveToken(Map<String, dynamic> data) async {
    final token = data['access_token'];
    await Store.setToken(token);
  }

  static Future<UserModel?> diologin(String email, String password) async {
    final dio = await DioBase.dioWithBaseOptionLogin();
    try {
      final response = await dio.post(
        ApiConstants.loginUrl,
        data: {"email": email, "password": password},
      );
      await _saveToken(response.data);
      return UserModel.fromJson((response.data));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }
}
