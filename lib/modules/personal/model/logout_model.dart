
class LogoutModel {
  int? statusCode;
  String? message;

  LogoutModel({this.statusCode, this.message});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    if(json["status_code"] is int) {
      statusCode = json["status_code"];
    }
    if(json["message"] is String) {
      message = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status_code"] = statusCode;
    data["message"] = message;
    return data;
  }
}