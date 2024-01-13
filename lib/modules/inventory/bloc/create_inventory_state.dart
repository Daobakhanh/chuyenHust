import 'package:appdemo/modules/inventory/model/inventory_model.dart';

abstract class CreateInventoryState {}

class CreateInventoryInitial extends CreateInventoryState {}

class CreateInventoryLoading extends CreateInventoryState {}

class CreateInventoryLoaded extends CreateInventoryState {
  InventoryModel data;
  CreateInventoryLoaded({required this.data});
}

class CreateInventoryError extends CreateInventoryState {}

class CreateInventoryErrorApi extends CreateInventoryState {
  String error;
  CreateInventoryErrorApi({required this.error});
}
