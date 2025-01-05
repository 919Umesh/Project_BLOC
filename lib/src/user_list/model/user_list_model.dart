class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.v,
  });

  final String id;
  final String name;
  final String email;
  final int v;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "__v": v,
  };
}
