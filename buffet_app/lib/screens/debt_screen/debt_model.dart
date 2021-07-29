class GetDebtModel {
  String? addDate;
  int? debtSum;

  GetDebtModel({this.addDate, this.debtSum});

  GetDebtModel.fromJson(Map<String, dynamic> json) {
    addDate = json['add_date'];
    debtSum = json['debt_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add_date'] = this.addDate;
    data['debt_sum'] = this.debtSum;
    return data;
  }
}


//second model
class PayDebtModel {
  String? pin;
  int? payment;

  PayDebtModel({this.pin, this.payment});

  PayDebtModel.fromJson(Map<String, dynamic> json) {
    pin = json['pin'];
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pin'] = this.pin;
    data['payment'] = this.payment;
    return data;
  }
}

// class PayDebtModel_get {
//   int? debt;
//   int? payment;
//   int? change;

//   PayDebtModel_get({this.debt, this.payment, this.change});

//   PayDebtModel_get.fromJson(Map<String, dynamic> json) {
//     debt = json['debt'];
//     payment = json['payment'];
//     change = json['change'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['debt'] = this.debt;
//     data['payment'] = this.payment;
//     data['change'] = this.change;
//     return data;
//   }
// }
