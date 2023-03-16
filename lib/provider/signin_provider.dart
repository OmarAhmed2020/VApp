import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voithy/model/register_request_body.dart';
import 'package:voithy/model/email_password_request_body.dart';
import 'package:voithy/repository/auth_user_apis.dart';

import '../model/sign_in_response.dart';
import '../ui/theme/app_colors.dart';
import '../ui/theme/app_styles.dart';
import '../ui/theme/app_txt_styles.dart';

class SignInProvider extends ChangeNotifier {
  String? _email;
  String? _password;
  bool _isValidForm = false;
  String? _userToken;

  bool get isValidForm => _isValidForm;

  set isValidForm(bool value) {
    _isValidForm = value;
    notifyListeners();
  }

  String? get userToken => _userToken;

  set userToken(String? value) {
    _userToken = value;
    notifyListeners();
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  String? get password => _password;

  set password(String? value) {
    _password = value;
    notifyListeners();
  }

  Future<SignInResponse> signInUser() async {
    AuthUserApis authUserApis = AuthUserApis();
    Response? response = await authUserApis.loginUser(
        body: EmailPasswordBody(_email, _password));
    print(response?.statusCode);
    print(response?.body);
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      SignInResponse signInResponse =
          SignInResponse.fromJson(json.decode(response!.body));
      _userToken = signInResponse.data?.token;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userToken', _userToken!);
      notifyListeners();
      return signInResponse;
    } else {
      Map<String, dynamic> responseMap = json.decode(response!.body);
      SignInResponse signInResponse = SignInResponse(
          apiStatus: false, message: responseMap["message"], data: null);
      return signInResponse;
    }
  }
}
