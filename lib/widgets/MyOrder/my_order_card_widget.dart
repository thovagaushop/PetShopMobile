import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 130,
                  decoration: BoxDecoration(
                    color: AppColors.secondary1,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Expanded(
                      flex: 0,
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
                                  // overflow: TextOverflow.ellipsis
                                ),
                                maxLines: 1,
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
                                // overflow: TextOverflow.ellipsis
                              ),
                              maxLines: 1,
                            ),
                          ])),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 5),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            width: 250,
                            decoration: BoxDecoration(
                              color: AppColors.secondary1,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time: ${widget.orderModel.orderDate!}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  widget.orderModel.paymentMethod!,
                                  style: TextStyle(
                                      color: widget.orderModel.paymentMethod! ==
                                              "CAST"
                                          ? Colors.blue
                                          : Colors.red.shade700),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Expanded(
                                  flex: 0,
                                  child: Text(
                                    'Address: ${widget.orderModel.address!}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        overflow: TextOverflow.clip),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.5), // Màu của bóng đổ và độ trong suốt
                                    spreadRadius: 2, // Độ lan rộng của bóng đổ
                                    blurRadius: 5, // Độ mờ của bóng đổ
                                    offset: const Offset(0,
                                        2), // Độ dịch chuyển của bóng đổ theo trục X và Y
                                  ),
                                ]),
                            child: Center(
                              child: Text(
                                widget.orderModel.orderStatus!,
                                style: TextStyle(
                                    color: widget.orderModel.orderStatus! ==
                                            "SUCCESS"
                                        ? Colors.green
                                        : Colors.yellow.shade700),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: Padding(
              //           padding: EdgeInsets.all(5),
              //           child: Container(
              //             padding: EdgeInsets.all(5),
              //             child: Expanded(
              //                 flex: 0,
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                   children: [
              //                     Row(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           'At: ${widget.orderModel.orderDate!}',
              //                           style: const TextStyle(
              //                               color: Colors.black,
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 14,
              //                               overflow: TextOverflow.clip),
              //                           maxLines: 1,
              //                         ),
              //                         const SizedBox(
              //                           width: 2,
              //                         ),
              //                         Expanded(
              //                           child: Text(
              //                             widget.orderModel.orderStatus!,
              //                             style: TextStyle(
              //                                 color:
              //                                     widget.orderModel.orderStatus! ==
              //                                             "SUCCESS"
              //                                         ? Colors.green
              //                                         : Colors.yellow.shade700),
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                     const SizedBox(
              //                       height: 10,
              //                     ),
              //                     SizedBox(
              //                       child: Text(
              //                         widget.orderModel.paymentMethod!,
              //                         style: TextStyle(
              //                             color: widget.orderModel.paymentMethod! ==
              //                                     "CAST"
              //                                 ? Colors.blue
              //                                 : Colors.red.shade700),
              //                       ),
              //                     ),
              //                     Row(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       crossAxisAlignment: CrossAxisAlignment.center,
              //                       children: [
              //                         Expanded(
              //                           child: Text(
              //                             'Address: ${widget.orderModel.address!}',
              //                             style: const TextStyle(
              //                                 color: Colors.black,
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize: 14,
              //                                 overflow: TextOverflow.clip),
              //                             maxLines: 1,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 )),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
