class AdminAttendanceModel {
  String? name;
  String? empId;
  String? createdAt;
  String? sId;
  String? state;
  String? attendanceCreatedAt;
  int? checkInTimeStamps;
  int? checkOutTimeStamps;
  List<double>? checkInLocation;
  List<double>? checkOutLocation;
  List<String>? works;

  AdminAttendanceModel(
      {this.name,
      this.empId,
      this.createdAt,
      this.sId,
      this.state,
      this.attendanceCreatedAt,
      this.checkInTimeStamps,
      this.checkOutTimeStamps,
      this.checkInLocation,
      this.checkOutLocation,
      this.works});

  AdminAttendanceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    empId = json['empId'];
    createdAt = json['createdAt'];
    sId = json['_id'];
    state = json['state'];
    attendanceCreatedAt = json['attendanceCreatedAt'];
    checkInTimeStamps = json['checkInTimeStamps'];
    checkOutTimeStamps = json['checkOutTimeStamps'];
    checkInLocation = json['checkInLocation'].cast<double>();
    checkOutLocation = json['checkOutLocation'].cast<double>();
    works = json['works'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['empId'] = empId;
    data['createdAt'] = createdAt;
    data['_id'] = sId;
    data['state'] = state;
    data['attendanceCreatedAt'] = attendanceCreatedAt;
    data['checkInTimeStamps'] = checkInTimeStamps;
    data['checkOutTimeStamps'] = checkOutTimeStamps;
    data['checkInLocation'] = checkInLocation;
    data['checkOutLocation'] = checkOutLocation;
    data['works'] = works;
    return data;
  }
}
