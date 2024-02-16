class UserModel {
  String? id;
  String? email;
  String? token;

  UserModel({this.id, this.email, this.token});

  UserModel copyWith({
    String? id,
    String? email,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print("Factory" + json.toString());
    return UserModel(
      id: json['id'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}
