import 'package:appdemo/data/term/network_term.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/modules/device/page/history_inventory/model/inventory_information_model.dart';
import 'package:appdemo/service/dio_base.dart';
import 'package:appdemo/service/store.dart';
import 'package:dio/dio.dart';

class HistoryInventoryRepo {
  static Future<HistoryInventoryInformationModel?> dioGetInventoryInformation(
      DeviceData device) async {
    final dio = await DioBase.dioWithBaseOption();
    try {
      dio.options.headers['Authorization'] = 'Bearer ${Store.getToken()}';
      final response = await dio.get(
        ApiConstants.inventoryInformationUrl + device.id.toString(),
        options: Options(
          method: 'get',
          headers: {
            "Authorization": "Bearer ${await Store.getToken()}",
            "Content-Type": "application/json",
          },
        ),
      );
      try {
        return HistoryInventoryInformationModel.fromJson(response.data);
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
