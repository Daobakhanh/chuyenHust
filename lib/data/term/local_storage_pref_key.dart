import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPrefKey{
  final emailStore = const FlutterSecureStorage();
  final passwordStore = const FlutterSecureStorage();
  final keyEmailRemember = "emailremember";
  final keyPasswordRememer = "passwordremember";
  final keyEmailRememberToggle = "emailremembertoggle";
  final keyPasswordRememberToggle = "passwordremembertoggle";
}