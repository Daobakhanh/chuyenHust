class InventoryModel {
  int? statusCode;
  String? message;

  InventoryModel({this.statusCode, this.message});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    if (json["status_code"] is int) {
      statusCode = json["status_code"];
    }
    if (json["message"] is String) {
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
