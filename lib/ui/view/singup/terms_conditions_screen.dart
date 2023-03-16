import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import 'package:voithy/ui/theme/app_txt_styles.dart';
import 'package:voithy/ui/view/widgets/app_bar_widget.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                AppStrings.termsConditions.tr,
                textAlign: TextAlign.start,
                style: AppTxtStyles.getAppRegularFont(
                    size: 18.sp, fontWeight: FontWeight.w700,),
              ),
              const SizedBox(height: 20,),
              Text(
                AppStrings.termsConditionsH1.tr,
                style: AppTxtStyles.getAppRegularFont(
                    size: 16.sp, fontWeight: FontWeight.w700),
              ),
              Text(
                AppStrings.termsConditionsBody1.tr,
                style: AppTxtStyles.getAppRegularFont(
                    size: 16.sp, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 20,),
              Text(
                AppStrings.termsConditionsH2.tr,
                style: AppTxtStyles.getAppRegularFont(
                    size: 16.sp, fontWeight: FontWeight.w700),
              ),
              Text(
                AppStrings.termsConditionsBody2.tr,
                style: AppTxtStyles.getAppRegularFont(
                    size: 16.sp, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 20,),
              Text(
                AppStrings.termsConditionsH3.tr,
                style: AppTxtStyles.getAppRegularFont(
                    size: 16.sp, fontWeight: FontWeight.w700),
              ),
              Text(
                AppStrings.termsConditionsBody3.tr,
                style: AppTxtStyles.getAppRegularFont(
                    size: 16.sp, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
