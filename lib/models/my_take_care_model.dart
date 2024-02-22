class MyTakeCareModel {
  int? id;
  String? startDate;
  String? endDate;
  String? petType;
  String? note;
  double? price;

  MyTakeCareModel(
      {this.id,
      this.startDate,
      this.endDate,
      this.petType,
      this.note,
      this.price});

  factory MyTakeCareModel.fromJson(Map<String, dynamic> json) {
    return MyTakeCareModel(
      id: json["id"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      petType: json["petType"],
      price: json["price"],
      note: json["note"],
    );
  }
}
