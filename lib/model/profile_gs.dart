class UserProfileGS {
  String? id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? email;
  String? mobile;
  UserAccess? userAccess;

  UserProfileGS(
      {this.id,
      this.firstName,
      this.lastName,
      this.middleName,
      this.email,
      this.mobile,
      this.userAccess});

  UserProfileGS.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    email = json['email'];
    mobile = json['mobile'];
    userAccess = json['userAccess'] != null
        ? new UserAccess.fromJson(json['userAccess'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    if (this.userAccess != null) {
      data['userAccess'] = this.userAccess!.toJson();
    }
    return data;
  }
}

class UserAccess {
  UserState? state;
  UserState? district;
  UserState? area;
  UserState? block;
  UserState? panchayat;
  UserState? gramPanchayat;
  UserState? center;

  UserAccess(
      {this.state,
      this.district,
      this.area,
      this.block,
      this.panchayat,
      this.gramPanchayat,
      this.center});

  UserAccess.fromJson(Map<String, dynamic> json) {
    state = json['state'] != null ? new UserState.fromJson(json['state']) : null;
    district =
        json['district'] != null ? new UserState.fromJson(json['district']) : null;
    area = json['area'] != null ? new UserState.fromJson(json['area']) : null;
    block = json['block'] != null ? new UserState.fromJson(json['block']) : null;
    panchayat = json['panchayat'] != null
        ? new UserState.fromJson(json['panchayat'])
        : null;
    gramPanchayat = json['gramPanchayat'] != null
        ? new UserState.fromJson(json['gramPanchayat'])
        : null;
    center = json['center'] != null ? new UserState.fromJson(json['center']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
    if (this.block != null) {
      data['block'] = this.block!.toJson();
    }
    if (this.panchayat != null) {
      data['panchayat'] = this.panchayat!.toJson();
    }
    if (this.gramPanchayat != null) {
      data['gramPanchayat'] = this.gramPanchayat!.toJson();
    }
    if (this.center != null) {
      data['center'] = this.center!.toJson();
    }
    return data;
  }
}

class UserState {
  String? name;

  UserState({this.name});

  UserState.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
