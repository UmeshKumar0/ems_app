class LeaveLedger {
  List<Ledger>? ledger;
  double? totalusedLeaves;
  String? leaveTypeId;
  String? leaveTypeName;
  double? limit;
  double? remainingLeaves;

  LeaveLedger({
    this.ledger,
    this.totalusedLeaves,
    this.leaveTypeId,
    this.leaveTypeName,
    this.limit,
    this.remainingLeaves,
  });

  LeaveLedger.fromJson(Map<String, dynamic> json) {
    if (json['ledger'] != null) {
      ledger = <Ledger>[];
      json['ledger'].forEach((v) {
        ledger!.add(Ledger.fromJson(v));
      });
    }
    totalusedLeaves =
    json['totalusedLeaves'] != null &&
     json['totalusedLeaves'].runtimeType == int
        ? json['totalusedLeaves'].toDouble()
        : json['totalusedLeaves'];
    leaveTypeId = json['leaveTypeId'];
    leaveTypeName = json['leaveTypeName'];
    limit =
    json['limit'] != null &&
     json['limit'].runtimeType == int
        ? json['limit'].toDouble()
        : json['limit'];
    remainingLeaves = 
    json['remainingLeaves'] != null &&
    json['remainingLeaves'].runtimeType == int
        ? json['remainingLeaves'].toDouble()
        : json['remainingLeaves'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ledger != null) {
      data['ledger'] = ledger!.map((v) => v.toJson()).toList();
    }
    data['totalusedLeaves'] = totalusedLeaves;
    data['leaveTypeId'] = leaveTypeId;
    data['leaveTypeName'] = leaveTypeName;
    data['limit'] = limit;
    data['remainingLeaves'] = remainingLeaves;
    return data;
  }
}

class Ledger {
  double? value;
  String? sId;
  String? reason;
  String? createdAt;

  Ledger({this.value, this.sId, this.reason, this.createdAt});

  Ledger.fromJson(Map<String, dynamic> json) {
    value = 
    json['value'] != null &&
    json['value'].runtimeType == int
        ? json['value'].toDouble()
        : json['value'];
    sId = json['_id'];
    reason = json['reason'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['_id'] = sId;
    data['reason'] = reason;
    data['createdAt'] = createdAt;
    return data;
  }
}
