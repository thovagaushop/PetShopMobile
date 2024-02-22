class ProfileModel {
  String? id;
  String? email;
  String? firstname;
  String? lastname;
  String? phoneNumber;
  String? address;

  ProfileModel({
    this.id,
    this.email,
    this.firstname,
    this.lastname,
    this.phoneNumber,
    this.address,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      email: json['email'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }
}
