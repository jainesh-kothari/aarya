class SelfHelpGroupMeetingGS {
  SelfHelpGroupMeetingData? data;
  String? message;

  SelfHelpGroupMeetingGS({this.data, this.message});

  SelfHelpGroupMeetingGS.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SelfHelpGroupMeetingData.fromJson(json['data']) : null;
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

class SelfMemberDetails {
  String? id;
  String? selfHelpGroupId;
  int? memberType;
  String? name;
  String? designation;
  int? mobileNumber;
  Null? createdBy;
  String? updatedBy;

  SelfMemberDetails(
      {this.id,
        this.selfHelpGroupId,
        this.memberType,
        this.name,
        this.designation,
        this.mobileNumber,
        this.createdBy,
        this.updatedBy});

  SelfMemberDetails.fromJson(Map<String, dynamic> json) {
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

class SelfHelpGroupMeetingData {
  String? id;
  String? centerId;
  String? ladyClubName;
  String? joiningClubDate;
  List<SelfHelpGroupMeeting>? selfHelpGroupMeeting;
  List<SelfMemberDetails>? memberDetails;

  SelfHelpGroupMeetingData(
      {this.id,
        this.centerId,
        this.memberDetails,
        this.ladyClubName,
        this.joiningClubDate,
        this.selfHelpGroupMeeting});

  SelfHelpGroupMeetingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    centerId = json['centerId'];
    ladyClubName = json['ladyClubName'];
    joiningClubDate = json['joiningClubDate'];
    if (json['memberDetails'] != null) {
      memberDetails = <SelfMemberDetails>[];
      json['memberDetails'].forEach((v) {
        memberDetails!.add(new SelfMemberDetails.fromJson(v));
      });
    }
    if (json['selfHelpGroupMeeting'] != null) {
      selfHelpGroupMeeting = <SelfHelpGroupMeeting>[];
      json['selfHelpGroupMeeting'].forEach((v) {
        selfHelpGroupMeeting!.add(new SelfHelpGroupMeeting.fromJson(v));
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
    if (this.selfHelpGroupMeeting != null) {
      data['selfHelpGroupMeeting'] =
          this.selfHelpGroupMeeting!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelfHelpGroupMeeting {
  String? id;
  String? dateOfMetting;
  String? topicOfMeeting;
  String? selfHelpGroupId;
  List<MeetingMemberDetails>? memberDetails;

  SelfHelpGroupMeeting(
      {this.id,
      this.dateOfMetting,
        this.topicOfMeeting,
        this.selfHelpGroupId,
        this.memberDetails});

  SelfHelpGroupMeeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateOfMetting = json['dateOfMetting'];
    topicOfMeeting = json['topicOfMeeting'];
    selfHelpGroupId = json['selfHelpGroupId'];
    if (json['memberDetails'] != null) {
      memberDetails = <MeetingMemberDetails>[];
      json['memberDetails'].forEach((v) {
        memberDetails!.add(new MeetingMemberDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateOfMetting'] = this.dateOfMetting;
    data['topicOfMeeting'] = this.topicOfMeeting;
    data['selfHelpGroupId'] = this.selfHelpGroupId;
    if (this.memberDetails != null) {
      data['memberDetails'] =
          this.memberDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MeetingMemberDetails {
  String? id;
  String? name;
  String? designation;
  bool? attendence;

  MeetingMemberDetails({this.id, this.name, this.designation, this.attendence});

  MeetingMemberDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    designation = json['designation'];
    attendence = json['attendence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['attendence'] = this.attendence;
    return data;
  }
}
