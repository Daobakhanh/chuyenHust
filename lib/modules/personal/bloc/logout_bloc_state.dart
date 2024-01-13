import 'package:appdemo/modules/personal/model/logout_model.dart';

abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutLoaded extends LogoutState {
  LogoutModel data;
  LogoutLoaded({required this.data});
}

class LogoutError extends LogoutState {
  String error;
  LogoutError({required this.error});
}
