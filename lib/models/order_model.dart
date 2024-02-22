class OrderModel {
  List<Map<String, dynamic>>? orderItems;
  String? orderDate;
  String? paymentMethod;
  double? totalAmount;
  String? address;
  String? orderStatus;

  OrderModel({
    this.orderItems,
    this.orderDate,
    this.paymentMethod,
    this.totalAmount,
    this.address,
    this.orderStatus,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> items = [];
    for (Map<String, dynamic> item in json['orderItems']) {
      items.add(item);
    }
    return OrderModel(
        orderItems: items,
        orderDate: json['orderDate'],
        paymentMethod: json['payment']['paymentMethod'],
        totalAmount: json['totalAmount'],
        address: json['address'],
        orderStatus: json['orderStatus']);
  }
}
