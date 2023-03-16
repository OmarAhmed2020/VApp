import 'package:http/http.dart';
import 'package:voithy/model/register_request_body.dart';
import 'package:voithy/model/email_password_request_body.dart';
import 'package:voithy/repository/http_client.dart';
import '../model/email_body.dart';
import 'end_points.dart';

class AuthUserApis {
  Future<Response?> registerUser({required RegisterBody body}) async {
    return await HttpClient.post(
        endpoint: EndPoints.register, body: body.toJson());
  }

  Future<Response?> loginUser({required EmailPasswordBody body}) async {
    return await HttpClient.post(
        endpoint: EndPoints.login, body: body.toJson());
  }

  Future<Response?> requestResendOtp(
      {Map<String, dynamic>? params, required EmailBody body}) async {
    return await HttpClient.put(
        endpoint: EndPoints.resendOTP,
        body: body.toJson(),
        params: params as Map<String, dynamic>);
  }

  Future<Response?> requestResetPassword({required EmailBody body}) async {
    return await HttpClient.post(
        endpoint: EndPoints.requestResetPassword, body: body.toJson());
  }

  Future<Response?> validateOtp(
      {required EmailBody body, required Map<String, dynamic> params}) async {
    return await HttpClient.post(
        params: params, endpoint: EndPoints.checkOTP, body: body.toJson());
  }

  Future<Response?> requestChangePassword({required EmailPasswordBody body}) async {
    return await HttpClient.put(
        endpoint: EndPoints.requestChangePassword, body: body.toJson());
  }
}
