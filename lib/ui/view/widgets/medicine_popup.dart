import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../r.dart';
import '../../localization/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_txt_styles.dart';

void addMedicinePopup(ctx) {
  Alert(
      style: (AlertStyle(
        alertPadding: EdgeInsets.all(0),
        buttonAreaPadding: EdgeInsets.zero,
      )),
      closeIcon: Container(
        color: Colors.white,
      ),
      context: ctx,
      content: Container(
        height: 300.h,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(AppStrings.intakeDetails.tr),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      R.assetsIconsEdit,
                      height: 20.h,
                      width: 25.w,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      R.assetsIconsDelete,
                      height: 20.h,
                      width: 25.w,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(
                        R.assetsIconsClose,
                        height: 20.h,
                        width: 25.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Container(
                height: 50,
                color: AppColors.colorffeae8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      R.assetsIconsAddMedicine,
                      height: 22.h,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      AppStrings.scheduledFor.tr,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 14.sp, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${getCurrentDateTimeSrt(DateTime.now())} ' +
                          AppStrings.today.tr,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 14.sp, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: AppColors.colorECECEC,
            ),
            InkWell(
              onTap: () {
                Alert(
                    closeIcon: SvgPicture.asset(
                      R.assetsIconsCloseimage,
                      color: Colors.white,
                      width: 25.w,
                    ),
                    context: ctx,
                    style: (AlertStyle(
                        backgroundColor: Colors.transparent,
                        alertPadding: EdgeInsets.all(0),
                        alertBorder:
                            Border.all(width: 1.0, color: Colors.transparent))),
                    content: Container(
                        height: 400.h,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Image.asset(
                            R.assetsImagesMedicineSamplePNG,
                            fit: BoxFit.cover,
                          ),
                        )),
                    buttons: []).show();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                height: 100.h,
                width: 100.w,
                child: Image.asset(R.assetsImagesMedicineSamplePNG),
              ),
            ),
            const Divider(
              thickness: 1,
              color: AppColors.colorECECEC,
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text(
                      "Thyrox",
                      style: AppTxtStyles.getAppRegularFont(
                        size: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: 60.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: AppColors.colorececec,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("3",
                            style: AppTxtStyles.getAppRegularFont(
                              size: 14.sp,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(
                          width: 3,
                        ),
                        Text("mg",
                            style: AppTxtStyles.getAppRegularFont(
                              size: 14.sp,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: AppColors.colorECECEC,
            ),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          color: Colors.white,
          onPressed: () {},
          child: Container(
            width: 32.w,
            height: 32.h,
            child: SvgPicture.asset(
              R.assetsIconsReScheduled,
            ),
          ),
        ),
        DialogButton(
          color: Colors.white,
          onPressed: () {},
          child: Container(
            width: 32.w,
            height: 32.h,
            child: SvgPicture.asset(R.assetsIconsTaken),
          ),
        ),
        DialogButton(
          color: Colors.white,
          onPressed: () {},
          child: Container(
            width: 32.w,
            height: 32.h,
            child: SvgPicture.asset(R.assetsIconsSkipped),
          ),
        )
      ]).show();
}

String getCurrentDateTimeSrt(DateTime dateTime) {
  if (dateTime.hour > 12) {
    if (dateTime.hour - 12 < 10) {
      if (dateTime.minute < 10) {
        return "0${dateTime.hour - 12} : 0${dateTime.minute} PM";
      } else {
        return "0${dateTime.hour - 12} : ${dateTime.minute} PM";
      }
    } else {
      if (dateTime.minute < 10) {
        return "${dateTime.hour - 12} : 0${dateTime.minute} PM";
      } else {
        return "${dateTime.hour - 12} : ${dateTime.minute} PM";
      }
    }
  } else {
    if (dateTime.hour < 10) {
      if (dateTime.minute < 10) {
        return "0${dateTime.hour} : 0${dateTime.minute} AM";
      } else {
        return "0${dateTime.hour} : ${dateTime.minute} AM";
      }
    } else {
      if (dateTime.minute < 10) {
        return "${dateTime.hour} : 0${dateTime.minute} AM";
      } else {
        return "${dateTime.hour} : ${dateTime.minute} AM";
      }
    }
  }
}
