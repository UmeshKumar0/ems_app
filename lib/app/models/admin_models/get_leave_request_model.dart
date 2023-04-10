class LeaveRequestModel {
  String? sId;
  String? userId;
  String? leaveId;
  String? status;
  String? reason;
  double? value;
  String? createdAt;
  String? updatedAt;
  int? iV;
  User? user;
  List<Leave>? leave;

  LeaveRequestModel(
      {this.sId,
      this.userId,
      this.leaveId,
      this.status,
      this.reason,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.user,
      this.leave});

  LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    leaveId = json['leaveId'];
    status = json['status'];
    reason = json['reason'];
    value = json['value'].runtimeType == int
        ? json['value'].toDouble()
        : json['value'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['leave'] != null) {
      leave = <Leave>[];
      json['leave'].forEach((v) {
        leave!.add(Leave.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['leaveId'] = leaveId;
    data['status'] = status;
    data['reason'] = reason;
    data['value'] = value;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (leave != null) {
      data['leave'] = leave!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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

class Leave {
  String? sId;
  String? user;
  List<LeaveType>? leaveType;
  int? value;
  int? year;
  int? months;
  String? createdAt;
  int? iV;
  String? updatedAt;

  Leave(
      {this.sId,
      this.user,
      this.leaveType,
      this.value,
      this.year,
      this.months,
      this.createdAt,
      this.iV,
      this.updatedAt});

  Leave.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    if (json['leaveType'] != null) {
      leaveType = <LeaveType>[];
      json['leaveType'].forEach((v) {
        leaveType!.add(LeaveType.fromJson(v));
      });
    }
    value = json['value'];
    year = json['year'];
    months = json['months'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    if (leaveType != null) {
      data['leaveType'] = leaveType!.map((v) => v.toJson()).toList();
    }
    data['value'] = value;
    data['year'] = year;
    data['months'] = months;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class LeaveType {
  String? sId;
  String? name;
  String? description;
  int? value;
  bool? inProbabtion;
  bool? oneTime;
  bool? yearlyCredit;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LeaveType(
      {this.sId,
      this.name,
      this.description,
      this.value,
      this.inProbabtion,
      this.oneTime,
      this.yearlyCredit,
      this.createdAt,
      this.updatedAt,
      this.iV});

  LeaveType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    value = json['value'];
    inProbabtion = json['inProbabtion'];
    oneTime = json['oneTime'];
    yearlyCredit = json['yearlyCredit'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['value'] = value;
    data['inProbabtion'] = inProbabtion;
    data['oneTime'] = oneTime;
    data['yearlyCredit'] = yearlyCredit;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
