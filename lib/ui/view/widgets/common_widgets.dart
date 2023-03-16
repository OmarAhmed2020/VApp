import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../theme/app_colors.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../theme/app_styles.dart';
import '../../theme/app_txt_styles.dart';

// Default button
Widget defaultButton(
        {
          required double width,
        Color background = const Color.fromARGB(255, 41, 87, 136),
        required Function function,
        required String text,
        required Color txtColor,
        required double height,
        required double radius,
        required double fontSize,
        required Color borderColor,
        TextStyle? txtStyle}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: background,
          border: Border.all(width: 1.0, color: borderColor)),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: txtStyle ?? TextStyle(color: txtColor, fontSize: fontSize,),
        ),
      ),
    );

// this snackBar for signin and signup screen
// apply on validation error (empty text field)
void showSnackBar({required BuildContext context, required String msg}) {
  showTopSnackBar(
    Overlay.of(context)!,
    CustomSnackBar.info(
      message: msg,
      backgroundColor: AppColors.color295788,
      messagePadding: const EdgeInsets.all(5),
      icon: const Icon(
        Icons.info,
        color: Color(0x15000000),
        size: 120,
      ),
    ),
  );
}
ButtonStyle getDefaultBtnStyle(bool _isValidForm) {
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

TextStyle getBtnTxtStyle(bool _isValidForm) {
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
Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));
  if (picked != null && picked != DateTime.now()) {
    return picked;
  }
  return null;
}