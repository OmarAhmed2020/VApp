import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class LocaleController extends GetxController{
  // this function get the device language an a default app language in the first case ,
  //otherwise choose between arabic and english with using shared preferences to store its value on device
Locale? inialLanguage=shardpref.getString("currentLang")==null ?Get.deviceLocale:Locale(shardpref.getString("currentLang")!);
  void ChangeLanguage( String language){
    Locale locale = Locale(language);
    shardpref.setString("currentLang", language);
    Get.updateLocale(locale);
  }
}