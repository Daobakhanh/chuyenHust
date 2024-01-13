class HistoryInventoryInformationModel {
  int? statusCode;
  List<Data>? data;
  int? dataLength;

  HistoryInventoryInformationModel(
      {this.statusCode, this.data, this.dataLength});

  HistoryInventoryInformationModel.fromJson(Map<String, dynamic> json) {
    if (json["status_code"] is int) {
      statusCode = json["status_code"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
    if (json["dataLength"] is int) {
      dataLength = json["dataLength"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status_code"] = statusCode;
    data["data"] = data["data"].map((e) => e.toJson()).toList();
    data["dataLength"] = dataLength;
    return data;
  }
}

class Data {
  int? equipmentId;
  int? id;
  String? note;
  String? date;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? model;
  String? serial;

  Data(
      {this.equipmentId,
      this.id,
      this.note,
      this.date,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.model,
      this.serial});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["equipment_id"] is int) {
      equipmentId = json["equipment_id"];
    }
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["note"] is String) {
      note = json["note"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["model"] is String) {
      model = json["model"];
    }
    if (json["serial"] is String) {
      serial = json["serial"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["equipment_id"] = equipmentId;
    data["id"] = id;
    data["note"] = note;
    data["date"] = date;
    data["user_id"] = userId;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["title"] = title;
    data["model"] = model;
    data["serial"] = serial;
    return data;
  }
}
