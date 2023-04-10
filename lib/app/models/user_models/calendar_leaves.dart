class CalendarLeave {
  String? sId;
  String? user;
  double? settledAmount;
  String? settlementReason;
  String? date;
  Leave? leave;

  CalendarLeave(
      {this.sId,
      this.user,
      this.settledAmount,
      this.settlementReason,
      this.date,
      this.leave});

  CalendarLeave.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    settledAmount = 
    json['settledAmount'] != null &&
     json['settledAmount'].runtimeType == int
        ? json['settledAmount'].toDouble()
        : json['settledAmount'];
    settlementReason = json['settlementReason'];
    date = json['date'];
    leave = json['leave'] != null ? Leave.fromJson(json['leave']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['settledAmount'] = settledAmount;
    data['settlementReason'] = settlementReason;
    data['date'] = date;
    if (leave != null) {
      data['leave'] = leave!.toJson();
    }
    return data;
  }
}

class Leave {
  String? sId;

  Leave({this.sId});

  Leave.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    return data;
  }
}