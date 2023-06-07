class LadyNutritionalIntervention{
  LadyNutritionalSupplementData? data;
  String? message;

  LadyNutritionalIntervention({this.data, this.message});

  LadyNutritionalIntervention.fromJson(Map<String, dynamic> json) {
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
  List<WomenFoodReference>? womenfoodReference;

  LadyNutritionalSupplementData({this.womenfoodReference});

  LadyNutritionalSupplementData.fromJson(Map<String, dynamic> json) {
    if (json['WomenFoodReference'] != null) {
      womenfoodReference = <WomenFoodReference>[];
      json['WomenFoodReference'].forEach((v) {
        womenfoodReference!.add(new WomenFoodReference.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.womenfoodReference != null) {
      data['WomenFoodReference'] =
          this.womenfoodReference!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WomenFoodReference {
  String? id;
  String? name;
  String? hiName;
  bool? isActive;

  WomenFoodReference({this.id, this.name, this.isActive, this.hiName});

  WomenFoodReference.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
    hiName = json['hiName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    data['hiName'] = this.hiName;
    return data;
  }
}
