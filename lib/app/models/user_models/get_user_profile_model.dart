class GetUserProfile {
  String? sId;
  String? name;
  String? email;
  String? empId;
  int? dateOfJoining;
  bool? inProbabtion;
  int? probabtionEnd;
  int? probabtionPeriod;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? number;
  String? token;

  GetUserProfile(
      {this.sId,
      this.name,
      this.email,
      this.empId,
      this.dateOfJoining,
      this.inProbabtion,
      this.probabtionEnd,
      this.probabtionPeriod,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.number,
      this.token});

  GetUserProfile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    empId = json['empId'];
    dateOfJoining = json['dateOfJoining'];
    inProbabtion = json['inProbabtion'];
    probabtionEnd = json['probabtionEnd'];
    probabtionPeriod = json['probabtionPeriod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    number = json['number'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['empId'] = empId;
    data['dateOfJoining'] = dateOfJoining;
    data['inProbabtion'] = inProbabtion;
    data['probabtionEnd'] = probabtionEnd;
    data['probabtionPeriod'] = probabtionPeriod;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['number'] = number;
    data['token'] = token;
    return data;
  }
}
