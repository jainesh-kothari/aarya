class ChildResponse {
  List<ChildData>? data;
  String? message;

  ChildResponse({this.data, this.message});

  ChildResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChildData>[];
      json['data'].forEach((v) {
        data!.add(new ChildData.fromJson(v));
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

class ChildData {
  String? id;
  String? name;
  String? fatherName;
  String? motherName;
  int? mobileNumber;
  String? aadhar;
  bool? isVerified;
  String? motherAdhar;
  String? fatherOccupation;
  String? motherSelfHelpGroup;
  String? gender;
  String? dOB;
  String? categoryId;
  String? cast;
  Null? otherCast;
  bool? isReligiousMinority;
  Age? age;

  ChildData(
      {this.id,
        this.name,
        this.fatherName,
        this.motherName,
        this.mobileNumber,
        this.aadhar,
        this.isVerified,
        this.motherAdhar,
        this.fatherOccupation,
        this.motherSelfHelpGroup,
        this.gender,
        this.dOB,
        this.categoryId,
        this.cast,
        this.otherCast,
        this.isReligiousMinority,
        this.age});

  ChildData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    mobileNumber = json['mobileNumber'];
    aadhar = json['aadhar'];
    isVerified = json['isVerified'];
    motherAdhar = json['motherAdhar'];
    fatherOccupation = json['fatherOccupation'];
    motherSelfHelpGroup = json['motherSelfHelpGroup'];
    gender = json['gender'];
    dOB = json['DOB'];
    categoryId = json['categoryId'];
    cast = json['cast'];
    otherCast = json['otherCast'];
    isReligiousMinority = json['isReligiousMinority'];
    age = json['age'] != null ? new Age.fromJson(json['age']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fatherName'] = this.fatherName;
    data['motherName'] = this.motherName;
    data['mobileNumber'] = this.mobileNumber;
    data['aadhar'] = this.aadhar;
    data['isVerified'] = this.isVerified;
    data['motherAdhar'] = this.motherAdhar;
    data['fatherOccupation'] = this.fatherOccupation;
    data['motherSelfHelpGroup'] = this.motherSelfHelpGroup;
    data['gender'] = this.gender;
    data['DOB'] = this.dOB;
    data['categoryId'] = this.categoryId;
    data['cast'] = this.cast;
    data['otherCast'] = this.otherCast;
    data['isReligiousMinority'] = this.isReligiousMinority;

    if (this.age != null) {
      data['age'] = this.age!.toJson();
    }
    return data;
  }
}

class Age {
  double? totalDays;
  int? totalMonths;
  int? totalYears;

  Age({this.totalDays, this.totalMonths, this.totalYears});

  Age.fromJson(Map<String, dynamic> json) {
    totalDays = json['totalDays'];
    totalMonths = json['totalMonths'];
    totalYears = json['totalYears'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalDays'] = this.totalDays;
    data['totalMonths'] = this.totalMonths;
    data['totalYears'] = this.totalYears;
    return data;
  }
}