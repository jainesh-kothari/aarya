class AppVersionGS {
  String? id;
  String? name;
  String? value;
  String? description;
  bool? isActive;

  AppVersionGS({this.id, this.name, this.value, this.description, this.isActive});

  AppVersionGS.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    description = json['description'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    return data;
  }
}
