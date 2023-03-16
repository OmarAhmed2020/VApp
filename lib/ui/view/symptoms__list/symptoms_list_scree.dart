import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:textfield_search/textfield_search.dart';
import '../../../r.dart';
import '../../localization/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_txt_styles.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/bottomSheet/add_medicine_buttom_sheet.dart';
import '../widgets/bottomSheet/medication_list_bottomsheet.dart';
import '../widgets/bottomSheet/symptoms_list_bottomsheet.dart';
import '../widgets/symptom_popup.dart';

class SymptomsList extends StatelessWidget {
  const SymptomsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const label = "Search";
    const dummyList = ['Symptom1 ', 'Symptom2','Symptom3'];
    var date=DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var formattedTime="${dateParse.hour}:${dateParse.minute}";
    TextEditingController myController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBarWidgetWithTitle(AppStrings.symptomsList.tr, (){
        Get.back();
      }),
      body: SafeArea(
        child:
        Column(
          children: [
            const Divider(
              thickness: 1,
              color: AppColors.colorECECEC,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Container(
                          width: 150.w,
                          height: 30.h,
                          child: TextFieldSearch(initialList: dummyList,label: label, controller: myController,textStyle: const TextStyle(
                            fontSize: 15.0,
                          ),decoration:
                          InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: AppColors.color295788,
                              size: 20,
                            ),border: InputBorder.none,hintText: AppStrings.search.tr,

                          ),)),
                    ],
                  ),
                ),

                Expanded(
                  child: InkWell(
                    onTap: (){
                      showSymptomsListButtomsheet(context);
                    },
                    child: Row(
                      children:  [
                        const Icon(
                          Icons.filter_list_outlined,
                          color: AppColors.color295788,
                          size: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text(AppStrings.filter.tr),
                        ),

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

            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context,index){
                    return
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 200.h,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: AppColors.colorECECEC,
                                width: 1 // red as border color
                            ),),

                          child:InkWell(
                            onTap: (){

                              addSymtomPopup(context);

                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: SvgPicture.asset(
                                        R.assetsIconsAddSymptoms,
                                        height: 25.h,
                                    ),
                                      ),
                                        Text(AppStrings.symptom.tr,style:AppTxtStyles.getAppRegularFont(
                                            size: 16.sp, fontWeight: FontWeight.w400),),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Text(
                                            "${getCurrentDateTimeSrt(DateTime.now())} / ${formattedDate}",
                                            style: AppTxtStyles.getAppRegularFont(
                                                size: 16.sp, fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                    ],
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: AppColors.colorECECEC,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      children: [
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
                                                    Text(AppStrings.severity.tr+" : "
                                                    ,style: AppTxtStyles.getAppRegularFont(
                                                          size: 14.sp, fontWeight: FontWeight.w700),
                                                    ),
                                                    Text(AppStrings.moderate.tr,
                                                      style: AppTxtStyles.getAppRegularFont(
                                                          size: 16.sp, fontWeight: FontWeight.w700),),
                                                  ],
                                                ),
                                              ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 6),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: AppColors.colorfffae6,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                width: 30.w,
                                                height: 30.h,
                                               child:   SvgPicture.asset(
                                                 R.assetsIconsImage,
                                                 height: 25.h,
                                               ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 6),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: AppColors.colorfffae6,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                width: 30.w,
                                                height: 30.h,
                                                child:   SvgPicture.asset(
                                                  R.assetsIconsRecording,
                                                  height: 25.h,
                                                ),
                                              ),
                                            ),
                                           SizedBox(width: 20,),
                                           Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                width: 60.w,
                                                height: 60.h,
                                                child:   SvgPicture.asset(
                                                  R.assetsIconsCare,
                                                  height: 40.h,
                                                ),
                                              ),

                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(AppStrings.type +" :"+ "Skin rush",style: AppTxtStyles.getAppRegularFont(
                                            size: 16.sp, fontWeight: FontWeight.w700),
                                        ),
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Text("Red itchy spots started to appear at the back of my neck",textAlign: TextAlign.start,
                                            style: AppTxtStyles.getAppRegularFont(
                                                size: 16.sp, fontWeight: FontWeight.w400),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),),
                      );
                  }),
            ),
          ],
        ),
      ),
    );
  }
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