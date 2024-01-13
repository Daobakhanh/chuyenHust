import 'package:appdemo/data/term/network_term.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/service/dio_base.dart';
import 'package:appdemo/service/store.dart';
import 'package:dio/dio.dart';

class DeviceRepo {
  static Future<DeviceModel?> dioGetDeviceData() async {
    final dio = await DioBase.dioWithBaseOption();
    try {
      dio.options.headers['Authorization'] = 'Bearer ${Store.getToken()}';
      final response = await dio.get(
        ApiConstants.equipmentUrl,
        options: Options(
          method: 'get',
          headers: {
            "Authorization": "Bearer ${await Store.getToken()}",
            "Content-Type": "application/json",
          },
        ),
      );
      try {
        return DeviceModel.fromJson(response.data);
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
