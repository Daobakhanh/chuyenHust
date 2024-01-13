import 'package:appdemo/modules/device/model/device_model.dart';

abstract class CreateInventoryEvent {}

class FetchCreateInventory extends CreateInventoryEvent {
  DeviceData device;
  String note;
  FetchCreateInventory({required this.device, required this.note});
}
