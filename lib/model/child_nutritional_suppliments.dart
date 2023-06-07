class ChildNutritionalSupplements {
  Data? data;
  String? message;

  ChildNutritionalSupplements({this.data, this.message});

  ChildNutritionalSupplements.fromJson(Map<String, dynamic> json) {
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
  List<MedicineReference>? medicineReference;

  Data({this.medicineReference});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['medicineReference'] != null) {
      medicineReference = <MedicineReference>[];
      json['medicineReference'].forEach((v) {
        medicineReference!.add(new MedicineReference.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicineReference != null) {
      data['medicineReference'] =
          this.medicineReference!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicineReference {
  String? id;
  String? name;
  String? hiName;
  bool? isActive;

  MedicineReference({this.id, this.name, this.hiName, this.isActive});

  MedicineReference.fromJson(Map<String, dynamic> json) {
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
