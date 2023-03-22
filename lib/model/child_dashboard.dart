class ChildDashBoardDetils {
  Data? data;
  String? message;

  ChildDashBoardDetils({this.data, this.message});

  ChildDashBoardDetils.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? middleName;
  String? lastName;
  String? mobile;
  String? email;
  bool? isActive;
  List<String>? roleIDs;
  List<Roles>? roles;
  List<UserAccess>? userAccess;
  bool? isArya;
  bool? isGnm;
  List<UserAgeRef>? userAgeRef;

  Data(
      {this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.mobile,
        this.email,
        this.isActive,
        this.roleIDs,
        this.roles,
        this.userAccess,
        this.isArya,
        this.isGnm,
        this.userAgeRef});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    email = json['email'];
    isActive = json['isActive'];
    roleIDs = json['roleIDs'].cast<String>();
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    if (json['userAccess'] != null) {
      userAccess = <UserAccess>[];
      json['userAccess'].forEach((v) {
        userAccess!.add(new UserAccess.fromJson(v));
      });
    }
    isArya = json['is_arya'];
    isGnm = json['is_gnm'];
    if (json['userAgeRef'] != null) {
      userAgeRef = <UserAgeRef>[];
      json['userAgeRef'].forEach((v) {
        userAgeRef!.add(new UserAgeRef.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['isActive'] = this.isActive;
    data['roleIDs'] = this.roleIDs;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    if (this.userAccess != null) {
      data['userAccess'] = this.userAccess!.map((v) => v.toJson()).toList();
    }
    data['is_arya'] = this.isArya;
    data['is_gnm'] = this.isGnm;
    if (this.userAgeRef != null) {
      data['userAgeRef'] = this.userAgeRef!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  String? id;
  String? name;

  Roles({this.id, this.name});

  Roles.fromJson(Map<String, dynamic> json) {
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

class UserAccess {
  UserCenter? center;

  UserAccess({this.center});

  UserAccess.fromJson(Map<String, dynamic> json) {
    center =
    json['center'] != null ? new UserCenter.fromJson(json['center']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.center != null) {
      data['center'] = this.center!.toJson();
    }
    return data;
  }
}

class UserCenter {
  String? id;
  String? name;
  List<String>? ageReferenceIDs;

  UserCenter({this.id, this.name, this.ageReferenceIDs});

  UserCenter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ageReferenceIDs = json['ageReferenceIDs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['ageReferenceIDs'] = this.ageReferenceIDs;
    return data;
  }
}

class UserAgeRef {
  String? id;
  String? name;
  int? minAge;
  int? maxAge;
  int? totalChildren;

  UserAgeRef(
      {this.id, this.name, this.minAge, this.maxAge, this.totalChildren});

  UserAgeRef.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minAge = json['minAge'];
    maxAge = json['maxAge'];
    totalChildren = json['totalChildren'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['minAge'] = this.minAge;
    data['maxAge'] = this.maxAge;
    data['totalChildren'] = this.totalChildren;
    return data;
  }
}
