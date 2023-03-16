import 'package:flutter/cupertino.dart';

class AppColors {

  static const Color colorF6F8FC = Color(0xffF6F8FC);
  static const Color colorECECEC = Color(0xffECECEC);
  static const Color colorFAFAFA = Color(0xffFAFAFA);
  static const Color color295788 = Color(0xFF295788);
  static const Color facebookColor = const Color(0xff39579A);
  static const Color googleColor = const Color(0xffDF4A32);
  static const Color borderSocialButtons = Color(0xffECECEC);
  static const Color colorE86606 = Color(0xFFE84034);
  static const Color colore74034 = Color(0xFFe74034);
  static const Color color565656 = Color(0xff565656);
  static const Color colorececec = Color(0xffececec);
  static const Color colorffeae8 = Color(0xffffeae8);
  static const Color colore7fce6 = Color(0xffe7fce6);
  static const Color colorfffae6 = Color(0xfffffae6);



  static const Color color8f8f8f = Color(0xff8f8f8f);
  static const Color color007aff = Color(0xff007aff);

  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    /// if [500] is the default color, there are at LEAST five
    /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
    /// divisor of 5 would mean [50] is a lightness of 1.0 or
    /// a color of #ffffff. A value of six would be near white
    /// but not quite.
    final lowDivisor = 6;

    /// if [500] is the default color, there are at LEAST four
    /// steps above [500]. A divisor of 4 would mean [900] is
    /// a lightness of 0.0 or color of #000000
    final highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }

}