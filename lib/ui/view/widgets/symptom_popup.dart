import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../r.dart';
import '../../localization/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_txt_styles.dart';

void addSymtomPopup(ctx) {
  var date = DateTime.now().toString();
  var dateParse = DateTime.parse(date);
  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

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
        height: 420.h,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(AppStrings.symptom.tr,style: AppTxtStyles.getAppRegularFont(
                        size: 18.sp, fontWeight: FontWeight.w700),),
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
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.add,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16.sp, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    " : ${getCurrentDateTimeSrt(DateTime.now())} / ${formattedDate}",
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16.sp, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      height: 42.h,
                      width: 42.w,
                      child: Image.asset(R.assetsImagesMedicineSamplePNG),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "George Mat",
                          style: AppTxtStyles.getAppRegularFont(
                              size: 16.sp, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Son",
                          style: AppTxtStyles.getAppRegularFont(
                              size: 14.sp, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: 60.w,
                    height: 60.h,
                    child: SvgPicture.asset(
                      R.assetsIconsCare,
                      height: 50.h,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: AppColors.colorECECEC,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                            alertBorder: Border.all(
                                width: 1.0, color: Colors.transparent))),
                        content: Container(
                            height: 400.h,
                            width: 300.w,
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
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            width: 1.0, color: AppColors.colorECECEC)),
                    height: 100.h,
                    width: 100.w,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.play_circle),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppStrings.playAudio.tr,
                              style: AppTxtStyles.getAppRegularFont(
                                  size: 12.sp, fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: AppColors.colorECECEC,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.colorfffae6,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  width: 140.w,
                  height: 30.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.severity.tr + " : ",
                        style: AppTxtStyles.getAppRegularFont(
                            size: 14.sp, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        AppStrings.moderate.tr,
                        style: AppTxtStyles.getAppRegularFont(
                            size: 16.sp, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppStrings.type + " :" + "Skin rush",
                  style: AppTxtStyles.getAppRegularFont(
                      size: 16.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: AppColors.colorECECEC,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "Red itchy spots started to appear at the back of my neck",
                textAlign: TextAlign.start,
                style: AppTxtStyles.getAppRegularFont(
                    size: 16.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
      buttons: []).show();
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
