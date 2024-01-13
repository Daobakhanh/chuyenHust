import 'package:appdemo/data/term/network_term.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/modules/inventory/model/inventory_model.dart';
import 'package:appdemo/service/dio_base.dart';
import 'package:appdemo/service/store.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class InventoryRepo {
  static Future<InventoryModel?> createInventoryDevice(
      DeviceData device, String note) async {
    final dio = await DioBase.dioWithBaseOption();
    String dateTime = DateFormat('yyyy-MM-dd HH-mm-ss').format(DateTime.now());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${Store.getToken()}';
      final response =
          await dio.post(ApiConstants.createInventoryUrl + device.id.toString(),
              options: Options(
                method: 'post',
                headers: {
                  "Authorization": "Bearer ${await Store.getToken()}",
                  "Content-Type": "application/json",
                },
              ),
              data: {"date_delivery": dateTime, "note": note});
      try {
        return InventoryModel.fromJson(response.data);
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
