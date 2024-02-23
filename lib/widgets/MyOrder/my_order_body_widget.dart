import 'package:flutter/material.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/models/order_model.dart';
import 'package:test_flutter_2/widgets/MyOrder/my_order_card_widget.dart';

class MyOrderBodyWidget extends StatefulWidget {
  final List<OrderModel> orderModels;
  final VoidCallback onUpdate;
  const MyOrderBodyWidget(
      {super.key, required this.orderModels, required this.onUpdate});

  @override
  State<MyOrderBodyWidget> createState() => _MyOrderBodyWidgetState();
}

class _MyOrderBodyWidgetState extends State<MyOrderBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 650,
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                itemCount: widget.orderModels.length,
                itemBuilder: (context, index) {
                  return MyOrderCardWidget(
                      orderModel: widget.orderModels[index],
                      onUpdate: () {
                        widget.onUpdate();
                      });
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(thickness: 1, color: AppColors.primary),
              )),
        ],
      ),
    );
  }
}
