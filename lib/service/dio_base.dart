import 'package:appdemo/data/public/get_info_env_file.dart';
import 'package:dio/dio.dart';

class DioBase {
  static Future<Dio> dioWithBaseOptionLogin() async {
    String apiUrl = await getLoginUrl() ?? '';
    final dio = Dio(
      BaseOptions(baseUrl: apiUrl, connectTimeout: const Duration(seconds: 10)),
    );

    return dio;
  }

  static Future<Dio> dioWithBaseOption() async {
    String apiUrl = await getApiUrl() ?? '';
    final dio = Dio(
      BaseOptions(baseUrl: apiUrl, connectTimeout: const Duration(seconds: 10)),
    );

    return dio;
  }
}
