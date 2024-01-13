import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/inventory/bloc/create_inventory_event.dart';
import 'package:appdemo/modules/inventory/bloc/create_inventory_state.dart';
import 'package:appdemo/modules/inventory/model/inventory_model.dart';
import 'package:appdemo/modules/inventory/repo/inventory_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateInventoryBloc
    extends Bloc<CreateInventoryEvent, CreateInventoryState> {
  CreateInventoryBloc() : super(CreateInventoryInitial()) {
    on<CreateInventoryEvent>(
      (event, emit) async {
        if (event is FetchCreateInventory) {
          emit(CreateInventoryLoading());
          try {
            InventoryModel? data = await InventoryRepo.createInventoryDevice(
                event.device, event.note);
            if (data!.statusCode == 200) {
              emit(CreateInventoryLoaded(data: data));
            } else {
              emit(CreateInventoryErrorApi(
                  error: AppCreateInventoryTerm.createInventoryFailed));
            }
          } catch (e) {
            emit(CreateInventoryError());
          }
        }
      },
    );
  }
}
