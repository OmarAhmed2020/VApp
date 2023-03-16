import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTxtStyles {
  //TODO How to name txtStyle method?
  static TextStyle getAppRegularFont(
      {required double size, required FontWeight fontWeight}) {
    return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: Colors.black,
      fontFamily: Get.locale == const Locale("ar") ? "NotoSansArabic" : "Roboto_Reg",
    );
  }
}
