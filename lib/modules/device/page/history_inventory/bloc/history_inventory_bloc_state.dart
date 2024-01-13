import 'package:appdemo/modules/device/page/history_inventory/model/inventory_information_model.dart';

abstract class HistoryInventoryState {}

class HistoryInventoryInitial extends HistoryInventoryState {}

class HistoryInventoryLoading extends HistoryInventoryState {}

class HistoryInventoryLoaded extends HistoryInventoryState {
  HistoryInventoryInformationModel data;
  HistoryInventoryLoaded({required this.data});
}

class HistoryInventoryError extends HistoryInventoryState {}

class HistoryInventoryErrorApi extends HistoryInventoryState {
  String error;
  HistoryInventoryErrorApi({required this.error});
}
