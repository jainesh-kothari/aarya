class ChildNutritionalIntervention {
  Data? data;

  ChildNutritionalIntervention({this.data});

  ChildNutritionalIntervention.fromJson(Map<String, dynamic> json) {
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
  List<FoodReference>? foodReference;

  Data({this.foodReference});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['foodReference'] != null) {
      foodReference = <FoodReference>[];
      json['foodReference'].forEach((v) {
        foodReference!.add(new FoodReference.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foodReference != null) {
      data['foodReference'] =
          this.foodReference!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodReference {
  String? id;
  String? name;
  String? hiName;
  bool? isActive;

  FoodReference({this.id, this.name, this.hiName, this.isActive});

  FoodReference.fromJson(Map<String, dynamic> json) {
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
