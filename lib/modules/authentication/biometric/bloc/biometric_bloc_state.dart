import 'package:appdemo/modules/personal/model/user_model.dart';

abstract class BiometricState {}

class BiometricInitial extends BiometricState {}

class BiometricLoading extends BiometricState {}

class BiometricLoaded extends BiometricState {
  UserModel data;
  BiometricLoaded({required this.data});
}

class BiometricError extends BiometricState {}

class BiometricErrorApi extends BiometricState {
  String error;
  BiometricErrorApi({required this.error});
}

class BiometricErrorConnectivity extends BiometricState {
  String error;
  BiometricErrorConnectivity({required this.error});
}

class BiometricErrorLoginFirst extends BiometricState {
  String error;
  BiometricErrorLoginFirst({required this.error});
}