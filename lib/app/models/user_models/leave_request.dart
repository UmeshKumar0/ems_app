class LeaveRequest {
  String? sId;
  String? userId;
  LeaveId? leaveId;
  String? status;
  String? reason;
  double? value;
  String? createdAt;

  LeaveRequest(
      {this.sId,
      this.userId,
      this.leaveId,
      this.status,
      this.reason,
      this.value,
      this.createdAt});

  LeaveRequest.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    leaveId =
        json['leaveId'] != null ? LeaveId.fromJson(json['leaveId']) : null;
    status = json['status'];
    reason = json['reason'];
    value = 
    json['value'] != null &&
     json['value'].runtimeType == int
        ? json['value'].toDouble()
        : json['value'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    if (leaveId != null) {
      data['leaveId'] = leaveId!.toJson();
    }
    data['status'] = status;
    data['reason'] = reason;
    data['value'] = value;
    data['createdAt'] = createdAt;
    return data;
  }
}

class LeaveId {
  String? sId;
  String? user;
  String? leaveType;
  double? value;
  int? year;
  int? months;
  String? createdAt;

  LeaveId(
      {this.sId,
      this.user,
      this.leaveType,
      this.value,
      this.year,
      this.months,
      this.createdAt});

  LeaveId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    leaveType = json['leaveType'];
    value = 
    json['value'] != null &&
    json['value'].runtimeType == int
        ? json['value'].toDouble()
        : json['value'];
    year = json['year'];
    months = json['months'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['leaveType'] = leaveType;
    data['value'] = value;
    data['year'] = year;
    data['months'] = months;
    data['createdAt'] = createdAt;
    return data;
  }
}
