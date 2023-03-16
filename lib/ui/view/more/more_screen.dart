import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:textfield_search/textfield_search.dart';
import '../../localization/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_txt_styles.dart';
import '../medication_list/medication_list_screen.dart';
import '../symptoms__list/symptoms_list_scree.dart';
import '../widgets/app_bar_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBarWidgetWithTitle(AppStrings.more.tr, (){
        Get.back();
      }),
      body: SafeArea(
        child:
        Column(
         children: [

           InkWell(
             onTap: (){

               Get.to(const MedicationList());
             },
             child: Padding(
               padding: const EdgeInsets.all(12.0),
               child:
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Text(
                     AppStrings.medicationList.tr,
                     style: AppTxtStyles.getAppRegularFont(
                         size: 16.sp, fontWeight: FontWeight.w400),
                   ),
                   const Padding(
                     padding: EdgeInsets.symmetric(horizontal: 10),
                     child: Icon(
                       Icons.arrow_forward_ios,
                       size: 15,
                     ),
                   ),
                 ],
               ),
             ),
           ),
           SizedBox(
             height: 20.h,
           ),
           InkWell(
             onTap: (){

               Get.to(const SymptomsList());
             },
             child: Padding(
               padding: const EdgeInsets.all(12.0),
               child:
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Text(
                     AppStrings.symptomsList.tr,
                     style: AppTxtStyles.getAppRegularFont(
                         size: 16.sp, fontWeight: FontWeight.w400),
                   ),
                   const Padding(
                     padding: EdgeInsets.symmetric(horizontal: 10),
                     child: Icon(
                       Icons.arrow_forward_ios,
                       size: 15,
                     ),
                   ),
                 ],
               ),
             ),
           ),
           SizedBox(
             height: 20.h,
           ),

         ],

        ),
      ),
    );
  }
}