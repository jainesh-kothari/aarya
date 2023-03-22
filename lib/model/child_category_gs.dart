class ChildCategory {
  List<ChildCategoryData>? data;
  String? message;

  ChildCategory({this.data, this.message});

  ChildCategory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChildCategoryData>[];
      json['data'].forEach((v) {
        data!.add(new ChildCategoryData.fromJson(v));
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

class ChildCategoryData {
  String? id;
  String? userId;
  String? name;
  String? aadhar;
  bool? hasAadhar;
  String? dOB;
  String? gender;
  String? fatherName;
  String? motherName;
  String? cast;
  int? mobileNumber;
  bool? isReligiousMinority;
  Null? weightOnBirth;
  Null? heightOnBbirth;
  bool? isVerified;
  String? createdAT;
  String? updatedAt;

  ChildCategoryData(
      {this.id,
        this.userId,
        this.name,
        this.aadhar,
        this.hasAadhar,
        this.dOB,
        this.gender,
        this.fatherName,
        this.motherName,
        this.cast,
        this.mobileNumber,
        this.isReligiousMinority,
        this.weightOnBirth,
        this.heightOnBbirth,
        this.isVerified,
        this.createdAT,
        this.updatedAt});

  ChildCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    aadhar = json['aadhar'];
    hasAadhar = json['has_aadhar'];
    dOB = json['DOB'];
    gender = json['gender'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    cast = json['cast'];
    mobileNumber = json['mobileNumber'];
    isReligiousMinority = json['isReligiousMinority'];
    weightOnBirth = json['weightOnBirth'];
    heightOnBbirth = json['heightOnBbirth'];
    isVerified = json['isVerified'];
    createdAT = json['createdAT'];
    updatedAt = json['updatedAt'];
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
    data['cast'] = this.cast;
    data['mobileNumber'] = this.mobileNumber;
    data['isReligiousMinority'] = this.isReligiousMinority;
    data['weightOnBirth'] = this.weightOnBirth;
    data['heightOnBbirth'] = this.heightOnBbirth;
    data['isVerified'] = this.isVerified;
    data['createdAT'] = this.createdAT;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
