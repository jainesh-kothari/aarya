class CastCategory {
  List<CastCategoryData>? data;
  String? message;
  Pagination? pagination;

  CastCategory({this.data, this.message, this.pagination});

  CastCategory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CastCategoryData>[];
      json['data'].forEach((v) {
        data!.add(new CastCategoryData.fromJson(v));
      });
    }
    message = json['message'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class CastCategoryData {
  String? id;
  String? name;
  String? hiName;
  bool? isActive;

  CastCategoryData({this.id, this.name, this.hiName, this.isActive});

  CastCategoryData.fromJson(Map<String, dynamic> json) {
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

class Pagination {
  int? total;
  Null? totalPage;

  Pagination({this.total, this.totalPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_page'] = this.totalPage;
    return data;
  }
}
