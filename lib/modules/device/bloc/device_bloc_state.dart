import 'package:appdemo/modules/device/model/device_model.dart';

abstract class DeviceState {}

class DeviceInitial extends DeviceState {}

class DeviceLoading extends DeviceState {}

class DeviceLoaded extends DeviceState {
  DeviceModel data;
  DeviceLoaded({required this.data});
}

class DeviceReload extends DeviceState {}

class DeviceError extends DeviceState {}

class DeviceErrorApi extends DeviceState {
  String error;
  DeviceErrorApi({required this.error});
}
