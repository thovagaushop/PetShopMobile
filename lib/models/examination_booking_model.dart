class ExaminationBookingModel {
  int? id;
  String? email;
  String? date;
  String? description;

  ExaminationBookingModel({
    this.id,
    this.email,
    this.date,
    this.description,
  });

  factory ExaminationBookingModel.fromJson(Map<String, dynamic> json) {
    return ExaminationBookingModel(
      id: json['id'],
      email: json['email'],
      date: json['date'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['date'] = date;
    data['description'] = description;
    return data;
  }
}
