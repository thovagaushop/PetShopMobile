import 'package:flutter/material.dart';
import 'package:test_flutter_2/models/cart_model.dart';
import 'package:test_flutter_2/widgets/Cart/cart_card.dart';

class CartBodyWidget extends StatefulWidget {
  final List<CartModel> cartModels;
  final VoidCallback onUpdate;
  const CartBodyWidget(
      {super.key, required this.cartModels, required this.onUpdate});

  @override
  State<CartBodyWidget> createState() => _CartBodyWidgetState();
}

class _CartBodyWidgetState extends State<CartBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
        children: [
          SizedBox(
              height: 550,
              child: ListView.separated(
                padding: const EdgeInsets.all(5),
                itemCount: widget.cartModels.length,
                itemBuilder: (context, index) {
                  return CartCardWidget(
                      cartModel: widget.cartModels[index],
                      onUpdate: () {
                        widget.onUpdate();
                      });
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
              )),
        ],
      ),
    );
  }
}
