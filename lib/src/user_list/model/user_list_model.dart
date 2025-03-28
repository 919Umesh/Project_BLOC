
class UsersResponseModel {
  UsersResponseModel({
    required this.status,
    required this.message,
    required this.users,
  });

  final int status;
  final String message;
  final List<UserModel> users;

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) {
    return UsersResponseModel(
      status: json["status"] ?? 0,
      message: json["message"] ?? "",
      users: json["users"] == null
          ? []
          : List<UserModel>.from(
          json["users"]!.map((x) => UserModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "users": users.map((x) => x.toJson()).toList(),
  };
}

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
  final dynamic v;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "__v": v,
  };
}
