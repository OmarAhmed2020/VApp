import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../provider/add_symptoms_provider.dart';
import '../../../r.dart';
import '../../localization/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_txt_styles.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/bottomSheet/add_medicines_photo.dart';
import '../widgets/common_widgets.dart';
import '../widgets/custom_shawdow_textfield.dart';

class AddSymptomsScreen extends StatelessWidget {
  const AddSymptomsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> symptomsList = ["Type1", "Type2", "Type3"];

    var date=DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var formattedTime="${dateParse.hour}:${dateParse.minute}";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBarWidgetWithTitle(AppStrings.addSymptoms.tr, () {
        Get.back();
      }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(TextSpan(text: '', children: <InlineSpan>[
                  TextSpan(
                    text: AppStrings.selectTheType.tr,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16.sp, fontWeight: FontWeight.w400),
                  ),
                    TextSpan(text: ' *',style: TextStyle(color: Colors.red,fontSize: 17),),


                ]
                )
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                        color: AppColors.colorECECEC,
                        width: 1 // red as border color
                        ),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      items: symptomsList
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: AppTxtStyles.getAppRegularFont(
                                      size: 14, fontWeight: FontWeight.w400),
                                ),
                              ))
                          .toList(),
                      value: symptomsList[0],
                      onChanged: (value) {},
                      buttonHeight: 50,
                      buttonWidth: 150,
                      itemHeight: 50,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(text: '', children: <InlineSpan>[
                          TextSpan(
                            text: AppStrings.date.tr,
                            style: AppTxtStyles.getAppRegularFont(
                                size: 16.sp, fontWeight: FontWeight.w400),
                          ),
                        ])),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40.h,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: AppColors.colorECECEC,
                                width: 1 // red as border color
                                ),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1.2,
                                  offset: Offset(0.0, 0.0)),
                            ],
                            color: Colors.white,
                          ),
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(formattedDate.toString()),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(text: '', children: <InlineSpan>[
                          TextSpan(
                            text: AppStrings.time.tr,
                            style: AppTxtStyles.getAppRegularFont(
                                size: 16.sp, fontWeight: FontWeight.w400),
                          ),
                        ])),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40.h,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: AppColors.colorECECEC,
                                width: 1 // red as border color
                                ),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1.2,
                                  offset: Offset(0.0, 0.0)),
                            ],
                            color: Colors.white,
                          ),
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(formattedTime.toString()),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 110,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.colorECECEC,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          color: Colors.white),
                      child: InkWell(
                        onTap: () {
                          ImagePickerWidget().addPhotoBottomSheet(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(R.assetsIconsCamera),
                            const Visibility(
                                child: SizedBox(
                              height: 10,
                            )),
                            Visibility(
                                child: Text(
                              AppStrings.takePhotoOrChoose.tr,
                              textAlign: TextAlign.center,
                              style: AppTxtStyles.getAppRegularFont(
                                  size: 12, fontWeight: FontWeight.normal),
                            )),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 110,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.colorECECEC,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          color: Colors.white),
                      child: InkWell(
                        onTap: () {
                          ImagePickerWidget().addPhotoBottomSheet(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(R.assetsIconsRecording),
                            const Visibility(
                                child: SizedBox(
                              height: 10,
                            )),
                            Visibility(
                                child: Text(
                              AppStrings.recordingAudio.tr,
                              textAlign: TextAlign.center,
                              style: AppTxtStyles.getAppRegularFont(
                                  size: 12, fontWeight: FontWeight.normal),
                            )),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                CustomShadowFormTextField(
                  showStickyLabel: true,
                  labelText: AppStrings.symptomDescription.tr,
                  stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                      size: 15, fontWeight: FontWeight.w700),

                  maxLines: 5,
                  isEditable: true,
                  worksAsPopup: false,
                  hintText: AppStrings.symptomDescription.tr,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppStrings.required.tr;
                    }
                    return null;
                  },
                  onValueChanged: (value) {},
                  onSaved: (String? value) {},
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(AppStrings.selectSeverity.tr,style: AppTxtStyles.getAppRegularFont(
                    size: 18.sp, fontWeight: FontWeight.normal),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.colore7fce6,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        width: 80.w,
                        height: 32.h,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child:
                              Checkbox(
                                  value: true,
                                  shape: CircleBorder(),
                                  splashRadius: 20,
                                  onChanged: (value){
                                    print(value);
                                  }),
                            ),
                            Text(AppStrings.mild.tr),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.colorfffae6,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        width: 100.w,
                        height: 32.h,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: Checkbox(
                                  value: false,
                                  shape: CircleBorder(),
                                  splashRadius: 20,
                                  onChanged: (value){
                                    print(value);

                                  }),
                            ),
                            Text(AppStrings.moderate.tr),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.colorffeae8,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        width: 100.w,
                        height: 32.h,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: Checkbox(
                                  value: false,
                                  shape: CircleBorder(),
                                  splashRadius: 20,
                                  onChanged: (value){
                                    print(value);

                                  }),
                            ),
                            Text(AppStrings.severe.tr),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                const Divider(
                  thickness: 1,
                  color: AppColors.colorECECEC,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment:Alignment.center,
                    child: defaultButton(
                        txtColor: Colors.white,
                        borderColor: Colors.white,
                        width: double.infinity,
                        function: () {

                        },
                        text: (AppStrings.addSymptoms.tr),
                        height: 45.h,
                        radius: 10,
                        fontSize: 17.sp),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
