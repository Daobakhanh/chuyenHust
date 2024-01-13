import 'package:appdemo/modules/error/model/error_infomation_model.dart';

abstract class ReportErrorState {}

class ReportErrorInitial extends ReportErrorState {}

class ReportErrorLoading extends ReportErrorState {}

class ReportErrorLoaded extends ReportErrorState {
  ErrorInfomationModel data;
  ReportErrorLoaded({required this.data});
}

class ReportErrorError extends ReportErrorState {}

class ReportErrorErrorApi extends ReportErrorState {
  String error;
  ReportErrorErrorApi({required this.error});
}
