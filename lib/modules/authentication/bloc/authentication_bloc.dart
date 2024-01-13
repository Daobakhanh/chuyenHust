import 'package:appdemo/modules/authentication/bloc/authentication_bloc_event.dart';
import 'package:appdemo/modules/authentication/bloc/authentication_bloc_state.dart';
import 'package:appdemo/modules/authentication/repo/authentication_repro.dart';
import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/personal/model/user_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>(
      (event, emit) async {
        if (event is FetchLogin) {
          emit(AuthenticationLoading());
          try {
            String email = event.email;
            String password = event.password;
            final connectivityResult =
                await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.wifi ||
                connectivityResult == ConnectivityResult.mobile) {
              UserModel? data =
                  await AuhthenticationRepo.diologin(email, password);
              if (data != null) {
                emit(AuthenticationLoaded(data: data));
              } else {
                emit(AuthenticationError());
              }
            } else {
              emit(AuthenticationErrorConnectivity(
                  error: AppLoginTerm.notConnectivityWifi));
            }
          } catch (e) {
            emit(AuthenticationErrorApi(error: e.toString()));
          }
        }
      },
    );
  }
}
