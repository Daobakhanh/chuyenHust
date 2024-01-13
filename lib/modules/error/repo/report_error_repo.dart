import 'package:appdemo/data/term/network_term.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/modules/error/model/error_infomation_model.dart';
import 'package:appdemo/service/dio_base.dart';
import 'package:appdemo/service/store.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ReportErrorRepo {
  static Future<ErrorInfomationModel?> reportErrorDevice(
      DeviceData device, String reason) async {
    final dio = await DioBase.dioWithBaseOption();
    String dateTime = DateFormat('yyyy-MM-dd HH-mm-ss').format(DateTime.now());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${Store.getToken()}';
      final response =
          await dio.post(ApiConstants.reportErrorUrl + device.id.toString(),
              options: Options(
                method: 'post',
                headers: {
                  "Authorization": "Bearer ${await Store.getToken()}",
                  "Content-Type": "application/json",
                },
              ),
              data: {"date_failure": dateTime, "reason": reason});
      try {
        return ErrorInfomationModel.fromJson(response.data);
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
