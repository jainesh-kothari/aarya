class LadyNutritionalSupplement {
  LadyNutritionalSupplementData? data;
  String? message;

  LadyNutritionalSupplement({this.data, this.message});

  LadyNutritionalSupplement.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LadyNutritionalSupplementData.fromJson(json['data']) : null;
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

class LadyNutritionalSupplementData {
  List<WomenMedicineReference>? womenMedicineReference;

  LadyNutritionalSupplementData({this.womenMedicineReference});

  LadyNutritionalSupplementData.fromJson(Map<String, dynamic> json) {
    if (json['WomenMedicineReference'] != null) {
      womenMedicineReference = <WomenMedicineReference>[];
      json['WomenMedicineReference'].forEach((v) {
        womenMedicineReference!.add(new WomenMedicineReference.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.womenMedicineReference != null) {
      data['WomenMedicineReference'] =
          this.womenMedicineReference!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WomenMedicineReference {
  String? id;
  String? name;
  bool? isActive;

  WomenMedicineReference({this.id, this.name, this.isActive});

  WomenMedicineReference.fromJson(Map<String, dynamic> json) {
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
