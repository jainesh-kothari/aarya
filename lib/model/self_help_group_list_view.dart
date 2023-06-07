class SelfHelpGroupListViewModel {
  List<SelfHelpGroupListViewModelData>? data;
  String? message;

  SelfHelpGroupListViewModel({this.data, this.message});

  SelfHelpGroupListViewModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SelfHelpGroupListViewModelData>[];
      json['data'].forEach((v) {
        data!.add(new SelfHelpGroupListViewModelData.fromJson(v));
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

class SelfHelpGroupListViewModelData {
  String? id;
  String? centerId;
  CenterDetails? center;
  String? ladyClubName;
  String? joiningClubDate;

  SelfHelpGroupListViewModelData(
      {this.id,
        this.centerId,
        this.center,
        this.ladyClubName,
        this.joiningClubDate});

  SelfHelpGroupListViewModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    centerId = json['centerId'];
    center =
    json['center'] != null ? new CenterDetails.fromJson(json['center']) : null;
    ladyClubName = json['ladyClubName'];
    joiningClubDate = json['joiningClubDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['centerId'] = this.centerId;
    if (this.center != null) {
      data['center'] = this.center!.toJson();
    }
    data['ladyClubName'] = this.ladyClubName;
    data['joiningClubDate'] = this.joiningClubDate;

    return data;
  }
}

class CenterDetails {
  String? id;
  String? name;

  CenterDetails({this.id, this.name});

  CenterDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class MemberDetails {
  String? id;
  String? selfHelpGroupId;
  int? memberType;
  String? name;
  int? designation;
  int? mobileNumber;
  String? createdBy;
  Null? updatedBy;

  MemberDetails(
      {this.id,
        this.selfHelpGroupId,
        this.memberType,
        this.name,
        this.designation,
        this.mobileNumber,
        this.createdBy,
        this.updatedBy});

  MemberDetails.fromJson(Map<String, dynamic> json) {
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
