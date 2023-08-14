class LadyHemoglobinGS {
  List<LadyHemoglobinData>? data;
  String? message;

  LadyHemoglobinGS({this.data, this.message});

  LadyHemoglobinGS.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LadyHemoglobinData>[];
      json['data'].forEach((v) {
        data!.add(new LadyHemoglobinData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class LadyHemoglobinData {
  String? id;
  String? womenId;
  int? height;
  int? weight;
  int? hemoglobin;
  WomenHemoglobinGrowthStatus? womenHemoglobinGrowthStatus;
  String? createdAT;
  String? growthStatusName;
  String? growthStatusHiName;

  LadyHemoglobinData(
      {this.id,
        this.womenId,
        this.height,
        this.weight,
        this.hemoglobin,
        this.womenHemoglobinGrowthStatus,
        this.createdAT,
        this.growthStatusName,
        this.growthStatusHiName});

  LadyHemoglobinData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    womenId = json['womenId'];
    height = json['height'];
    weight = json['weight'];
    hemoglobin = json['hemoglobin'];
    womenHemoglobinGrowthStatus = json['womenHemoglobinGrowthStatus'] != null
        ? new WomenHemoglobinGrowthStatus.fromJson(
        json['womenHemoglobinGrowthStatus'])
        : null;
    createdAT = json['createdAT'];
    growthStatusName = json['growthStatus_name'];
    growthStatusHiName = json['growthStatus_hiName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['womenId'] = this.womenId;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['hemoglobin'] = this.hemoglobin;
    if (this.womenHemoglobinGrowthStatus != null) {
      data['womenHemoglobinGrowthStatus'] =
          this.womenHemoglobinGrowthStatus!.toJson();
    }
    data['createdAT'] = this.createdAT;
    data['growthStatus_name'] = this.growthStatusName;
    data['growthStatus_hiName'] = this.growthStatusHiName;
    return data;
  }
}

class WomenHemoglobinGrowthStatus {
  String? id;
  String? name;
  String? hiName;

  WomenHemoglobinGrowthStatus({this.id, this.name, this.hiName});

  WomenHemoglobinGrowthStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hiName = json['hiName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hiName'] = this.hiName;
    return data;
  }
}