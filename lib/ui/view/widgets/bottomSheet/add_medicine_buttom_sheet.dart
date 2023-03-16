import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/view/add_medicine/add_medicine_screens.dart';

import '../../../../r.dart';
import '../../../theme/app_colors.dart';
import '../../add_dose/add_dose_screen.dart';
import '../../add_symptoms/add_symptoms_screen.dart';

void showAddMedicineBottomSheet(ctxt) {
  showModalBottomSheet(
      context: ctxt,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) {
        return Container(
          height: 250.h,
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
              InkWell(
                onTap: () {
                  Get.to(AddMedicineScreen());
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    R.assetsIconsAddMedicine,
                    height: 20.h,
                  ),
                  title: Text(AppStrings.addMedicine.tr),
                ),
              ),
              const Divider(thickness: 0.1,color: AppColors.color8f8f8f,),
              InkWell(
                onTap: () {
                  Get.to(AddSymptomsScreen());

                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    R.assetsIconsAddSymptoms,
                    height: 20.h,
                  ),
                  title: Text(AppStrings.addSymptoms.tr),
                ),
              ),
              const Divider(thickness: 0.1,color: AppColors.color8f8f8f,),
              InkWell(
                onTap: () {
                  Get.to(const AddDose());
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    R.assetsIconsBxCapsule,
                    height: 20.h,
                  ),
                  title: Text(AppStrings.addDose.tr),
                ),
              ),
            ],
          ),
        );
      });
}
