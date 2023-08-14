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


class SelfHelpGroupModelWithId {
  int? sno;
  String? id;
  String? designation;
  String? name;
  String? mobileNumber;

  SelfHelpGroupModelWithId({
    this.sno,
    this.id,
    this.designation,
    this.name,
    this.mobileNumber,
  });

  @override
  String toString() {
    if(id == null) {
      return '{"sno":"$sno","name": "$name", "designation":"$designation","mobileNumber":$mobileNumber}';
    } else {
      return '{"id":"$id","sno":"$sno","name": "$name", "designation":"$designation","mobileNumber":$mobileNumber}';
    }


  }
}