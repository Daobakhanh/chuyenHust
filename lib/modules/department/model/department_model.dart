class DepartmentModel {
  int? statusCode;
  List<DepartmentData>? data;
  int? dataLength;

  DepartmentModel({this.statusCode, this.data, this.dataLength});

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    if (json["status_code"] is int) {
      statusCode = json["status_code"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List)
              .map((e) => DepartmentData.fromJson(e))
              .toList();
    }
    if (json["dataLength"] is int) {
      dataLength = json["dataLength"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData["status_code"] = statusCode;
    jsonData["data"] = data?.map((e) => e.toJson()).toList();
    jsonData["dataLength"] = dataLength;
    return jsonData;
  }
}

class DepartmentData {
  late int id;
  late String title;
  String? code;
  String? slug;
  late String phone;
  String? contact;
  late String email;
  late String address;
  int? userId;
  dynamic authorId;
  int? nursingId;
  dynamic image;
  String? createdAt;
  String? updatedAt;
  String? browser;
  String? browserDay;

  DepartmentData(
      {required this.id,
      required this.title,
      this.code,
      this.slug,
      required this.phone,
      this.contact,
      required this.email,
      required this.address,
      this.userId,
      this.authorId,
      this.nursingId,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.browser,
      this.browserDay});

  DepartmentData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["slug"] is String) {
      slug = json["slug"];
    }
    if (json["phone"] is String) {
      phone = json["phone"];
    }
    if (json["contact"] is String) {
      contact = json["contact"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["address"] is String) {
      address = json["address"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    authorId = json["author_id"];
    if (json["nursing_id"] is int) {
      nursingId = json["nursing_id"];
    }
    image = json["image"];
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["browser"] is String) {
      browser = json["browser"];
    }
    if (json["browser_day"] is String) {
      browserDay = json["browser_day"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["code"] = code;
    data["slug"] = slug;
    data["phone"] = phone;
    data["contact"] = contact;
    data["email"] = email;
    data["address"] = address;
    data["user_id"] = userId;
    data["author_id"] = authorId;
    data["nursing_id"] = nursingId;
    data["image"] = image;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["browser"] = browser;
    data["browser_day"] = browserDay;
    return data;
  }
}
