class Vaccination {
  Data? data;

  Vaccination({this.data});

  Vaccination.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<VaccinationReference>? vaccinationReference;

  Data({this.vaccinationReference});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['vaccinationReference'] != null) {
      vaccinationReference = <VaccinationReference>[];
      json['vaccinationReference'].forEach((v) {
        vaccinationReference!.add(new VaccinationReference.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vaccinationReference != null) {
      data['vaccinationReference'] =
          this.vaccinationReference!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VaccinationReference {
  String? id;
  String? name;
  bool? isActive;

  VaccinationReference({this.id, this.name, this.isActive});

  VaccinationReference.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    return data;
  }
}