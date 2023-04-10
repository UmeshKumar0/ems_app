class Leaves {
  double? used;
  String? user;
  String? leaveId;
  double? defaultCreditValue;
  double? remainingLeave;
  String? leaveType;
  String? createdAt;
  int? year;
  int? months;

  Leaves(
      {this.used,
      this.user,
      this.leaveId,
      this.defaultCreditValue,
      this.remainingLeave,
      this.leaveType,
      this.createdAt,
      this.year,
      this.months});

  Leaves.fromJson(Map<String, dynamic> json) {
    used = 
    json['used'] != null &&
    json['used'].runtimeType == int ? json['used'].toDouble() : json['used'];
    user = json['user'];
    leaveId = json['leaveId'];
    defaultCreditValue =
    json['defaultCreditValue'] != null &&
     json['defaultCreditValue'].runtimeType == int
        ? json['defaultCreditValue'].toDouble()
        : json['defaultCreditValue'];
    remainingLeave =
    json['remainingLeave'] != null &&
     json['remainingLeave'].runtimeType == int
        ? json['remainingLeave'].toDouble()
        : json['remainingLeave'];
    leaveType = json['leaveType'];
    createdAt = json['createdAt'];
    year = json['year'];
    months = json['months'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['used'] = used;
    data['user'] = user;
    data['leaveId'] = leaveId;
    data['defaultCreditValue'] = defaultCreditValue;
    data['remainingLeave'] = remainingLeave;
    data['leaveType'] = leaveType;
    data['createdAt'] = createdAt;
    data['year'] = year;
    data['months'] = months;
    return data;
  }
}
