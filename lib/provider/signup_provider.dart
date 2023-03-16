import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:http/http.dart';
import 'package:voithy/model/register_request_body.dart';
import 'package:voithy/model/auth_response.dart';
import 'package:voithy/repository/auth_user_apis.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import '../model/email_body.dart';
class SignUpProvider extends ChangeNotifier {
  String? _email;
  String? _phoneNumber;
  String? _userFirstName;
  String? _userLastName;
  String? _password;
  String? _confirmPassword;
  bool _isValidForm = false;
  bool _isValidForm2 = false;
  bool _agreeTerms = false;
  String? _userOTP;
  bool isVerificationOtp = true;


  bool get isValidForm2 => _isValidForm2;

  set isValidForm2(bool value) {
    _isValidForm2 = value;
  }

  String? get userOTP => _userOTP;

  set userOTP(String? value) {
    _userOTP = value;
    notifyListeners();
  }

  bool get agreeTerms => _agreeTerms;

  set agreeTerms(bool value) {
    _agreeTerms = value;
    notifyListeners();
  }

  set isValidForm(bool isValidForm) {
    _isValidForm = isValidForm;
    notifyListeners();
  }

  bool get isValidForm => _isValidForm;

  String? get confirmPassword => _confirmPassword;

  set confirmPassword(String? value) {
    _confirmPassword = value;
    notifyListeners();
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String? get password => _password;

  set password(String? value) {
    _password = value;
  }

  String? get userLastName => _userLastName;

  set userLastName(String? value) {
    _userLastName = value;
    notifyListeners();
  }

  String? get userFirstName => _userFirstName;

  set userFirstName(String? value) {
    _userFirstName = value;
    notifyListeners();
  }

  String? get phoneNumber => _phoneNumber;

  set phoneNumber(String? value) {
    _phoneNumber = value;
    notifyListeners();
  }

  Future<AuthResponse> registerNewUser() async {
    AuthUserApis authUserApis = AuthUserApis();
    Response? response = await authUserApis.registerUser(
        body: RegisterBody(
            _email, _phoneNumber, _userFirstName, _userLastName, _password));
    if (response != null) {
      AuthResponse authResponse =
          AuthResponse.fromJson(json.decode(response.body));
      return authResponse;
    } else {
      AuthResponse authResponse =
          AuthResponse(message: AppStrings.somethingWentWrong, apiStatus: false);
      return authResponse;
    }
  }

  Future<AuthResponse> requestResendOtp() async {
    AuthUserApis authUserApis = AuthUserApis();
    Response? response = await authUserApis.requestResendOtp(
        body: EmailBody(_email),
        params: {"verificationOtp": 'true' as dynamic});
    if (response != null) {
      AuthResponse authResponse =
      AuthResponse.fromJson(json.decode(response.body));
      return authResponse;
    } else {
      AuthResponse authResponse =
      AuthResponse(message: AppStrings.somethingWentWrong, apiStatus: false);
      return authResponse;
    }
  }

  Future<AuthResponse> validateOtp() async {
    AuthUserApis authUserApis = AuthUserApis();
    Response? response = await authUserApis.validateOtp(
        body: EmailBody(_email), params: {"verificationOtp": userOTP});
    if (response != null) {
      AuthResponse authResponse =
      AuthResponse.fromJson(json.decode(response.body));
      return authResponse;
    } else {
      AuthResponse authResponse =
      AuthResponse(message: AppStrings.wrongOTP, apiStatus: false);
      return authResponse;
    }
  }
  void disposeData()
  {
    this.email = null;
    this.userFirstName = null;
    this.userLastName = null;
    this.phoneNumber = null;
    this.password = null;
    this.confirmPassword = null;
    this.agreeTerms = false;
    this.userOTP = null;
  }
}
