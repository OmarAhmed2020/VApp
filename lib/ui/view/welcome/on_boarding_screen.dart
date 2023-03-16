import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import 'package:voithy/ui/theme/app_txt_styles.dart';
import 'package:voithy/ui/view/signin/signin_screen.dart';
import 'package:voithy/ui/view/singup/signup_screen.dart';
import '../../../r.dart';
import '../../theme/app_styles.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() {
    return _OnBoardingScreenState();
  }
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            IntroductionScreen(
                globalBackgroundColor: Colors.white,
                pages: [
                  PageViewModel(
                    title: "",
                    bodyWidget: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      R.assetsImagesOnBoardingBg1,
                                      height: 300.h,
                                      width: 300.w,
                                      fit: BoxFit.cover,
                                      color: Colors.white.withOpacity(0.5),
                                      colorBlendMode: BlendMode.modulate,
                                    ),
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white.withOpacity(0.5),
                                        AppColors.colorECECEC.withOpacity(0.5),
                                      ],
                                    )),
                                margin:
                                    const EdgeInsets.only(left: 30, right: 30),
                                width: 400.w,
                                height: 300.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 100, right: 100),
                                child: SvgPicture.asset(R.assetsIconsLogo),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 220,
                                  left: 200,
                                ),
                                child: SvgPicture.asset(
                                  R.assetsIconsOnBoarding1Icons,
                                  height: 100,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppStrings.trackYourMedicationAndSymptoms.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 18.sp, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          AppStrings.letUsHelpYou.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 15.sp, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    footer: Column(
                      children: [
                        TextButton(
                          style: AppStyles.defaultButtonStyleWithRadius(
                              const BorderRadius.all(Radius.circular(10.0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              backgroundColor: AppColors.color295788,
                              minimumSize: const Size(20, 20)),
                          onPressed: () {
                            Get.to( SignInScreen());
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.alreadyAMember.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.w400,
                                          size: 12.sp)
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  AppStrings.signIn.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.bold,
                                          size: 14.sp)
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          style: AppStyles.defaultButtonStyleWithRadius(
                              const BorderRadius.all(Radius.circular(10.0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              backgroundColor: AppColors.color295788,
                              minimumSize: const Size(20, 20)),
                          onPressed: () {
                            Get.to( SignUpScreen());
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.dontHaveAccount.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.w400,
                                          size: 12.sp)
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  AppStrings.signUp.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.bold,
                                          size: 14.sp)
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: getPageDecoration(),
                  ),
                  PageViewModel(
                    title: "",
                    bodyWidget: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      R.assetsImagesOnBoardingBg2,
                                      height: 300.h,
                                      width: 300.w,
                                      fit: BoxFit.fitHeight,
                                      color: Colors.white.withOpacity(0.5),
                                      colorBlendMode: BlendMode.modulate,
                                    ),
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.green.withOpacity(0.2),
                                        AppColors.colorECECEC.withOpacity(0.5),
                                      ],
                                    )),
                                margin:
                                    const EdgeInsets.only(left: 30, right: 30),
                                width: 300.w,
                                height: 300.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 100, right: 100),
                                child: SvgPicture.asset(R.assetsIconsLogo),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 220,
                                  left: 200,
                                ),
                                child: SvgPicture.asset(
                                  R.assetsIconsOnBoarding2Icons,
                                  height: 100,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppStrings.neverMissADoseAgain.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 18.sp, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          AppStrings.getAnOverviewOfYourTreatment.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 15.sp, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    //image: ,
                    footer: Column(
                      children: [
                        TextButton(
                          style: AppStyles.defaultButtonStyleWithRadius(
                              const BorderRadius.all(Radius.circular(10.0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              backgroundColor: AppColors.color295788,
                              minimumSize: const Size(20, 20)),
                          onPressed: () {
                            Get.to( SignInScreen());
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.alreadyAMember.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.w400,
                                          size: 12.sp)
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  AppStrings.signIn.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.bold,
                                          size: 14.sp)
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          style: AppStyles.defaultButtonStyleWithRadius(
                              const BorderRadius.all(Radius.circular(10.0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              backgroundColor: AppColors.color295788,
                              minimumSize: const Size(20, 20)),
                          onPressed: () {
                            Get.to( SignUpScreen());
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.dontHaveAccount.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.w400,
                                          size: 12.sp)
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  AppStrings.signUp.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.bold,
                                          size: 14.sp)
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: getPageDecoration(),
                  ),
                  PageViewModel(
                    title: "",
                    bodyWidget: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      R.assetsImagesOnBoardingBg3,
                                      height: 300.h,
                                      width: 300.w,
                                      fit: BoxFit.cover,
                                      color: Colors.white.withOpacity(0.5),
                                      colorBlendMode: BlendMode.modulate,
                                    ),
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.yellow.withOpacity(0.2),
                                        AppColors.colorECECEC.withOpacity(0.5),
                                      ],
                                    )),
                                margin:
                                    const EdgeInsets.only(left: 30, right: 30),
                                width: 300.w,
                                height: 300.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 100, right: 100),
                                child: SvgPicture.asset(R.assetsIconsLogo),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 220,
                                  left: 200,
                                ),
                                child: SvgPicture.asset(
                                  R.assetsIconsOnBoarding3Icons,
                                  height: 100,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppStrings.inviteAndManageYourCareCircle.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 18.sp, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          AppStrings.inviteDependentsAndCaregivers.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 15.sp, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    //image: ,
                    footer: Column(
                      children: [
                        TextButton(
                          style: AppStyles.defaultButtonStyleWithRadius(
                              const BorderRadius.all(Radius.circular(10.0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              backgroundColor: AppColors.color295788,
                              minimumSize: const Size(20, 20)),
                          onPressed: () {
                            Get.to( SignInScreen());
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.alreadyAMember.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.w400,
                                          size: 12.sp)
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  AppStrings.signIn.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.bold,
                                          size: 14.sp)
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          style: AppStyles.defaultButtonStyleWithRadius(
                              const BorderRadius.all(Radius.circular(10.0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              backgroundColor: AppColors.color295788,
                              minimumSize: const Size(20, 20)),
                          onPressed: () {
                            Get.to( SignUpScreen());
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.dontHaveAccount.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.w400,
                                          size: 12.sp)
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  AppStrings.signUp.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                          fontWeight: FontWeight.bold,
                                          size: 14.sp)
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: getPageDecoration(),
                  ),
                ],
                next: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.color295788,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 45.h,
                  width: 45.h,
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.color295788,
                  ),
                ),
                back: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.color295788,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 45.h,
                  width: 45.h,
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.color295788,
                  ),
                ),
                dotsDecorator: getDotDecoration(),
                animationDuration: 300,
                showDoneButton: false,
                showBackButton: true,
                isProgressTap: true,
                isProgress: true,
                onChange: (index) {
                  print(index);
                  setState(() {
                    currentPageIndex = index;
                  });
                }),
            currentPageIndex == 0
                ? Align(
                    alignment: Get.locale == const Locale("ar")
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: Get.locale == const Locale("ar")
                            ?EdgeInsets.only(right: 40, bottom: 25):EdgeInsets.only(left: 40, bottom: 25),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.color295788,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 45.h,
                        width: 45.h,
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.color295788,
                        ),
                      ),
                    ),
                  )
                : (currentPageIndex == 2
                    ? Align(
                        alignment: Get.locale == const Locale("ar")
                            ? Alignment.bottomLeft
                            : Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            Get.to( SignUpScreen());
                          },
                          child: Container(
                            margin: Get.locale == const Locale("ar")?const EdgeInsets.only(left: 40, bottom: 25):const EdgeInsets.only(right: 40, bottom: 25),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.color295788,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: 45.h,
                            width: 45.h,
                            child: const Icon(
                              Icons.arrow_forward,
                              color: AppColors.color295788,
                            ),
                          ),
                        ),
                      )
                    : Container())
          ],
        ),
      ),
    );
  }

  // Built_In Function to style the page
  PageDecoration getPageDecoration() {
    return const PageDecoration(
        imageFlex: 2,
        bodyFlex: 2,
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        bodyTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        imagePadding: EdgeInsets.all(20),
        titlePadding: EdgeInsets.only(top: 10),
        bodyPadding: EdgeInsets.all(10),
        pageColor: Colors.white,
        footerPadding: EdgeInsets.symmetric(vertical: 10));
  }

// Built_In Function to style the Dots
  DotsDecorator getDotDecoration() {
    return DotsDecorator(
        color: AppColors.colorE86606.withOpacity(0.5),
        size: const Size(6, 6),
        activeSize: const Size(10, 10),
        activeColor: AppColors.colorE86606,
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)));
  }
}
