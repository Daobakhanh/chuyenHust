class UserModel {
  UserData? data;
  int? statusCode;
  String? accessToken;
  String? tokenType;

  UserModel({this.data, this.statusCode, this.accessToken, this.tokenType});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] is Map) {
      data = json["data"] == null ? null : UserData.fromJson(json["data"]);
    }
    if (json["status_code"] is int) {
      statusCode = json["status_code"];
    }
    if (json["access_token"] is String) {
      accessToken = json["access_token"];
    }
    if (json["token_type"] is String) {
      tokenType = json["token_type"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData["data"] = data?.toJson();
    jsonData["status_code"] = statusCode;
    jsonData["access_token"] = accessToken;
    jsonData["token_type"] = tokenType;
    return jsonData;
  }
}

class UserData {
  int? id;
  String? name;
  late String email;
  String? emailVerifiedAt;
  dynamic currentTeamId;
  String? displayname;
  dynamic image;
  dynamic address;
  dynamic birthday;
  late String phone;
  int? departmentId;
  late String gender;
  int? isDisabled;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;

  UserData(
      {this.id,
      this.name,
      required this.email,
      this.emailVerifiedAt,
      this.currentTeamId,
      required this.displayname,
      this.image,
      this.address,
      this.birthday,
      required this.phone,
      this.departmentId,
      required this.gender,
      this.isDisabled,
      this.createdAt,
      this.updatedAt,
      this.profilePhotoUrl});

  UserData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["email_verified_at"] is String) {
      emailVerifiedAt = json["email_verified_at"];
    }
    currentTeamId = json["current_team_id"];
    if (json["displayname"] is String) {
      displayname = json["displayname"];
    }
    image = json["image"];
    address = json["address"];
    birthday = json["birthday"];
    if (json["phone"] is String) {
      phone = json["phone"];
    }
    if (json["department_id"] is int) {
      departmentId = json["department_id"];
    }
    if (json["gender"] is String) {
      gender = json["gender"];
    }
    if (json["is_disabled"] is int) {
      isDisabled = json["is_disabled"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["profile_photo_url"] is String) {
      profilePhotoUrl = json["profile_photo_url"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["email_verified_at"] = emailVerifiedAt;
    data["current_team_id"] = currentTeamId;
    data["displayname"] = displayname;
    data["image"] = image;
    data["address"] = address;
    data["birthday"] = birthday;
    data["phone"] = phone;
    data["department_id"] = departmentId;
    data["gender"] = gender;
    data["is_disabled"] = isDisabled;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["profile_photo_url"] = profilePhotoUrl;
    return data;
  }
}
