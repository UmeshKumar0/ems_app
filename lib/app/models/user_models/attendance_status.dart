class AttendanceStatus {
  String? sId;
  String? checkIn;
  String? checkOut;
  int? checkInTimeStamps;
  String? state;
  List<String>? works;
  String? createdAt;
  int? checkOutTimeStamps;

  AttendanceStatus(
      {this.sId,
      this.checkIn,
      this.checkOut,
      this.checkInTimeStamps,
      this.state,
      this.works,
      this.createdAt,
      this.checkOutTimeStamps});

  AttendanceStatus.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    checkInTimeStamps = json['checkInTimeStamps'];
    state = json['state'];
    works = json['works'].cast<String>();
    createdAt = json['createdAt'];
    checkOutTimeStamps = json['checkOutTimeStamps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['checkIn'] = checkIn;
    data['checkOut'] = checkOut;
    data['checkInTimeStamps'] = checkInTimeStamps;
    data['state'] = state;
    data['works'] = works;
    data['createdAt'] = createdAt;
    data['checkOutTimeStamps'] = checkOutTimeStamps;
    return data;
  }
}
