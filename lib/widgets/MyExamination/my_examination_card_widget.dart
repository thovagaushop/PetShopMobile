import 'package:flutter/material.dart';
import 'package:test_flutter_2/models/examination_booking_model.dart';

class MyExaminationCardWidget extends StatefulWidget {
  final ExaminationBookingModel examinationBookingModel;
  final VoidCallback onUpdate;
  const MyExaminationCardWidget(
      {super.key,
      required this.examinationBookingModel,
      required this.onUpdate});

  @override
  State<MyExaminationCardWidget> createState() =>
      _MyExaminationCardWidgetState();
}

class _MyExaminationCardWidgetState extends State<MyExaminationCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 1, child: Column(children: [])),
          SizedBox(
            width: 4,
          ),
          Expanded(
              flex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "dasdasd",
                        // 'At: ${widget.orderModel.orderDate!}',
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
                      Text("dasdasd"
                          // widget.orderModel.orderStatus!,
                          // style: TextStyle(
                          //     color: widget.orderModel.orderStatus! == "SUCCESS"
                          //         ? Colors.green
                          //         : Colors.yellow.shade700),
                          )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("dasdasd"
                      // widget.orderModel.paymentMethod!,
                      // style: TextStyle(
                      //     color: widget.orderModel.paymentMethod! == "CAST"
                      //         ? Colors.blue
                      //         : Colors.red.shade700),
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text(
                      //   'Address: ${widget.orderModel.address!}',
                      //   style: const TextStyle(
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 14,
                      //       overflow: TextOverflow.clip),
                      //   maxLines: 1,
                      // ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
