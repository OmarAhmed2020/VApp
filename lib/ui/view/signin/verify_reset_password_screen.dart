import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import 'package:voithy/ui/theme/app_txt_styles.dart';
import 'package:voithy/ui/view/signin/change_password_screen.dart';
import 'package:voithy/ui/view/signin/signin_screen.dart';
import 'package:voithy/ui/view/widgets/app_bar_widget.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import '../../../provider/reset_password_provider.dart';
import '../../../provider/signup_provider.dart';
import '../widgets/common_widgets.dart';

class VerifyResetPasswordScreen extends StatelessWidget {
  const VerifyResetPasswordScreen({Key? key}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.verifyAccountH.tr,
                textAlign: TextAlign.start,
                style: AppTxtStyles.getAppRegularFont(
                  size: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${AppStrings.verifyAccountBody.tr} ${resetPasswordProvider.email}",
                  style: AppTxtStyles.getAppRegularFont(
                      size: 18.sp, fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Directionality(textDirection: TextDirection.ltr, child: PinCodeFields(
                length: 4,
                fieldBorderStyle: FieldBorderStyle.square,
                responsive: false,
                fieldHeight: 50.0,
                fieldWidth: 40.0,
                borderWidth: 2.0,
                activeBorderColor: Colors.black12,
                activeBackgroundColor: Colors.white,
                borderRadius: BorderRadius.circular(7.0),
                keyboardType: TextInputType.number,
                autoHideKeyboard: false,
                obscureText: false,
                fieldBackgroundColor: Colors.white,
                borderColor: Colors.black12,
                textStyle: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                onComplete: (output) {
                  if (output.length == 4) {
                    resetPasswordProvider.isValidForm = true;
                  } else {
                    resetPasswordProvider.isValidForm = false;
                  }
                  resetPasswordProvider.userOTP = output;
                },
              )),
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.resendCode.tr,
                        style: AppTxtStyles.getAppRegularFont(
                            size: 16.sp, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CountdownTimer(
                        endTime:
                            DateTime.now().millisecondsSinceEpoch + 1000 * 240,
                        widgetBuilder: (_, CurrentRemainingTime? time) {
                          if (time == null) {
                            return Directionality(textDirection: TextDirection.ltr, child: Text(
                              '00:00',
                              style: AppTxtStyles.getAppRegularFont(
                                  size: 16, fontWeight: FontWeight.w700),
                            ));;
                          }
                          return Directionality(textDirection: TextDirection.ltr, child: Text(
                            time.min != null
                                ? '${time.min} : ${time.sec}'
                                : '00 : ${time.sec}',
                            style: AppTxtStyles.getAppRegularFont(
                                size: 16, fontWeight: FontWeight.w700),
                          ));
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 70,
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    resetPasswordProvider
                        .requestResetPasswordResendOtp()
                        .then((response) {
                      if (response.apiStatus!) {
                        showSnackBar(
                            context: context,
                            msg: AppStrings.otpSentSuccessfully);
                      } else {
                        showSnackBar(context: context, msg: AppStrings.somethingWentWrong.tr);
                      }
                    });
                  },
                  child: Text.rich(TextSpan(
                      text: AppStrings.didnotReceiveCode.tr,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16.sp, fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: AppStrings.requestAgain.tr,
                          style: AppTxtStyles.getAppRegularFont(
                                  size: 16.sp, fontWeight: FontWeight.w500)
                              .copyWith(color: AppColors.color295788),
                        ),
                      ])),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                style: resetPasswordProvider.getBtnStyle(),
                onPressed: () {
                  resetPasswordProvider
                      .validateResetPasswordOtp()
                      .then((response) {
                    if (response.apiStatus!) {
                      resetPasswordProvider.isValidForm = false;
                      Get.to(const ChangePasswordScreen());
                    } else {
                      showSnackBar(
                          context: context, msg: AppStrings.wrongOTP.tr);
                    }
                  });
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(AppStrings.verifyResetPassword.tr,
                      textAlign: TextAlign.center,
                      style: resetPasswordProvider.getBtnTxtStyle()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
