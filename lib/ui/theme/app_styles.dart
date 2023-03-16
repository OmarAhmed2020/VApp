import 'package:flutter/material.dart';

class AppStyles{
  static ButtonStyle defaultButtonStyleWithRadius(BorderRadius borderRadius,
      {EdgeInsets? padding, Color? backgroundColor, Size? minimumSize}) {
    return TextButton.styleFrom(
      padding: padding,
      minimumSize: minimumSize,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
    );
  }
}