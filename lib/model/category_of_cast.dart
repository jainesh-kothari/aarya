class CastCategoryDetails {
  List<CastCategoryDetailsData>? data;
  String? message;

  CastCategoryDetails({this.data, this.message});

  CastCategoryDetails.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CastCategoryDetailsData>[];
      json['data'].forEach((v) {
        data!.add(new CastCategoryDetailsData.fromJson(v));
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

class CastCategoryDetailsData {
  String? id;
  String? categoryId;
  String? name;
  bool? isActive;

  CastCategoryDetailsData({this.id, this.categoryId, this.name, this.isActive});

  CastCategoryDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    name = json['name'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    return data;
  }
}