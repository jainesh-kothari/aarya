class WomenHomePageModel {
  List<WomenHomePageModelData>? data;

  WomenHomePageModel({this.data});

  WomenHomePageModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <WomenHomePageModelData>[];
      json['data'].forEach((v) {
        data!.add(new WomenHomePageModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WomenHomePageModelData {
  String? id;
  String? name;
  String? hiName;
  bool? isActive;
  int? womenCount;
  int? veryHighCount;
  int? highCount;
  int? lowCount;
  int? veryLow;

  WomenHomePageModelData( {this.id,
    this.name,
    this.hiName,
    this.isActive,
    this.womenCount,
    this.veryHighCount,
    this.highCount,
    this.lowCount,
    this.veryLow});

  WomenHomePageModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hiName = json['hiName'];
    isActive = json['isActive'];
    womenCount = json['womenCount'];
    veryHighCount = json['VeryHighCount'];
    highCount = json['HighCount'];
    lowCount = json['lowCount'];
    veryLow = json['VeryLow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hiName'] = this.hiName;
    data['isActive'] = this.isActive;
    data['womenCount'] = this.womenCount;
    data['VeryHighCount'] = this.veryHighCount;
    data['HighCount'] = this.highCount;
    data['lowCount'] = this.lowCount;
    data['VeryLow'] = this.veryLow;
    return data;
  }
}