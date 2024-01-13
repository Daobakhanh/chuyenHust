import 'package:appdemo/modules/device/bloc/device_bloc_event.dart';
import 'package:appdemo/modules/device/bloc/device_bloc_state.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/modules/device/repo/device_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  DeviceBloc() : super(DeviceInitial()) {
    on<DeviceEvent>(
      (event, emit) async {
        if (event is FetchDevice) {
          emit(DeviceLoading());
          try {
            DeviceModel? data = await DeviceRepo.dioGetDeviceData();
            if (data != null) {
              emit(DeviceLoaded(data: data));
            } else {
              emit(DeviceError());
            }
          } catch (e) {
            emit(DeviceErrorApi(error: e.toString()));
          }
        }
      },
    );
  }
}
