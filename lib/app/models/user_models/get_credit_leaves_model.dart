class GetCreditLeavesData {
  List<Leaves>? leaves;
  int? totalCredit;
  int? totalUsed;
  int? totalRemaining;

  GetCreditLeavesData(
      {this.leaves, this.totalCredit, this.totalUsed, this.totalRemaining});

  GetCreditLeavesData.fromJson(Map<String, dynamic> json) {
    if (json['leaves'] != null) {
      leaves = <Leaves>[];
      json['leaves'].forEach((v) {
        leaves!.add(Leaves.fromJson(v));
      });
    }
    totalCredit = json['totalCredit'];
    totalUsed = json['totalUsed'];
    totalRemaining = json['totalRemaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaves != null) {
      data['leaves'] = leaves!.map((v) => v.toJson()).toList();
    }
    data['totalCredit'] = totalCredit;
    data['totalUsed'] = totalUsed;
    data['totalRemaining'] = totalRemaining;
    return data;
  }
}

class Leaves {
  int? used;
  String? user;
  String? leaveId;
  int? defaultCreditValue;
  int? remainingLeave;
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
    used = json['used'];
    user = json['user'];
    leaveId = json['leaveId'];
    defaultCreditValue = json['defaultCreditValue'];
    remainingLeave = json['remainingLeave'];
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
