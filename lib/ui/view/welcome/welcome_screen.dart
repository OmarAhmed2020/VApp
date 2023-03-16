import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import '../../../r.dart';
import '../../localization/locale_controller.dart';
import '../../theme/app_txt_styles.dart';
import '../widgets/common_widgets.dart';
import 'on_boarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  bool isEnglish = (Get.locale == const Locale("en") ? true : false);

  @override
  Widget build(BuildContext context) {
    LocaleController localeController = Get.find();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Center(
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250.h,
                child: SvgPicture.asset(
                  R.assetsIconsLogo,
                  width: 200.w,
                ),
              ),
              Text(
                AppStrings.helloAndWelcomeHere.tr,
                style: AppTxtStyles.getAppRegularFont(
                    size: 26.sp, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              Container(
                  width: 300.w,
                  height: 70.h,
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.getAnOverView.tr,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16.sp, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: 10.h,
              ),
              defaultButton(
                  txtColor: Colors.white,
                  borderColor: Colors.white,
                  width: 150.w,
                  function: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnBoardingScreen()),
                      );
                    });
                  },
                  text: (AppStrings.letsStart.tr),
                  height: 45.h,
                  radius: 10,
                  fontSize: 17.sp),
              Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: SizedBox(
                  width: 200.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.chooseYourLanguage.tr,
                        style: AppTxtStyles.getAppRegularFont(
                            fontWeight: FontWeight.w400, size: 14.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultButton(
                                borderColor: isEnglish
                                    ? Colors.black26
                                    : AppColors.color295788,
                                width: 75.w,
                                background: Colors.white,
                                function: () {
                                  isEnglish = true;
                                  localeController.ChangeLanguage("en");
                                },
                                text: (AppStrings.english.tr),
                                height: 25.h,
                                radius: 5,
                                fontSize: 9.sp,
                                txtColor: isEnglish
                                    ? Colors.black26
                                    : AppColors.color295788),
                            SizedBox(
                              width: 50.w,
                            ),
                            defaultButton(
                                function: () {
                                  isEnglish = false;
                                  localeController.ChangeLanguage("ar");
                                },
                                borderColor: isEnglish
                                    ? AppColors.color295788
                                    : Colors.black26,
                                width: 75.w,
                                background:
                                    isEnglish ? Colors.white : Colors.white,
                                text: (AppStrings.arabic.tr),
                                height: 25.h,
                                radius: 5,
                                fontSize: 12.sp,
                                txtColor: isEnglish
                                    ? AppColors.color295788
                                    : Colors.black26),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
