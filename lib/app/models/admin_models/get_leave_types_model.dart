class LeaveTypeClass {
  String? sId;
  String? name;
  String? description;
  int? value;
  bool? inProbabtion;
  bool? oneTime;
  bool? yearlyCredit;

  LeaveTypeClass(
      {this.sId,
      this.name,
      this.description,
      this.value,
      this.inProbabtion,
      this.oneTime,
      this.yearlyCredit});

  LeaveTypeClass.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    value = json['value'];
    inProbabtion = json['inProbabtion'];
    oneTime = json['oneTime'];
    yearlyCredit = json['yearlyCredit'];
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
    return data;
  }
}
