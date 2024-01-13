import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/personal/bloc/logout_bloc_event.dart';
import 'package:appdemo/modules/personal/bloc/logout_bloc_state.dart';
import 'package:appdemo/modules/personal/model/logout_model.dart';
import 'package:appdemo/modules/personal/repo/logout_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutEvent>(
      (event, emit) async {
        if (event is FetchLogout) {
          emit(LogoutLoading());
          try {
            LogoutModel? data = await LogoutRepo.dioLogout();
            if (data != null) {
              emit(LogoutLoaded(data: data));
            } else {
              emit(LogoutError(error: AppLogoutTerm.logoutError));
            }
          } catch (e) {
            emit(LogoutError(error: e.toString()));
          }
        }
      },
    );
  }
}
