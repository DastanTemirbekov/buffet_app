class PayModel {
  int? money;
  String? pin;
  List<Products>? products;

  PayModel({this.money, this.pin, this.products});

  PayModel.fromJson(Map<String, dynamic> json) {
    money = json['money'];
    pin = json['pin'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['money'] = this.money;
    data['pin'] = this.pin;
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? amount;
  int? id;

  Products({this.amount, this.id});

  Products.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['id'] = this.id;
    return data;
  }
}
