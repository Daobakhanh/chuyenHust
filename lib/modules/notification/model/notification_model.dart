class NotificationModel {
  int? status;
  List<NotificationData>? data;
  int? total;

  NotificationModel({this.status, this.data, this.total});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if(json["status"] is int) {
      status = json["status"];
    }
    if(json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => NotificationData.fromJson(e)).toList();
    }
    if(json["total"] is int) {
      total = json["total"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["data"] = data["data"].map((e) => e.toJson()).toList();
      data["total"] = total;
    return data;
  }
}

class NotificationData {
  String? id;
  String? type;
  int? notifiableId;
  String? notifiableType;
  Data? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  NotificationData({this.id, this.type, this.notifiableId, this.notifiableType, this.data, this.readAt, this.createdAt, this.updatedAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["notifiable_id"] is int) {
      notifiableId = json["notifiable_id"];
    }
    if(json["notifiable_type"] is String) {
      notifiableType = json["notifiable_type"];
    }
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
    if(json["read_at"] is String) {
      readAt = json["read_at"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["type"] = type;
    data["notifiable_id"] = notifiableId;
    data["notifiable_type"] = notifiableType;
    data["data"] = data["data"].toJson();
      data["read_at"] = readAt;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}

class Data {
  int? id;
  int? equipId;
  int? userId;
  String? content;

  Data({this.id, this.equipId, this.userId, this.content});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["equip_id"] is int) {
      equipId = json["equip_id"];
    }
    if(json["user_id"] is int) {
      userId = json["user_id"];
    }
    if(json["content"] is String) {
      content = json["content"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["equip_id"] = equipId;
    data["user_id"] = userId;
    data["content"] = content;
    return data;
  }
}