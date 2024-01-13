import 'package:appdemo/modules/authentication/biometric/bloc/biometric_bloc_event.dart';
import 'package:appdemo/modules/authentication/biometric/bloc/biometric_bloc_state.dart';
import 'package:appdemo/modules/authentication/repo/authentication_repro.dart';
import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/personal/model/user_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  BiometricBloc() : super(BiometricInitial()) {
    on<BiometricEvent>(
      (event, emit) async {
        if (event is FetchBiometric) {
          emit(BiometricLoading());
          try {
            String? email = event.email;
            String? password = event.password;
            final connectivityResult =
                await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.wifi ||
                connectivityResult == ConnectivityResult.mobile) {
              if (email != null && password != null) {
                UserModel? data =
                    await AuhthenticationRepo.diologin(email, password);
                if (data != null) {
                  emit(BiometricLoaded(data: data));
                } else {
                  emit(BiometricLoading());
                }
              } else {
                emit(BiometricErrorLoginFirst(
                    error: AppLoginTerm.needLoginFirst));
              }
            } else {
              emit(BiometricErrorConnectivity(
                  error: AppLoginTerm.notConnectivityWifi));
            }
          } catch (e) {
            emit(BiometricErrorApi(error: e.toString()));
          }
        }
      },
    );
  }
}
