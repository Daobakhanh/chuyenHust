import 'package:appdemo/modules/device/model/device_model.dart';

abstract class HistoryInventoryEvent {}

class FetchHistoryInventory extends HistoryInventoryEvent {
  DeviceData device;
  FetchHistoryInventory({required this.device});
}
