import 'package:flutter/material.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/models/my_take_care_model.dart';
import 'package:test_flutter_2/widgets/MyTakeCare/my_take_care_card_widget.dart';

class MyTakeCareBodyWidget extends StatefulWidget {
  final List<MyTakeCareModel> takeCareModel;
  final VoidCallback onUpdate;
  const MyTakeCareBodyWidget(
      {super.key, required this.takeCareModel, required this.onUpdate});

  @override
  State<MyTakeCareBodyWidget> createState() => _MyTakeCareBodyWidgetState();
}

class _MyTakeCareBodyWidgetState extends State<MyTakeCareBodyWidget> {
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
                itemCount: widget.takeCareModel.length,
                itemBuilder: (context, index) {
                  return MyTakeCareCardWidget(
                      takeCareModel: widget.takeCareModel[index],
                      onUpdate: () {
                        widget.onUpdate();
                      });
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  thickness: 1,
                  color: AppColors.primary,
                ),
              )),
        ],
      ),
    );
  }
}
