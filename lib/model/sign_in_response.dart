import 'dart:convert';

SignInResponse signInResponseFromJson(String str) => SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  SignInResponse({
    required this.apiStatus,
    required this.data,
    required this.message,
  });

  bool? apiStatus;
  Data? data;
  String? message;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
    apiStatus: json["apiStatus"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "apiStatus": apiStatus,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    required this.user,
    required this.token,
  });

  User? user;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user!.toJson(),
    "token": token,
  };
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.subscription,
    required this.dependent,
    required this.isActive,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  bool subscription;
  bool dependent;
  bool isActive;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
    subscription: json["subscription"],
    dependent: json["dependent"],
    isActive: json["isActive"],
    image: json["image"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "subscription": subscription,
    "dependent": dependent,
    "isActive": isActive,
    "image": image,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
