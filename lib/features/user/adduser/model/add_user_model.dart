class AddUserModel {
  final String name;
  final String email;
  final String gender;
  final String status;

  AddUserModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "gender": gender, "status": status};
  }

  factory AddUserModel.fromJson(Map<String, dynamic> json) {
    return AddUserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
