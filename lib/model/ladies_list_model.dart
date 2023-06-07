class LadiesListviewModel {
  List<LadiesListviewModelData>? data;
  LadiesListviewModel({this.data});

  LadiesListviewModel.fromJson(Map<String, dynamic> json) {
    if (json['Women'] != null) {
      data = <LadiesListviewModelData>[];
      json['Women'].forEach((v) {
        data!.add(new LadiesListviewModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Women'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LadiesListviewModelData {
  String? id;
  String? name;
  String? husbandName;
  String? aadhar;
  String? dOB;
  int? mobileNumber;
  WomenCategory? womenCategory;
  String? categoryId;
  Null? otherCast;
  String? svasthaId;
  String? cast;
  bool? isReligiousMinority;
  String? maritalStatus;
  bool? isFirstPregnancy;
  bool? areYouPregnant;
  bool? isAbortionBefore;
  bool? isBeneficiary;
  String? lastMenstrulPeriod;

  LadiesListviewModelData(
      {this.id,
        this.name,
        this.husbandName,
        this.aadhar,
        this.dOB,
        this.mobileNumber,
        this.womenCategory,
        this.categoryId,
        this.otherCast,
        this.svasthaId,
        this.cast,
        this.isReligiousMinority,
        this.maritalStatus,
        this.isFirstPregnancy,
        this.areYouPregnant,
        this.isAbortionBefore,
        this.isBeneficiary,
        this.lastMenstrulPeriod});

  LadiesListviewModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    husbandName = json['husbandName'];
    aadhar = json['aadhar'];
    dOB = json['DOB'];
    mobileNumber = json['mobileNumber'];
    womenCategory = json['WomenCategory'] != null
        ? new WomenCategory.fromJson(json['WomenCategory'])
        : null;
    categoryId = json['categoryId'];
    otherCast = json['otherCast'];
    svasthaId = json['svasthaId'];
    cast = json['cast'];
    isReligiousMinority = json['isReligiousMinority'];
    maritalStatus = json['maritalStatus'];
    isFirstPregnancy = json['isFirstPregnancy'];
    areYouPregnant = json['areYouPregnant'];
    isAbortionBefore = json['isAbortionBefore'];
    isBeneficiary = json['isBeneficiary'];
    lastMenstrulPeriod = json['lastMenstrulPeriod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['husbandName'] = this.husbandName;
    data['aadhar'] = this.aadhar;
    data['DOB'] = this.dOB;
    data['mobileNumber'] = this.mobileNumber;
    if (this.womenCategory != null) {
      data['WomenCategory'] = this.womenCategory!.toJson();
    }
    data['categoryId'] = this.categoryId;
    data['otherCast'] = this.otherCast;
    data['svasthaId'] = this.svasthaId;
    data['cast'] = this.cast;
    data['isReligiousMinority'] = this.isReligiousMinority;
    data['maritalStatus'] = this.maritalStatus;
    data['isFirstPregnancy'] = this.isFirstPregnancy;
    data['areYouPregnant'] = this.areYouPregnant;
    data['isAbortionBefore'] = this.isAbortionBefore;
    data['isBeneficiary'] = this.isBeneficiary;
    data['lastMenstrulPeriod'] = this.lastMenstrulPeriod;
    return data;
  }
}

class WomenCategory {
  String? name;
  String? hiName;
  bool? isActive;

  WomenCategory({this.name, this.hiName, this.isActive});

  WomenCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hiName = json['hiName'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['hiName'] = this.hiName;
    data['isActive'] = this.isActive;
    return data;
  }
}

class Pagination {
  int? total;
  int? perPage;
  int? currentPage;
  int? totalPage;

  Pagination({this.total, this.perPage, this.currentPage, this.totalPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_page'] = this.totalPage;
    return data;
  }
}