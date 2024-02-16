import 'package:flutter/material.dart';
import 'package:test_flutter_2/widgets/Product/product_card.dart';

class ProductGridWidget extends StatefulWidget {
  const ProductGridWidget({super.key});

  @override
  State<ProductGridWidget> createState() => _ProductGridWidgetState();
}

class _ProductGridWidgetState extends State<ProductGridWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
        children: [
          Container(
            height: 600, // Height constraint for the GridView
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(20, (index) {
                return ProductCardWidget();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
