import 'package:flutter/material.dart';
import 'package:test_flutter_2/models/order_model.dart';

class MyOrderCardWidget extends StatefulWidget {
  final OrderModel orderModel;
  final VoidCallback onUpdate;
  const MyOrderCardWidget(
      {super.key, required this.orderModel, required this.onUpdate});

  @override
  State<MyOrderCardWidget> createState() => _MyOrderCardWidgetState();
}

class _MyOrderCardWidgetState extends State<MyOrderCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (var item in widget.orderModel.orderItems!)
                      Text(
                        '${item['product']['title']} x ${item['quantity']}', // Assuming there's a property 'name' in your order item
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    const Divider(
                      color: Colors.black, // Color of the line
                      thickness: 1.0, // Thickness of the line
                    ),
                    Text(
                      'Amount: ${widget.orderModel.totalAmount.toString()}', // Assuming there's a property 'name' in your order item
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ])),
          Container(
            width: 1.0, // Width of the line
            height: double
                .infinity, // Height of the line, set to match the height of the parent container
            color: Colors.black, // Color of the line
          ),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'At: ${widget.orderModel.orderDate!}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            overflow: TextOverflow.clip),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        widget.orderModel.orderStatus!,
                        style: TextStyle(
                            color: widget.orderModel.orderStatus! == "SUCCESS"
                                ? Colors.green
                                : Colors.yellow.shade700),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.orderModel.paymentMethod!,
                    style: TextStyle(
                        color: widget.orderModel.paymentMethod! == "CAST"
                            ? Colors.blue
                            : Colors.red.shade700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Address: ${widget.orderModel.address!}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            overflow: TextOverflow.clip),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
