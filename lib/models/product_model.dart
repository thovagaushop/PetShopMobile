class ProductModel {
  int? id;
  int? categoryId;
  int? specialCategoryId;
  String? petType;
  String? brand;
  String? title;
  String? sku;
  int? rating;
  String? description;
  double? price;
  int? quantity;
  double? discount;
  double? specialPrice;
  int? viewNumber;
  int? buyNumber;
  List<String>? images;

  ProductModel({
    this.id,
    this.categoryId,
    this.specialCategoryId,
    this.petType,
    this.brand,
    this.title,
    this.sku,
    this.rating,
    this.description,
    this.price,
    this.quantity,
    this.discount,
    this.specialPrice,
    this.viewNumber,
    this.buyNumber,
    this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      categoryId: json['category_id'],
      specialCategoryId: json['special_category_id'],
      petType: json['pet_type'],
      brand: json['brand'],
      title: json['title'],
      sku: json['sku'],
      rating: json['rating'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      discount: json['discount'],
      specialPrice: json['special_price'],
      viewNumber: json['view_number'],
      buyNumber: json['buy_number'],
      images: json['images'],
    );
  }
}
