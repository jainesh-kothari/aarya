class VaccinationModel {
  Data? data;
  String? message;

  VaccinationModel({this.data, this.message});

  VaccinationModel.fromJson(Map<String, dynamic> json) {
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
  List<WomenVaccinationReference>? womenVaccinationReference;

  Data({this.womenVaccinationReference});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['WomenVaccinationReference'] != null) {
      womenVaccinationReference = <WomenVaccinationReference>[];
      json['WomenVaccinationReference'].forEach((v) {
        womenVaccinationReference!
            .add(new WomenVaccinationReference.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.womenVaccinationReference != null) {
      data['WomenVaccinationReference'] =
          this.womenVaccinationReference!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WomenVaccinationReference {
  String? id;
  String? name;
  String? hiName;
  bool? isActive;

  WomenVaccinationReference({this.id, this.name, this.hiName, this.isActive});

  WomenVaccinationReference.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hiName = json['hiName'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hiName'] = this.hiName;
    data['isActive'] = this.isActive;
    return data;
  }
}
