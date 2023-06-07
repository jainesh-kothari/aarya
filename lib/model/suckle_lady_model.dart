class SuckleLadyModel {
  Data? data;
  String? message;

  SuckleLadyModel({this.data, this.message});

  SuckleLadyModel.fromJson(Map<String, dynamic> json) {
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
  bool? abortionAfter20Week;
  bool? abortionBefore20Week;
  bool? isAbortion;
  bool? isStillborn;
  String? deliverDate;

  Data(
      {this.id,
        this.abortionAfter20Week,
        this.abortionBefore20Week,
        this.isAbortion,
        this.isStillborn,
        this.deliverDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abortionAfter20Week = json['abortion_after_20_week'];
    abortionBefore20Week = json['abortion_before_20_week'];
    isAbortion = json['is_abortion'];
    isStillborn = json['is_stillborn'];
    deliverDate = json['deliver_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['abortion_after_20_week'] = this.abortionAfter20Week;
    data['abortion_before_20_week'] = this.abortionBefore20Week;
    data['is_abortion'] = this.isAbortion;
    data['is_stillborn'] = this.isStillborn;
    data['deliver_date'] = this.deliverDate;
    return data;
  }
}
class Autogenerated {
  Data? data;
  String? message;

  Autogenerated({this.data, this.message});

  Autogenerated.fromJson(Map<String, dynamic> json) {
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

class SuckleLadyModelData {
  String? id;
  bool? abortionAfter20Week;
  bool? abortionBefore20Week;
  bool? isAbortion;
  bool? isStillborn;
  String? deliverDate;

  SuckleLadyModelData(
      {this.id,
        this.abortionAfter20Week,
        this.abortionBefore20Week,
        this.isAbortion,
        this.isStillborn,
        this.deliverDate});

  SuckleLadyModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abortionAfter20Week = json['abortion_after_20_week'];
    abortionBefore20Week = json['abortion_before_20_week'];
    isAbortion = json['is_abortion'];
    isStillborn = json['is_stillborn'];
    deliverDate = json['deliver_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['abortion_after_20_week'] = this.abortionAfter20Week;
    data['abortion_before_20_week'] = this.abortionBefore20Week;
    data['is_abortion'] = this.isAbortion;
    data['is_stillborn'] = this.isStillborn;
    data['deliver_date'] = this.deliverDate;
    return data;
  }
}
