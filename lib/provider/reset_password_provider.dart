import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:voithy/model/email_body.dart';
import 'package:voithy/model/email_password_request_body.dart';
import '../model/auth_response.dart';
import '../model/resend_otp_params.dart';
import '../repository/auth_user_apis.dart';
import '../ui/theme/app_colors.dart';
import '../ui/theme/app_styles.dart';
import '../ui/theme/app_txt_styles.dart';

class ResetPasswordProvider extends ChangeNotifier {
  String? _email;
  dynamic _userOTP;
  String? _password;
  String? _confirmPassword;
  bool _isValidForm = false;
  bool isPasswordOtp = true;

  bool get isValidForm => _isValidForm;

  set isValidForm(bool value) {
    _isValidForm = value;
    notifyListeners();
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  dynamic get userOTP => _userOTP;

  set userOTP(dynamic value) {
    _userOTP = value!;
    notifyListeners();
  }

  String? get password => _password;

  set password(String? value) {
    _password = value;
  }

  String? get confirmPassword => _confirmPassword;

  set confirmPassword(String? value) {
    _confirmPassword = value;
  }

  Future<AuthResponse> requestUpdatePasswordOTP() async {
    AuthUserApis authUserApis = AuthUserApis();
    Response? response =
        await authUserApis.requestResetPassword(body: EmailBody(_email));
    AuthResponse authResponse =
        AuthResponse.fromJson(json.decode(response!.body));
    return authResponse;
  }

  Future<AuthResponse> requestResetPasswordResendOtp() async {
    AuthUserApis authUserApis = AuthUserApis();
    Response? response = await authUserApis.requestResendOtp(
        body: EmailBody(_email),
        params: {"passwordOtp": 'true' as dynamic});
    AuthResponse authResponse =
        AuthResponse.fromJson(json.decode(response!.body));
    return authResponse;
  }

  Future<AuthResponse> validateResetPasswordOtp() async {
    AuthUserApis authUserApis = AuthUserApis();
    Response? response = await authUserApis
        .validateOtp(body: EmailBody(_email), params: {"passwordOtp": userOTP});
    AuthResponse authResponse =
        AuthResponse.fromJson(json.decode(response!.body));
    return authResponse;
  }

  Future<AuthResponse> requestChangePassword() async {
    AuthUserApis authUserApis = AuthUserApis();
    Response? response = await authUserApis.requestChangePassword(
        body: EmailPasswordBody(_email, password));
    AuthResponse authResponse =
        AuthResponse.fromJson(json.decode(response!.body));
    return authResponse;
  }

  ButtonStyle getBtnStyle() {
    if (_isValidForm) {
      return AppStyles.defaultButtonStyleWithRadius(
          const BorderRadius.all(Radius.circular(10.0)),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          backgroundColor: AppColors.color295788,
          minimumSize: const Size(20, 20));
    } else {
      return AppStyles.defaultButtonStyleWithRadius(
          const BorderRadius.all(Radius.circular(10.0)),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          backgroundColor: AppColors.colorECECEC,
          minimumSize: const Size(20, 20));
    }
  }

  TextStyle getBtnTxtStyle() {
    if (_isValidForm) {
      return AppTxtStyles.getAppRegularFont(
              size: 18, fontWeight: FontWeight.w700)
          .copyWith(color: Colors.white);
    } else {
      return AppTxtStyles.getAppRegularFont(
              size: 18, fontWeight: FontWeight.w700)
          .copyWith(color: Colors.black38);
    }
  }

  getBoxDecoration() {
    if (_isValidForm) {
      return BoxDecoration(
          color: AppColors.color295788,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 2.0, color: AppColors.color295788));
    } else {
      return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 2.0, color: Colors.black12));
    }
  }
}
