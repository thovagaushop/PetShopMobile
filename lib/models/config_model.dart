class ConfigModel {
  String? id;
  int? maxPlaceTakeCare;
  int? currentTakeCareBooking;
  int? maxPlaceExamination;
  int? currentExaminationBooking;
  double? priceSlotSizeS;
  double? priceSlotSizeM;
  double? priceSlotSizeL;
  String? food1;
  String? food1Image;
  double? food1Price;
  String? food2;
  String? food2Image;
  double? food2Price;
  String? food3;
  String? food3Image;
  double? food3Price;

  String? service1;
  double? service1Price;
  String? service2;
  double? service2Price;

  ConfigModel({
    this.id,
    this.maxPlaceTakeCare,
    this.currentTakeCareBooking,
    this.maxPlaceExamination,
    this.currentExaminationBooking,
    this.priceSlotSizeS,
    this.priceSlotSizeM,
    this.priceSlotSizeL,
    this.food1,
    this.food1Image,
    this.food1Price,
    this.food2,
    this.food2Image,
    this.food2Price,
    this.food3,
    this.food3Image,
    this.food3Price,
    this.service1,
    this.service1Price,
    this.service2,
    this.service2Price,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      id: json['id'],
      maxPlaceTakeCare: json['maxPlaceTakeCare'],
      currentTakeCareBooking: json['currentTakeCareBooking'],
      maxPlaceExamination: json['maxPlaceExamination'],
      currentExaminationBooking: json['currentExaminationBooking'],
      priceSlotSizeS: json['priceSlotSizeS'],
      priceSlotSizeM: json['priceSlotSizeM'],
      priceSlotSizeL: json['priceSlotSizeL'],
      food1: json['food1'],
      food1Image: json['food1Image'],
      food1Price: json['food1Price'],
      food2: json['food2'],
      food2Image: json['food2Image'],
      food2Price: json['food2Price'],
      food3: json['food3'],
      food3Image: json['food3Image'],
      food3Price: json['food3Price'],
      service1: json['service1'],
      service1Price: json['service1Price'],
      service2: json['service2'],
      service2Price: json['service2Price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['maxPlaceTakeCare'] = maxPlaceTakeCare;
    data['currentTakeCareBooking'] = currentTakeCareBooking;
    data['maxPlaceExamination'] = maxPlaceExamination;
    data['currentExaminationBooking'] = currentExaminationBooking;
    data['priceSlotSizeS'] = priceSlotSizeS;
    data['priceSlotSizeM'] = priceSlotSizeM;
    data['priceSlotSizeL'] = priceSlotSizeL;
    data['food1'] = food1;
    data['food1Image'] = food1Image;
    data['food1Price'] = food1Price;
    data['food2'] = food2;
    data['food2Image'] = food2Image;
    data['food2Price'] = food2Price;
    data['food3'] = food3;
    data['food3Image'] = food3Image;
    data['food3Price'] = food3Price;
    data['service1'] = service1;
    data['service1Price'] = service1Price;
    data['service2'] = service2;
    data['service2Price'] = service2Price;
    return data;
  }
}
