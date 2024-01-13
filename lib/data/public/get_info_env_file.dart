import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String?> getApiUrl() async {
  await dotenv.load(fileName: ".env");
  String? apiUrl = dotenv.env['API_URL'];
  return apiUrl;
}

Future<String?> getLoginUrl() async {
  await dotenv.load(fileName: ".env");
  String? apiUrl = dotenv.env['LOGIN_URL'];
  return apiUrl;
}
