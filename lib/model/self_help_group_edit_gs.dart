class SelfHelpGroupGS {
  SelfHelpGroupGSData? data;
  String? message;

  SelfHelpGroupGS({this.data, this.message});

  SelfHelpGroupGS.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SelfHelpGroupGSData.fromJson(json['data']) : null;
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

class SelfHelpGroupGSData {
  String? id;
  String? centerId;
  String? ladyClubName;
  String? joiningClubDate;
  List<SelfHelpGroupGSMemberDetails>? memberDetails;


  SelfHelpGroupGSData(
      {this.id,
        this.centerId,
        this.ladyClubName,
        this.joiningClubDate,
        this.memberDetails});

  SelfHelpGroupGSData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    centerId = json['centerId'];
    ladyClubName = json['ladyClubName'];
    joiningClubDate = json['joiningClubDate'];
    if (json['memberDetails'] != null) {
      memberDetails = <SelfHelpGroupGSMemberDetails>[];
      json['memberDetails'].forEach((v) {
        memberDetails!.add(new SelfHelpGroupGSMemberDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['centerId'] = this.centerId;
    data['ladyClubName'] = this.ladyClubName;
    data['joiningClubDate'] = this.joiningClubDate;
    if (this.memberDetails != null) {
      data['memberDetails'] =
          this.memberDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelfHelpGroupGSMemberDetails {
  String? id;
  String? selfHelpGroupId;
  int? memberType;
  String? name;
  String? designation;
  int? mobileNumber;
  Null? createdBy;
  String? updatedBy;

  SelfHelpGroupGSMemberDetails(
      {this.id,
        this.selfHelpGroupId,
        this.memberType,
        this.name,
        this.designation,
        this.mobileNumber,
        this.createdBy,
        this.updatedBy});

  SelfHelpGroupGSMemberDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selfHelpGroupId = json['selfHelpGroupId'];
    memberType = json['memberType'];
    name = json['name'];
    designation = json['designation'];
    mobileNumber = json['mobileNumber'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['selfHelpGroupId'] = this.selfHelpGroupId;
    data['memberType'] = this.memberType;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['mobileNumber'] = this.mobileNumber;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}
