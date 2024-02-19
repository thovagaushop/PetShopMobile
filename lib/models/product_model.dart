import 'package:test_flutter_2/common/constant/common.dart';
import 'package:test_flutter_2/utils/utils.dart';

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
      specialPrice: json['specialPrice'],
      viewNumber: json['viewNumber'],
      buyNumber: json['buyNumber'],
      images: (json['images'] as List)
          .map((el) => Utils().getImageUrl(el))
          .toList(),
    );
  }

  static List<ProductModel> seederListProducts() {
    const baseApiUrl = CommonConst.baseApiUrl;
    final productData = {
      "id": 1,
      "category_id": 1,
      "special_category_id": null,
      "pet_type": "CAT",
      "brand": null,
      "title": "Test Product",
      "sku": "test_product_sku",
      "rating": 5,
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "price": 10.10,
      "quantity": 100,
      "discount": 20.0,
      "special_price": 10.10 * 0.8,
      "view_number": 0,
      "buy_number": 0,
      "images": [
        '$baseApiUrl/product/images/0a0cc1fd-83f8-4131-8ef2-ef97b7337c8c.png',
        '$baseApiUrl/product/images/0a0cc1fd-83f8-4131-8ef2-ef97b7337c8c.png',
        '$baseApiUrl/product/images/0a0cc1fd-83f8-4131-8ef2-ef97b7337c8c.png',
      ],
    };

    return List.generate(3, (_) => ProductModel.fromJson(productData));
  }
}
