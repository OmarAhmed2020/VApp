import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import 'package:voithy/ui/theme/app_txt_styles.dart';
import 'package:voithy/ui/view/signin/signin_screen.dart';
import 'package:voithy/ui/view/widgets/app_bar_widget.dart';
import '../../../provider/reset_password_provider.dart';
import '../../theme/app_styles.dart';
import '../widgets/common_widgets.dart';
import '../widgets/custom_shawdow_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resetPasswordProvider =
        Provider.of<ResetPasswordProvider>(context, listen: true);
    Provider.of<ResetPasswordProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: AppColors.colorF6F8FC,
      appBar: getAppBarWidget(),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.changePassword.tr,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 22.sp, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomShadowFormTextField(
                showStickyLabel: true,
                labelText: AppStrings.newPassword.tr,
                stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                    size: 15, fontWeight: FontWeight.w700),
                isMandatory: true,
                maxLines: 1,
                isEditable: true,
                worksAsPopup: false,
                obscureText: true,
                hintText: AppStrings.pleaseEnterYourPassword.tr,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.required.tr;
                  }
                  return value;
                },
                onValueChanged: (value) {
                  resetPasswordProvider.password = value;
                },
                onSaved: (String? value) {
                  resetPasswordProvider.password = value;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomShadowFormTextField(
                showStickyLabel: true,
                labelText: AppStrings.confirmNewPassword.tr,
                stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                    size: 15, fontWeight: FontWeight.w700),
                isMandatory: true,
                maxLines: 1,
                isEditable: true,
                worksAsPopup: false,
                obscureText: true,
                hintText: AppStrings.pleaseEnterYourPassword.tr,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.required.tr;
                  }
                  return value;
                },
                onValueChanged: (value) {
                  if (value == null || value.isEmpty) {
                    resetPasswordProvider.isValidForm = false;
                  } else {
                    resetPasswordProvider.isValidForm = true;
                  }
                  resetPasswordProvider.confirmPassword = value;
                },
                onSaved: (String? value) {
                  if (value == null || value.isEmpty) {
                    resetPasswordProvider.isValidForm = false;
                  } else {
                    resetPasswordProvider.isValidForm = true;
                  }
                  resetPasswordProvider.confirmPassword = value;
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.7,
            ),
            InkWell(
              onTap: () {
                if (resetPasswordProvider.password ==
                    resetPasswordProvider.confirmPassword) {
                  resetPasswordProvider
                      .requestChangePassword()
                      .then((response) {
                    if (response.apiStatus!) {
                      Get.to(SignInScreen());
                    } else {
                      showSnackBar(
                          context: context,
                          msg:
                              "${AppStrings.apiError.tr}ErrorMsg: ${response.message}.");
                    }
                  });
                } else {
                  showSnackBar(
                      context: context, msg: AppStrings.passwordsDontMatch.tr);
                }
              },
              child: SizedBox(
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.black12),
                        )),
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 50),
                      decoration: resetPasswordProvider.getBoxDecoration(),
                      child: Text(
                        AppStrings.saveChanges.tr,
                        style: resetPasswordProvider.getBtnTxtStyle(),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
