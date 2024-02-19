import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/cart_provider.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/cart_model.dart';
import 'package:test_flutter_2/models/product_model.dart';
import 'package:test_flutter_2/screen/login_screen.dart';
import 'package:test_flutter_2/services/cart/cart_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/Header/main_header.dart';
import 'package:test_flutter_2/widgets/Product/product_detail_body.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 0;
  bool _isLoading = false;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity >= 1) {
      setState(() {
        quantity--;
      });
    }
  }

  Future<void> handleAddToCart(
      String? token, dynamic cartProvider, int productId) async {
    setState(() {
      _isLoading = true;
    });
    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar("Login first", "danger"));

      Future.delayed(const Duration(seconds: 3));

      setState(() {
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginScreen(
                  isHistory: true,
                )),
      );

      return;
    }

    // Validation quantity
    if (quantity <= 0) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      CartModel cartModel =
          await CartService().addProductToCart(productId, quantity, token);

      cartProvider.addItem(cartModel);
      setState(() {
        _isLoading = false;
      });
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBarService.showSnackbar(
          "Add product to cart successfully!!!", "success"));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const MainHeaderWidget(hasLeftIcon: true),
              const SizedBox(
                height: 5,
              ),
              ProductDetailBody(product: widget.product),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 90,
          decoration: const BoxDecoration(
              color: AppColors.mainColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(97, 97, 97, 1),
                    blurRadius: 1,
                    spreadRadius: 1.0,
                    offset: Offset(1.0, 1.0))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: decreaseQuantity,
                        icon: const Icon(
                          Icons.remove,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.primary),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      IconButton(
                        onPressed: increaseQuantity,
                        icon: const Icon(
                          Icons.add,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => handleAddToCart(
                      userProvider.token, cartProvider, widget.product.id!),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(30)),
                    child: _isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(), // or any other loading indicator
                          )
                        : const Text(
                            "Add to cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _builderPageItem(int index) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: index.isEven ? AppColors.mainColorFocus : Colors.black26),
    );
  }
}
