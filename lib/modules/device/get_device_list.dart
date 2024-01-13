import 'package:appdemo/modules/device/repo/device_repo.dart';
import 'package:appdemo/modules/device/model/device_model.dart';

Future<List<DeviceData>?> getDataFromApi() async {
  final DeviceModel? apiResponse = await DeviceRepo.dioGetDeviceData();
  final List<DeviceData> dataJsonList = apiResponse!.data!.toList();
  return dataJsonList;
}
