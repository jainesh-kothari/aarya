class ChildHealthData {
  List<ChildHealthDataData>? data;
  String? message;

  ChildHealthData({this.data, this.message});

  ChildHealthData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChildHealthDataData>[];
      json['data'].forEach((v) {
        data!.add(new ChildHealthDataData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ChildHealthDataData {
  String? id;
  int? height;
  int? weight;
  String? createdAT;

  ChildHealthDataData({this.id, this.height, this.weight, this.createdAT});

  ChildHealthDataData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    height = json['height'];
    weight = json['weight'];
    createdAT = json['createdAT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['createdAT'] = this.createdAT;
    return data;
  }
}