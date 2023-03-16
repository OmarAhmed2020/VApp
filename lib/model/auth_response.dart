import 'dart:convert';

AuthResponse authResponseFromJson(String str) => AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  AuthResponse({
    this.apiStatus,
    this.message,
  });

  bool? apiStatus;
  String? message;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    apiStatus: json["apiStatus"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "apiStatus": apiStatus,
    "message": message,
  };
}
