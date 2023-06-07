class SelfHelpGroupModel {
  int? sno;
  String? designation;
  String? name;
  String? mobileNumber;

  SelfHelpGroupModel({
    this.sno,
    this.designation,
    this.name,
    this.mobileNumber,
  });

  @override
  String toString() {
    return '{"sno":"$sno","name": "$name", "designation":"$designation","mobileNumber":$mobileNumber}';
  }
}