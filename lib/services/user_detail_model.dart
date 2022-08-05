class userDetailModel {
  final String name;
  final String phone;
  final String email;
  final String password;
  userDetailModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> getJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      };

  factory userDetailModel.getModelFromJson(Map<String, dynamic> json) {
    return userDetailModel(
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        password: json['password']);
  }
}
