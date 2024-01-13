import 'package:intl/intl.dart';

class DateTimeFormat {
  static String convertDateTime(String originalDateString) {
    // Định dạng chuỗi ngày tháng ban đầu
    final originalFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSZ");
    final originalDateTime = originalFormat.parse(originalDateString);
    final newDateTime = originalDateTime.add(const Duration(hours: 7));
    // Định dạng lại chuỗi ngày tháng theo định dạng mới
    final newFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    final newDateString = newFormat.format(newDateTime);
    return newDateString;
  }
}
