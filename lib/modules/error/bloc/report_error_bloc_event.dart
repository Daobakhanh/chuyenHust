import 'package:appdemo/modules/device/model/device_model.dart';

abstract class ReportErrorEvent {}

class FetchReportError extends ReportErrorEvent {
  DeviceData device;
  String reason;
  FetchReportError({required this.device, required this.reason});
}
