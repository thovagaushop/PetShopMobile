import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/cart_provider.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/cart_model.dart';
import 'package:test_flutter_2/services/cart/cart_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/utils/utils.dart';

class CartCardWidget extends StatefulWidget {
  final CartModel cartModel;
  final VoidCallback onUpdate;
  const CartCardWidget(
      {super.key, required this.cartModel, required this.onUpdate});

  @override
  State<CartCardWidget> createState() => _CartCardWidgetState();
}

class _CartCardWidgetState extends State<CartCardWidget> {
  int quantity = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      quantity = widget.cartModel.quantity!;
    });
  }

  Future<void> handleDeleteProduct(int productId, String token) async {
    try {
      setState(() {
        _isLoading = true;
      });
      String message =
          await CartService().deleteProductFromCart(productId, token);
      if (!context.mounted) return;
      Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      widget.onUpdate();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(message, "success"));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void handleUpdateQuantity(int productId, String token) async {
    try {
      setState(() {
        _isLoading = true;
      });

      String message =
          await CartService().updateQuantity(productId, token, quantity);
      if (!context.mounted) return;
      widget.onUpdate();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(message, "success"));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void handleIncreaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void handleDecreaseQuantity() {
    if (quantity >= 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 20),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        Utils().getImageUrl(widget.cartModel.image!),
                        // height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        colorBlendMode: BlendMode.overlay,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.cartModel.productTitle!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                handleDeleteProduct(widget.cartModel.productId!,
                                    userProvider.token!);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: AppColors.secondary,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("\$${widget.cartModel.productSpecialPrice!}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        return handleIncreaseQuantity();
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                    Text(quantity.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                    IconButton(
                                      onPressed: () {
                                        return handleDecreaseQuantity();
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          return handleUpdateQuantity(
                                              widget.cartModel.productId!,
                                              userProvider.token!);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: AppColors.primary,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ],
                    )),
              ],
            ),
    );
  }
}
