class CartModel {
  int? productId;
  String? productTitle;
  int? quantity;
  double? discount;
  double? productSpecialPrice;
  String? image;

  CartModel({
    this.productId,
    this.productTitle,
    this.quantity,
    this.discount,
    this.productSpecialPrice,
    this.image,
  });

  CartModel copyWith({
    int? productId,
    String? productTitle,
    int? quantity,
    double? discount,
    double? productSpecialPrice,
    String? image,
  }) {
    return CartModel(
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      productSpecialPrice: productSpecialPrice ?? this.productSpecialPrice,
      image: image ?? this.image,
    );
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'],
      productTitle: json['productTitle'],
      quantity: json['quantity'],
      discount: json['discount'],
      productSpecialPrice: json['productSpecialPrice'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productTitle'] = productTitle;
    data['quantity'] = quantity;
    data['discount'] = discount;
    data['productSpecialPrice'] = productSpecialPrice;
    data['image'] = image;
    return data;
  }
}
