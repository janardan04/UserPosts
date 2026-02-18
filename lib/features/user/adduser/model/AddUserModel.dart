class Addusermodel {
  final String name;
  final String email;
  final String gender;
  final String status;

  Addusermodel({
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "gender": gender, "status": status};
  }

  factory Addusermodel.fromJson(Map<String, dynamic> json) {
    return Addusermodel(
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      status: json['status'],
    );
  }
}
