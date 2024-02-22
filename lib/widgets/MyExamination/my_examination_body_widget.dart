import 'package:flutter/material.dart';
import 'package:test_flutter_2/models/examination_booking_model.dart';
import 'package:test_flutter_2/widgets/MyExamination/my_examination_card_widget.dart';

class MyExaminationBodyWidget extends StatefulWidget {
  final List<ExaminationBookingModel> examinationModel;
  final VoidCallback onUpdate;
  const MyExaminationBodyWidget(
      {super.key, required this.examinationModel, required this.onUpdate});

  @override
  State<MyExaminationBodyWidget> createState() =>
      _MyExaminationBodyWidgetState();
}

class _MyExaminationBodyWidgetState extends State<MyExaminationBodyWidget> {
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
                itemCount: widget.examinationModel.length,
                itemBuilder: (context, index) {
                  return MyExaminationCardWidget(
                      examinationBookingModel: widget.examinationModel[index],
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
