class SingleChildData {
  Data? data;
  String? message;

  SingleChildData({this.data, this.message});

  SingleChildData.fromJson(Map<String, dynamic> json) {
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
  String? aadhar;
  bool? hasAadhar;
  String? dOB;
  String? gender;
  String? fatherName;
  String? motherName;
  int? mobileNumber;
  String? categoryId;
  String? cast;
  String? motherAdhar;
  String? fatherOccupation;
  String? motherSelfHelpGroup;
  Null? filePath;
  Null? mediaId;
  bool? isReligiousMinority;
  Null? weightOnBirth;
  Null? heightOnBbirth;
  bool? isVerified;
  bool? deleted;
  String? stateId;
  String? districtId;
  String? areaId;
  String? blockId;
  String? panchayatId;
  String? gramPanchayatId;
  String? centerId;

  Data(
      {this.id,
        this.userId,
        this.name,
        this.aadhar,
        this.hasAadhar,
        this.dOB,
        this.gender,
        this.fatherName,
        this.motherName,
        this.mobileNumber,
        this.categoryId,
        this.cast,
        this.motherAdhar,
        this.fatherOccupation,
        this.motherSelfHelpGroup,
        this.filePath,
        this.mediaId,
        this.isReligiousMinority,
        this.weightOnBirth,
        this.heightOnBbirth,
        this.isVerified,
        this.deleted,
        this.stateId,
        this.districtId,
        this.areaId,
        this.blockId,
        this.panchayatId,
        this.gramPanchayatId,
        this.centerId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    aadhar = json['aadhar'];
    hasAadhar = json['has_aadhar'];
    dOB = json['DOB'];
    gender = json['gender'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    mobileNumber = json['mobileNumber'];
    categoryId = json['categoryId'];
    cast = json['cast'];
    motherAdhar = json['motherAdhar'];
    fatherOccupation = json['fatherOccupation'];
    motherSelfHelpGroup = json['motherSelfHelpGroup'];
    filePath = json['filePath'];
    mediaId = json['mediaId'];
    isReligiousMinority = json['isReligiousMinority'];
    weightOnBirth = json['weightOnBirth'];
    heightOnBbirth = json['heightOnBbirth'];
    isVerified = json['isVerified'];
    deleted = json['deleted'];
    stateId = json['stateId'];
    districtId = json['districtId'];
    areaId = json['areaId'];
    blockId = json['blockId'];
    panchayatId = json['panchayatId'];
    gramPanchayatId = json['gramPanchayatId'];
    centerId = json['centerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['aadhar'] = this.aadhar;
    data['has_aadhar'] = this.hasAadhar;
    data['DOB'] = this.dOB;
    data['gender'] = this.gender;
    data['fatherName'] = this.fatherName;
    data['motherName'] = this.motherName;
    data['mobileNumber'] = this.mobileNumber;
    data['categoryId'] = this.categoryId;
    data['cast'] = this.cast;
    data['motherAdhar'] = this.motherAdhar;
    data['fatherOccupation'] = this.fatherOccupation;
    data['motherSelfHelpGroup'] = this.motherSelfHelpGroup;
    data['filePath'] = this.filePath;
    data['mediaId'] = this.mediaId;
    data['isReligiousMinority'] = this.isReligiousMinority;
    data['weightOnBirth'] = this.weightOnBirth;
    data['heightOnBbirth'] = this.heightOnBbirth;
    data['isVerified'] = this.isVerified;
    data['deleted'] = this.deleted;
    data['stateId'] = this.stateId;
    data['districtId'] = this.districtId;
    data['areaId'] = this.areaId;
    data['blockId'] = this.blockId;
    data['panchayatId'] = this.panchayatId;
    data['gramPanchayatId'] = this.gramPanchayatId;
    data['centerId'] = this.centerId;
    return data;
  }
}
