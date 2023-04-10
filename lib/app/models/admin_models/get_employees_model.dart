class GetEmployeeClass {
  String? sId;
  String? name;
  String? email;
  String? empId;
  int? dateOfJoining;
  bool? inProbabtion;
  int? probabtionEnd;
  int? probabtionPeriod;
  int? number;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? token;

  GetEmployeeClass(
      {this.sId,
      this.name,
      this.email,
      this.empId,
      this.dateOfJoining,
      this.inProbabtion,
      this.probabtionEnd,
      this.probabtionPeriod,
      this.number,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.token});

  GetEmployeeClass.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    empId = json['empId'];
    dateOfJoining = json['dateOfJoining'];
    inProbabtion = json['inProbabtion'];
    probabtionEnd = json['probabtionEnd'];
    probabtionPeriod = json['probabtionPeriod'];
    number = json['number'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
    data['number'] = number;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['token'] = token;
    return data;
  }
}
