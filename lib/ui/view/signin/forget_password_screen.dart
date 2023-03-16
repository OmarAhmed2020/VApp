import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import 'package:voithy/ui/theme/app_txt_styles.dart';
import 'package:voithy/ui/view/signin/change_password_screen.dart';
import 'package:voithy/ui/view/signin/verify_reset_password_screen.dart';
import 'package:voithy/ui/view/singup/signup_screen.dart';
import 'package:voithy/ui/view/widgets/app_bar_widget.dart';
import '../../../provider/reset_password_provider.dart';
import '../../theme/app_styles.dart';
import '../widgets/common_widgets.dart';
import '../widgets/custom_shawdow_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var forgotPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final resetPasswordProvider =
        Provider.of<ResetPasswordProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: AppColors.colorF6F8FC,
      appBar: getAppBarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.forgotYourPassword.tr,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 22.sp, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text(
                AppStrings.enterYourEmailAddress.tr,
                style: AppTxtStyles.getAppRegularFont(
                    size: 16.sp, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 55,
              ),
              Form(
                  key: forgotPasswordFormKey,
                  child: CustomShadowFormTextField(
                    showStickyLabel: true,
                    textEditingController: emailController,
                    labelText: AppStrings.email.tr,
                    stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                        size: 15, fontWeight: FontWeight.w700),
                    isMandatory: true,
                    maxLines: 1,
                    isEditable: true,
                    worksAsPopup: false,
                    obscureText: false,
                    hintText: AppStrings.pleaseEnterYourEmailAddress.tr,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.required.tr;
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                          .hasMatch(value)) {
                        return "${AppStrings.enterYourEmailCorrectly.tr}  'Voithy@gmail.com'";
                      }
                      return null;
                    },
                    onValueChanged: (value) {
                      if (value == null || value.isEmpty) {
                        resetPasswordProvider.isValidForm = false;
                      } else {
                        resetPasswordProvider.isValidForm = true;
                      }
                      resetPasswordProvider.email = value;
                    },
                    onSaved: (String? value) {
                      if (value == null || value.isEmpty) {
                        resetPasswordProvider.isValidForm = false;
                      } else {
                        resetPasswordProvider.isValidForm = true;
                      }
                      resetPasswordProvider.email = value;
                    },
                  )),
              const SizedBox(
                height: 55,
              ),
              TextButton(
                style: resetPasswordProvider.getBtnStyle(),
                onPressed: () {
                  if (forgotPasswordFormKey.currentState!.validate()) {
                    resetPasswordProvider
                        .requestUpdatePasswordOTP()
                        .then((response) {
                      if (response.apiStatus!) {
                        resetPasswordProvider.isValidForm = false;
                        Get.to(const VerifyResetPasswordScreen());
                      } else {
                        showSnackBar(
                            context: context,
                            msg:
                                "${AppStrings.apiError.tr}ErrorMsg: ${response.message}.");
                      }
                    });
                  }
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(AppStrings.resetPassword.tr,
                      textAlign: TextAlign.center,
                      style: resetPasswordProvider.getBtnTxtStyle()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(SignUpScreen());
                },
                child: Text.rich(TextSpan(
                    text: AppStrings.dontHaveAccount.tr,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16, fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppStrings.signUp.tr,
                        style: AppTxtStyles.getAppRegularFont(
                                size: 16, fontWeight: FontWeight.w500)
                            .copyWith(color: AppColors.color295788),
                      ),
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
