import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/error/bloc/report_error_bloc_event.dart';
import 'package:appdemo/modules/error/bloc/report_error_bloc_state.dart';
import 'package:appdemo/modules/error/model/error_infomation_model.dart';
import 'package:appdemo/modules/error/repo/report_error_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportErrorBloc extends Bloc<ReportErrorEvent, ReportErrorState> {
  ReportErrorBloc() : super(ReportErrorInitial()) {
    on<ReportErrorEvent>(
      (event, emit) async {
        if (event is FetchReportError) {
          emit(ReportErrorLoading());
          try {
            ErrorInfomationModel? data =
                await ReportErrorRepo.reportErrorDevice(
                    event.device, event.reason);
            if (data!.status == '200') {
              emit(ReportErrorLoaded(data: data));
            } else {
              emit(ReportErrorErrorApi(error: AppReportErrorTerm.errorFailed));
            }
          } catch (e) {
            emit(ReportErrorError());
          }
        }
      },
    );
  }
}
