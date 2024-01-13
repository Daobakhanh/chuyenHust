class DeviceModel {
  String? status;
  List<DeviceData>? data;
  int? dataLength;

  DeviceModel({this.status, this.data, this.dataLength});

  DeviceModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => DeviceData.fromJson(e)).toList();
    }
    if (json["dataLength"] is int) {
      dataLength = json["dataLength"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData["status"] = status;
    jsonData["data"] = data?.map((e) => e.toJson()).toList();
    jsonData["dataLength"] = dataLength;
    return jsonData;
  }
}

class DeviceData {
  int? id;
  late String title;
  String? slug;
  String? alt;
  String? path;
  dynamic content;
  String? type;
  dynamic userId;
  String? createdAt;
  String? updatedAt;
  String? model;
  String? yearManufacture;
  dynamic warehouse;
  String? code;
  String? serial;
  late String status;
  dynamic risk;
  int? amount;
  String? manufacturer;
  String? origin;
  dynamic maintenanceId;
  dynamic providerId;
  dynamic repairId;
  int? cateId;
  int? devicesId;
  int? unitId;
  int? departmentId;
  int? image;
  String? lastInspection;
  String? nextInspection;
  String? lastMaintenance;
  String? nextMaintenance;
  dynamic specificat;
  dynamic firstValue;
  dynamic presentValue;
  String? process;
  String? yearUse;
  int? officerChargeId;
  dynamic officersUseId;
  String? firstInformation;
  String? importPrice;
  int? bidProjectId;
  dynamic warrantyDate;
  dynamic configurat;
  dynamic depreciat;
  dynamic note;
  int? officerDepartmentChargeId;
  dynamic officersTrainingId;
  dynamic supplieId;
  int? regularInspection;
  int? regularMaintenance;
  int? parentId;
  String? dateFailure;
  String? reason;
  String? criticalLevel;
  dynamic dateDelivery;
  dynamic liquidationDate;
  int? datePersonId;
  String? updateDay;
  dynamic funding;
  int? periodicRadiationInspection;
  String? lastRadiationInspection;
  String? nextRadiationInspection;
  String? jvContractTerminationDate;
  int? periodOfExternalQualityAssessment;
  dynamic lastExternalQualityAssessment;
  String? nextExternalQualityAssessment;
  int? periodOfClinicEnvironmentInspection;
  String? lastClinicEnvironmentInspection;
  String? nextClinicEnvironmentInspection;
  int? periodOfLicenseRenewalOfRadiationWork;
  String? lastLicenseRenewalOfRadiationWork;
  String? nextLicenseRenewalOfRadiationWork;
  String? hashcode;

  DeviceData(
      {this.id,
      required this.title,
      this.slug,
      this.alt,
      this.path,
      this.content,
      this.type,
      this.userId,
      this.createdAt,
      this.updatedAt,
      required this.model,
      required this.yearManufacture,
      this.warehouse,
      this.code,
      required this.serial,
      required this.status,
      this.risk,
      this.amount,
      required this.manufacturer,
      required this.origin,
      this.maintenanceId,
      this.providerId,
      this.repairId,
      this.cateId,
      this.devicesId,
      this.unitId,
      this.departmentId,
      this.image,
      this.lastInspection,
      this.nextInspection,
      this.lastMaintenance,
      this.nextMaintenance,
      this.specificat,
      this.firstValue,
      this.presentValue,
      this.process,
      required this.yearUse,
      this.officerChargeId,
      this.officersUseId,
      this.firstInformation,
      this.importPrice,
      this.bidProjectId,
      this.warrantyDate,
      this.configurat,
      this.depreciat,
      this.note,
      this.officerDepartmentChargeId,
      this.officersTrainingId,
      this.supplieId,
      this.regularInspection,
      this.regularMaintenance,
      this.parentId,
      this.dateFailure,
      this.reason,
      this.criticalLevel,
      this.dateDelivery,
      this.liquidationDate,
      this.datePersonId,
      this.updateDay,
      this.funding,
      this.periodicRadiationInspection,
      this.lastRadiationInspection,
      this.nextRadiationInspection,
      this.jvContractTerminationDate,
      this.periodOfExternalQualityAssessment,
      this.lastExternalQualityAssessment,
      this.nextExternalQualityAssessment,
      this.periodOfClinicEnvironmentInspection,
      this.lastClinicEnvironmentInspection,
      this.nextClinicEnvironmentInspection,
      this.periodOfLicenseRenewalOfRadiationWork,
      this.lastLicenseRenewalOfRadiationWork,
      this.nextLicenseRenewalOfRadiationWork,
      this.hashcode});

  DeviceData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["slug"] is String) {
      slug = json["slug"];
    }
    if (json["alt"] is String) {
      alt = json["alt"];
    }
    if (json["path"] is String) {
      path = json["path"];
    }
    content = json["content"];
    if (json["type"] is String) {
      type = json["type"];
    }
    userId = json["user_id"];
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["model"] is String) {
      model = json["model"];
    }
    if (json["year_manufacture"] is String) {
      yearManufacture = json["year_manufacture"];
    }
    warehouse = json["warehouse"];
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["serial"] is String) {
      serial = json["serial"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    risk = json["risk"];
    if (json["amount"] is int) {
      amount = json["amount"];
    }
    if (json["manufacturer"] is String) {
      manufacturer = json["manufacturer"];
    }
    if (json["origin"] is String) {
      origin = json["origin"];
    }
    maintenanceId = json["maintenance_id"];
    providerId = json["provider_id"];
    repairId = json["repair_id"];
    if (json["cate_id"] is int) {
      cateId = json["cate_id"];
    }
    if (json["devices_id"] is int) {
      devicesId = json["devices_id"];
    }
    if (json["unit_id"] is int) {
      unitId = json["unit_id"];
    }
    if (json["department_id"] is int) {
      departmentId = json["department_id"];
    }
    if (json["image"] is int) {
      image = json["image"];
    }
    if (json["last_inspection"] is String) {
      lastInspection = json["last_inspection"];
    }
    if (json["next_inspection"] is String) {
      nextInspection = json["next_inspection"];
    }
    if (json["last_maintenance"] is String) {
      lastMaintenance = json["last_maintenance"];
    }
    if (json["next_maintenance"] is String) {
      nextMaintenance = json["next_maintenance"];
    }
    specificat = json["specificat"];
    firstValue = json["first_value"];
    presentValue = json["present_value"];
    if (json["process"] is String) {
      process = json["process"];
    }
    if (json["year_use"] is String) {
      yearUse = json["year_use"];
    }
    if (json["officer_charge_id"] is int) {
      officerChargeId = json["officer_charge_id"];
    }
    officersUseId = json["officers_use_id"];
    if (json["first_information"] is String) {
      firstInformation = json["first_information"];
    }
    if (json["import_price"] is String) {
      importPrice = json["import_price"];
    }
    if (json["bid_project_id"] is int) {
      bidProjectId = json["bid_project_id"];
    }
    warrantyDate = json["warranty_date"];
    configurat = json["configurat"];
    depreciat = json["depreciat"];
    note = json["note"];
    if (json["officer_department_charge_id"] is int) {
      officerDepartmentChargeId = json["officer_department_charge_id"];
    }
    officersTrainingId = json["officers_training_id"];
    supplieId = json["supplie_id"];
    if (json["regular_inspection"] is int) {
      regularInspection = json["regular_inspection"];
    }
    if (json["regular_maintenance"] is int) {
      regularMaintenance = json["regular_maintenance"];
    }
    if (json["parent_id"] is int) {
      parentId = json["parent_id"];
    }
    if (json["date_failure"] is String) {
      dateFailure = json["date_failure"];
    }
    if (json["reason"] is String) {
      reason = json["reason"];
    }
    if (json["critical_level"] is String) {
      criticalLevel = json["critical_level"];
    }
    dateDelivery = json["date_delivery"];
    liquidationDate = json["liquidation_date"];
    if (json["date_person_id"] is int) {
      datePersonId = json["date_person_id"];
    }
    if (json["update_day"] is String) {
      updateDay = json["update_day"];
    }
    funding = json["funding"];
    if (json["periodic_radiation_inspection"] is int) {
      periodicRadiationInspection = json["periodic_radiation_inspection"];
    }
    if (json["last_radiation_inspection"] is String) {
      lastRadiationInspection = json["last_radiation_inspection"];
    }
    if (json["next_radiation_inspection"] is String) {
      nextRadiationInspection = json["next_radiation_inspection"];
    }
    if (json["jv_contract_termination_date"] is String) {
      jvContractTerminationDate = json["jv_contract_termination_date"];
    }
    if (json["period_of_external_quality_assessment"] is int) {
      periodOfExternalQualityAssessment =
          json["period_of_external_quality_assessment"];
    }
    lastExternalQualityAssessment = json["last_external_quality_assessment"];
    if (json["next_external_quality_assessment"] is String) {
      nextExternalQualityAssessment = json["next_external_quality_assessment"];
    }
    if (json["period_of_clinic_environment_inspection"] is int) {
      periodOfClinicEnvironmentInspection =
          json["period_of_clinic_environment_inspection"];
    }
    if (json["last_clinic_environment_inspection"] is String) {
      lastClinicEnvironmentInspection =
          json["last_clinic_environment_inspection"];
    }
    if (json["next_clinic_environment_inspection"] is String) {
      nextClinicEnvironmentInspection =
          json["next_clinic_environment_inspection"];
    }
    if (json["period_of_license_renewal_of_radiation_work"] is int) {
      periodOfLicenseRenewalOfRadiationWork =
          json["period_of_license_renewal_of_radiation_work"];
    }
    if (json["last_license_renewal_of_radiation_work"] is String) {
      lastLicenseRenewalOfRadiationWork =
          json["last_license_renewal_of_radiation_work"];
    }
    if (json["next_license_renewal_of_radiation_work"] is String) {
      nextLicenseRenewalOfRadiationWork =
          json["next_license_renewal_of_radiation_work"];
    }
    if (json["hash_code"] is String) {
      hashcode = json["hash_code"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["slug"] = slug;
    data["alt"] = alt;
    data["path"] = path;
    data["content"] = content;
    data["type"] = type;
    data["user_id"] = userId;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["model"] = model;
    data["year_manufacture"] = yearManufacture;
    data["warehouse"] = warehouse;
    data["code"] = code;
    data["serial"] = serial;
    data["status"] = status;
    data["risk"] = risk;
    data["amount"] = amount;
    data["manufacturer"] = manufacturer;
    data["origin"] = origin;
    data["maintenance_id"] = maintenanceId;
    data["provider_id"] = providerId;
    data["repair_id"] = repairId;
    data["cate_id"] = cateId;
    data["devices_id"] = devicesId;
    data["unit_id"] = unitId;
    data["department_id"] = departmentId;
    data["image"] = image;
    data["last_inspection"] = lastInspection;
    data["next_inspection"] = nextInspection;
    data["last_maintenance"] = lastMaintenance;
    data["next_maintenance"] = nextMaintenance;
    data["specificat"] = specificat;
    data["first_value"] = firstValue;
    data["present_value"] = presentValue;
    data["process"] = process;
    data["year_use"] = yearUse;
    data["officer_charge_id"] = officerChargeId;
    data["officers_use_id"] = officersUseId;
    data["first_information"] = firstInformation;
    data["import_price"] = importPrice;
    data["bid_project_id"] = bidProjectId;
    data["warranty_date"] = warrantyDate;
    data["configurat"] = configurat;
    data["depreciat"] = depreciat;
    data["note"] = note;
    data["officer_department_charge_id"] = officerDepartmentChargeId;
    data["officers_training_id"] = officersTrainingId;
    data["supplie_id"] = supplieId;
    data["regular_inspection"] = regularInspection;
    data["regular_maintenance"] = regularMaintenance;
    data["parent_id"] = parentId;
    data["date_failure"] = dateFailure;
    data["reason"] = reason;
    data["critical_level"] = criticalLevel;
    data["date_delivery"] = dateDelivery;
    data["liquidation_date"] = liquidationDate;
    data["date_person_id"] = datePersonId;
    data["update_day"] = updateDay;
    data["funding"] = funding;
    data["periodic_radiation_inspection"] = periodicRadiationInspection;
    data["last_radiation_inspection"] = lastRadiationInspection;
    data["next_radiation_inspection"] = nextRadiationInspection;
    data["jv_contract_termination_date"] = jvContractTerminationDate;
    data["period_of_external_quality_assessment"] =
        periodOfExternalQualityAssessment;
    data["last_external_quality_assessment"] = lastExternalQualityAssessment;
    data["next_external_quality_assessment"] = nextExternalQualityAssessment;
    data["period_of_clinic_environment_inspection"] =
        periodOfClinicEnvironmentInspection;
    data["last_clinic_environment_inspection"] =
        lastClinicEnvironmentInspection;
    data["next_clinic_environment_inspection"] =
        nextClinicEnvironmentInspection;
    data["period_of_license_renewal_of_radiation_work"] =
        periodOfLicenseRenewalOfRadiationWork;
    data["last_license_renewal_of_radiation_work"] =
        lastLicenseRenewalOfRadiationWork;
    data["next_license_renewal_of_radiation_work"] =
        nextLicenseRenewalOfRadiationWork;
    data["hash_code"] = hashCode;
    return data;
  }
}
