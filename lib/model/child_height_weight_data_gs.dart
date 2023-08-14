class ChildHeightWeightData {
  dynamic? height;
  dynamic? weight;
  String? date;
  String? result;

  ChildHeightWeightData({this.height,this.weight, this.date, this.result});

  ChildHeightWeightData.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    date = json['date'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['date'] = this.date;
    data['result'] = this.result;
    return data;
  }
}