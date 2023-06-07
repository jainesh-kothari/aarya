class AddNewLadyResponse {
  Data? data;
  String? message;

  AddNewLadyResponse({this.data, this.message});

  AddNewLadyResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? name;
  String? husbandName;
  String? aadhar;
  String? svasthaId;
  String? dOB;
  int? mobileNumber;
  String? categoryId;
  String? cast;
  bool? isReligiousMinority;
  String? maritalStatus;
  bool? isFirstPregnancy;
  bool? areYouPregnant;
  bool? isAbortionBefore;
  bool? isBeneficiary;
  String? lastMenstrulPeriod;

  Data(
      {this.id,
        this.userId,
        this.name,
        this.husbandName,
        this.aadhar,
        this.svasthaId,
        this.dOB,
        this.mobileNumber,
        this.categoryId,
        this.cast,
        this.isReligiousMinority,
        this.maritalStatus,
        this.isFirstPregnancy,
        this.areYouPregnant,
        this.isAbortionBefore,
        this.isBeneficiary,
        this.lastMenstrulPeriod});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    husbandName = json['husbandName'];
    aadhar = json['aadhar'];
    svasthaId = json['svasthaId'];
    dOB = json['DOB'];
    mobileNumber = json['mobileNumber'];
    categoryId = json['categoryId'];
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
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['husbandName'] = this.husbandName;
    data['aadhar'] = this.aadhar;
    data['svasthaId'] = this.svasthaId;
    data['DOB'] = this.dOB;
    data['mobileNumber'] = this.mobileNumber;
    data['categoryId'] = this.categoryId;
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