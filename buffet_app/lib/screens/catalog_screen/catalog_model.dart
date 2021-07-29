class BuffetModels {
  int? id;
  int? amount;
  String? name;
  String? image;
  double? price;
  bool? active;
  int quantity = 1;

  BuffetModels(
      {this.id, this.amount, this.name, this.image, this.price, this.active});

  BuffetModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['active'] = this.active;
    return data;
  }
}
