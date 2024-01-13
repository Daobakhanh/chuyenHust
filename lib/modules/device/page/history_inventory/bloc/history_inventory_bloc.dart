import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/device/page/history_inventory/bloc/history_inventory_bloc_event.dart';
import 'package:appdemo/modules/device/page/history_inventory/bloc/history_inventory_bloc_state.dart';
import 'package:appdemo/modules/device/page/history_inventory/model/inventory_information_model.dart';
import 'package:appdemo/modules/device/page/history_inventory/repo/history_inventory_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryInventoryBloc
    extends Bloc<HistoryInventoryEvent, HistoryInventoryState> {
  HistoryInventoryBloc() : super(HistoryInventoryInitial()) {
    on<HistoryInventoryEvent>(
      (event, emit) async {
        if (event is FetchHistoryInventory) {
          emit(HistoryInventoryLoading());
          try {
            HistoryInventoryInformationModel? data =
                await HistoryInventoryRepo.dioGetInventoryInformation(
                    event.device);
            if (data != null) {
              emit(HistoryInventoryLoaded(data: data));
            } else {
              emit(HistoryInventoryErrorApi(error: AppDetailDeviceTerm.none));
            }
          } catch (e) {
            emit(HistoryInventoryError());
          }
        }
      },
    );
  }
}
