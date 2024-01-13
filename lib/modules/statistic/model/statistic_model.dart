class StatisticModel {
  int? departmentId;
  String? departmentTitle;
  int? brokenEquipmentsCount;
  int? repairingEquipmentsCount;

  StatisticModel(
      {this.departmentId,
      this.departmentTitle,
      this.brokenEquipmentsCount,
      this.repairingEquipmentsCount});

  StatisticModel.fromJson(Map<String, dynamic> json) {
    if (json["departmentId"] is int) {
      departmentId = json["departmentId"];
    }
    if (json["departmentTitle"] is String) {
      departmentTitle = json["departmentTitle"];
    }
    if (json["brokenEquipmentsCount"] is int) {
      brokenEquipmentsCount = json["brokenEquipmentsCount"];
    }
    if (json["repairingEquipmentsCount"] is int) {
      repairingEquipmentsCount = json["repairingEquipmentsCount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["departmentId"] = departmentId;
    data["departmentTitle"] = departmentTitle;
    data["brokenEquipmentsCount"] = brokenEquipmentsCount;
    data["repairingEquipmentsCount"] = repairingEquipmentsCount;
    return data;
  }
}
