import 'dart:convert'; // ignore:file_names

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success.toString(),
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.token,
    this.user,
  });

  String? token;
  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"].toString(),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token.toString(),
    "user": user!.toJson(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.role,
    this.uid,
    this.createdAt,
    this.updatedAt,
    this.projectId,
  });

  String? id;
  String? name;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? role;
  String? uid;
  String? createdAt;
  String? updatedAt;
  String? projectId;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"].toString(),
    name: json["name"].toString(),
    email: json["email"].toString(),
    profileImage: json["profile_image"].toString(),
    phoneNumber: json["phone_number"].toString(),
    role: json["role"].toString(),
    uid: json["uid"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    projectId: json["projectId"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "name": name.toString(),
    "email": email.toString(),
    "profile_image": profileImage.toString(),
    "phone_number": phoneNumber.toString(),
    "role": role.toString(),
    "uid": uid.toString(),
    "created_at": createdAt.toString(),
    "updated_at": updatedAt.toString(),
    "projectId": projectId.toString(),
  };
}
