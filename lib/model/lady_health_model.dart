class LadyHealthModel {
  LadyHealthModelData? data;
  String? message;

  LadyHealthModel({this.data, this.message});

  LadyHealthModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LadyHealthModelData.fromJson(json['data']) : null;
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

class LadyHealthModelData {
  String? id;
  int? height;
  int? weight;
  int? hemoglobin;

  LadyHealthModelData({this.id, this.height, this.weight, this.hemoglobin});

  LadyHealthModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    height = json['height'];
    weight = json['weight'];
    hemoglobin = json['hemoglobin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['hemoglobin'] = this.hemoglobin;
    return data;
  }
}
