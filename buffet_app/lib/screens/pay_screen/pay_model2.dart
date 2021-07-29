class PayModel2 {
  int? change;
  Pin? pin;
  int? id;
  String? addDate;
  String? editDate;
  int? totalSum;
  int? debtSum;
  String? status;

  PayModel2(
      {this.change,
      this.pin,
      this.id,
      this.addDate,
      this.editDate,
      this.totalSum,
      this.debtSum,
      this.status});

PayModel2.fromJson(Map<String, dynamic> json) {
    change = json['change'];
    pin = json['pin'] != null ? new Pin.fromJson(json['pin']) : null;
    id = json['id'];
    addDate = json['add_date'];
    editDate = json['edit_date'];
    totalSum = json['total_sum'];
    debtSum = json['debt_sum'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['change'] = this.change;
    if (this.pin != null) {
      data['pin'] = this.pin?.toJson();
    }
    data['id'] = this.id;
    data['add_date'] = this.addDate;
    data['edit_date'] = this.editDate;
    data['total_sum'] = this.totalSum;
    data['debt_sum'] = this.debtSum;
    data['status'] = this.status;
    return data;
  }
}

class Pin {
  String? pin;
  int? debt;

  Pin({this.pin, this.debt});

  Pin.fromJson(Map<String, dynamic> json) {
    pin = json['pin'];
    debt = json['debt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pin'] = this.pin;
    data['debt'] = this.debt;
    return data;
  }
}