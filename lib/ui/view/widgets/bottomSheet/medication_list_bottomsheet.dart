import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/view/add_medicine/add_medicine_screens.dart';
import '../../../../r.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_txt_styles.dart';
import '../../add_dose/add_dose_screen.dart';
import '../../add_symptoms/add_symptoms_screen.dart';
import '../common_widgets.dart';

void showMedicationListButtomsheet(ctxt) {
  List<String> datelist = ["31 May 2022", "32 May 2022", "33 May 2022"];
  var date=DateTime.now().toString();
  var dateParse = DateTime.parse(date);
  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

  showModalBottomSheet(
      context: ctxt,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 480,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )),
            child: Column(

              children: [

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Container(
                          height: 4.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Text(""),
                        ),
                      ),
                      SizedBox(width: 110.w),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              child: SvgPicture.asset(
                                R.assetsIconsClose,
                                height: 22.h,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                   SizedBox(height: 15,),

                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.filter.tr,
                        style: AppTxtStyles.getAppRegularFont(
                            size: 18.sp, fontWeight: FontWeight.w700,),
                      ),
                      Text(
                        AppStrings.resetFilters.tr,
                        style: AppTxtStyles.getAppRegularFont(
                            size: 18.sp, fontWeight: FontWeight.w700).copyWith(color: AppColors.color295788),
                      ),

                    ],
                  ),

                const Divider(
                  thickness: 1,
                  color: AppColors.colorECECEC,
                ),
                Container(
               height: 28.h,
               child: Align(

                 alignment: Alignment.topLeft,
                   child: Text(AppStrings.startDate.tr,style: AppTxtStyles.getAppRegularFont(
                       size: 16.sp, fontWeight: FontWeight.w400),
                   )),
             ),
                Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                          color: AppColors.colorECECEC, width: 1 // red as border color
                      ),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1.2,
                            offset: Offset(0.0, 0.0)),
                      ],
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: datelist
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: AppTxtStyles.getAppRegularFont(
                                size: 14, fontWeight: FontWeight.w400),
                          ),
                        ))
                            .toList(),
                        value: datelist[0],
                        onChanged: (value) {},
                        buttonHeight: 50,
                        buttonWidth: 150,
                        itemHeight: 50,
                      ),
                    ),
                  ),
                const Divider(
                  thickness: 1,
                  color: AppColors.colorECECEC,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.suspend.tr,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    Checkbox(
                        value: true,
                        splashRadius: 20,
                        onChanged: (value){
                          print(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.active.tr,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    Checkbox(
                        value: true,
                        splashRadius: 20,
                        onChanged: (value){
                          print(value);
                        }),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: AppColors.colorECECEC,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.outOfStock.tr,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    Checkbox(
                        value: true,
                        splashRadius: 20,
                        onChanged: (value){
                          print(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.available.tr,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    Checkbox(
                        value: true,
                        splashRadius: 20,
                        onChanged: (value){
                          print(value);
                        }),
                  ],
                ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 8),
            child: defaultButton(
                txtColor: AppColors.color295788,
                borderColor: AppColors.color295788,
                width: double.infinity,
                function: () {

                },
                text: (AppStrings.apply.tr),
                height: 45.h,
                radius: 10,
                fontSize: 18.sp,
                background:Colors.white),
          ),



        ],
            ),

          ),
        );
      });
}
