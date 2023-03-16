import 'dart:io';
import 'dart:ui';
import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:voithy/provider/add_medicine_provider.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import 'package:voithy/ui/theme/app_txt_styles.dart';
import 'package:voithy/ui/view/widgets/app_bar_widget.dart';
import '../../../model/does_time_model.dart';
import '../../../model/week_day_model.dart';
import '../../../r.dart';
import '../home/home_screen.dart';
import '../widgets/bottomSheet/add_medicines_photo.dart';
import '../widgets/common_widgets.dart';
import '../widgets/custom_shawdow_textfield.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AddMedicineScreen extends StatefulWidget {
  AddMedicineScreen({Key? key}) : super(key: key);

  @override
  _AddMedicineScreen createState() {
    return _AddMedicineScreen();
  }
}

class _AddMedicineScreen extends State<AddMedicineScreen> {
  List<String> soundList = ["Ding-Dong", "Tone", "Booming"];
  List<String> unitsList = [
    AppStrings.selection.tr,
    AppStrings.ml.tr,
    AppStrings.mg.tr,
    AppStrings.g.tr
  ];
  final LoopPageController pagesController = LoopPageController();
  List<String> doesList = [
    AppStrings.selection.tr,
    AppStrings.oneTime.tr,
    AppStrings.twoTime.tr,
    AppStrings.threeTime.tr,
    AppStrings.fourTime.tr,
  ];

  @override
  Widget build(BuildContext context) {
    final addMedicineProvider =
        Provider.of<AddMedicineProvider>(context, listen: true);
    double windowPhysicalHeight = window.physicalSize.height;
    return WillPopScope(
      child: Scaffold(
          backgroundColor: AppColors.colorFAFAFA,
          appBar: getAppBarWidgetWithTitle(AppStrings.addMedicine.tr, () {
            addMedicineProvider.disposeData();
            Get.back();
          }),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      height: windowPhysicalHeight > 1500
                          ? ((Get.height / 5) * 3.3).h
                          : ((Get.height / 5) * 4).h,
                      width: Get.width.w,
                      child: LoopPageView.builder(
                        itemCount: 4,
                        controller: pagesController,
                        onPageChanged: (index) {
                          addMedicineProvider.currentPageIndex = index;
                        },
                        itemBuilder: (_, index) {
                          switch (addMedicineProvider.currentPageIndex) {
                            case 0:
                              return getPage1(context, addMedicineProvider);
                            case 1:
                              return getPage2(context, addMedicineProvider);
                            case 2:
                              return getPage3(context, addMedicineProvider);
                            case 3:
                              return getPage4(context, addMedicineProvider);
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (addMedicineProvider.currentPageIndex != 0)
                          getBackBtn(addMedicineProvider),
                        if (addMedicineProvider.currentPageIndex == 0)
                          SizedBox(
                            height: 40.h,
                            width: 80.w,
                          ),
                        getDotDecoration(addMedicineProvider.currentPageIndex),
                        if (addMedicineProvider.currentPageIndex != 3)
                          getNextBtn(context, addMedicineProvider),
                        if (addMedicineProvider.currentPageIndex == 3)
                          SizedBox(
                            height: 40.h,
                            width: 80.w,
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget getPage1(
      BuildContext context, AddMedicineProvider addMedicineProvider) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.colorECECEC,
                  style: BorderStyle.solid,
                  width: 2,
                ),
                color: Colors.white),
            padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: addMedicineProvider.imageFile == null ? 20 : 10),
            child: InkWell(
              onTap: () {
                ImagePickerWidget().addPhotoBottomSheet(context);
              },
              child: Column(
                children: [
                  addMedicineProvider.imageFile == null
                      ? SvgPicture.asset(R.assetsIconsCamera)
                      : Image.file(
                          File(addMedicineProvider.imageFile!.path),
                          width: 80,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                  Visibility(
                      visible:
                          addMedicineProvider.imageFile == null ? true : false,
                      child: const SizedBox(
                        height: 10,
                      )),
                  Visibility(
                      visible:
                          addMedicineProvider.imageFile == null ? true : false,
                      child: Text(
                        AppStrings.takePhotoOrChoose.tr,
                        textAlign: TextAlign.center,
                        style: AppTxtStyles.getAppRegularFont(
                            size: 10, fontWeight: FontWeight.normal),
                      )),
                ],
              ),
            )),
      ),
      const SizedBox(height: 15),
      CustomShadowFormTextField(
        showStickyLabel: true,
        labelText: AppStrings.medicineName.tr,
        stickyLabelStyle: AppTxtStyles.getAppRegularFont(
            size: 14.sp, fontWeight: FontWeight.w700),
        isMandatory: true,
        maxLines: 1,
        initialValue: addMedicineProvider.medicineName,
        isEditable: true,
        worksAsPopup: false,
        obscureText: false,
        hintText: AppStrings.medicineName.tr,
        hintStyle: AppTxtStyles.getAppRegularFont(
                size: 14, fontWeight: FontWeight.normal)
            .copyWith(color: AppColors.color565656),
        validator: (String? value) {
          if (value == null || value.trim().isEmpty) {
            return AppStrings.required.tr;
          }
          return null;
        },
        onValueChanged: (value) {
          addMedicineProvider.medicineName = value;
        },
        onSaved: (String? value) {
          addMedicineProvider.medicineName = value;
        },
      ),
      const SizedBox(height: 15),
      Row(
        children: [
          Expanded(
            child: CustomShadowFormTextField(
              showStickyLabel: true,
              labelText: AppStrings.strength.tr,
              stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                  size: 14.sp, fontWeight: FontWeight.normal),
              isMandatory: false,
              maxLines: 1,
              isEditable: true,
              worksAsPopup: false,
              obscureText: false,
              keyboardType: TextInputType.number,
              hintText: AppStrings.strength.tr,
              hintStyle: AppTxtStyles.getAppRegularFont(
                      size: 14, fontWeight: FontWeight.normal)
                  .copyWith(color: AppColors.color565656),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return AppStrings.required.tr;
                }
                return null;
              },
              onValueChanged: (value) {
                addMedicineProvider.strength = value as String;
              },
              onSaved: (String? value) {},
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(text: '', children: <InlineSpan>[
                TextSpan(
                  text: AppStrings.unit.tr,
                  style: AppTxtStyles.getAppRegularFont(
                      size: 13.sp, fontWeight: FontWeight.w400),
                ),
              ])),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    items: unitsList
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: AppTxtStyles.getAppRegularFont(
                                    size: 14, fontWeight: FontWeight.w400),
                              ),
                            ))
                        .toList(),
                    value: addMedicineProvider.unit?.tr,
                    onChanged: (value) {
                      addMedicineProvider.unit = value as String;
                    },
                    buttonHeight: 50,
                    buttonWidth: 150,
                    itemHeight: 50,
                  ),
                ),
              )
            ],
          )),
        ],
      ),
      const SizedBox(
        height: 20,
      )
    ]);
  }

  Widget getPage2(
      BuildContext context, AddMedicineProvider addMedicineProvider) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(text: '', children: <InlineSpan>[
            TextSpan(
              text: AppStrings.frequency.tr,
              style: AppTxtStyles.getAppRegularFont(
                  size: 16.sp, fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: " *",
              style: AppTxtStyles.getAppRegularFont(
                      size: 16.sp, fontWeight: FontWeight.w400)
                  .copyWith(color: Colors.red),
            )
          ])),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: Get.width,
            height: 45.h,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
            child: InkWell(
              onTap: () {
                selectFrequencyBottomSheet(addMedicineProvider, context);
              },
              child: Text(
                addMedicineProvider.frequencySelectionStr.tr,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Visibility(
            visible: addMedicineProvider.frequencySelectionStr ==
                    AppStrings.daysInterval.tr
                ? true
                : false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                AppStrings.everyHowManyDays.tr,
                style: AppTxtStyles.getAppRegularFont(
                    size: 16.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Visibility(
            visible: addMedicineProvider.frequencySelectionStr ==
                    AppStrings.daysInterval.tr
                ? true
                : false,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      addMedicineProvider.daysInterval =
                          addMedicineProvider.daysInterval - 1;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                            color: Colors.black26,
                            width: 1 // red as border color
                            ),
                        color: AppColors.color295788,
                      ),
                      child: Text(
                        "-",
                        style: AppTxtStyles.getAppRegularFont(
                                size: 16, fontWeight: FontWeight.w600)
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 110.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(
                            color: Colors.black26,
                            width: 1.5 // red as border color
                            ),
                        color: Colors.white,
                      ),
                      child: Text(
                        addMedicineProvider.daysInterval.toString(),
                        style: AppTxtStyles.getAppRegularFont(
                            size: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  InkWell(
                    onTap: () {
                      addMedicineProvider.daysInterval =
                          addMedicineProvider.daysInterval + 1;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                            color: Colors.black26,
                            width: 1 // red as border color
                            ),
                        color: AppColors.color295788,
                      ),
                      child: Text(
                        "+",
                        style: AppTxtStyles.getAppRegularFont(
                                size: 14, fontWeight: FontWeight.w400)
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
              visible: addMedicineProvider.frequencySelectionStr ==
                      AppStrings.specificDays.tr
                  ? true
                  : false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                    height: Get.locale == const Locale("ar") ? 310.h : 290.h,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.colorECECEC,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            AppStrings.whichDays.tr,
                            style: AppTxtStyles.getAppRegularFont(
                                size: 16.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height:
                              Get.locale == const Locale("ar") ? 240.h : 230.h,
                          width: 580.w,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: 7,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            addMedicineProvider
                                                .weekDaysList[index].dayName,
                                            style:
                                                AppTxtStyles.getAppRegularFont(
                                                    size: 14,
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                          SizedBox(
                                            width: 140.w,
                                          ),
                                          Container(
                                            width: 20.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                border: Border.all(
                                                    color:
                                                        AppColors.color295788,
                                                    width: 4)),
                                            child: Material(
                                                child: Checkbox(
                                              activeColor:
                                                  AppColors.color295788,
                                              checkColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                              ),
                                              value: addMedicineProvider
                                                  .weekDaysList[index].selected,
                                              onChanged: (value) {
                                                WeekDay day = WeekDay();
                                                day.selected = value!;
                                                day.dayName =
                                                    addMedicineProvider
                                                        .weekDaysList[index]
                                                        .dayName;
                                                addMedicineProvider
                                                    .updateDayBySelection(
                                                        index, day);
                                              },
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (index != 6)
                                      const Divider(
                                        thickness: 0.1,
                                        color: AppColors.color8f8f8f,
                                      ),
                                  ],
                                );
                              }),
                        )
                      ],
                    )),
              )),
          const SizedBox(
            height: 10,
          ),
          Visibility(
              visible: addMedicineProvider.frequencySelectionStr !=
                      AppStrings.asNeeded.tr
                  ? true
                  : false,
              child: Text.rich(TextSpan(text: '', children: <InlineSpan>[
                TextSpan(
                  text: AppStrings.howManyTimes.tr,
                  style: AppTxtStyles.getAppRegularFont(
                      size: 16.sp, fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text: " *",
                  style: AppTxtStyles.getAppRegularFont(
                          size: 16.sp, fontWeight: FontWeight.w400)
                      .copyWith(color: Colors.red),
                )
              ]))),
          Visibility(
              visible: addMedicineProvider.frequencySelectionStr !=
                      AppStrings.asNeeded.tr
                  ? true
                  : false,
              child: const SizedBox(
                height: 10,
              )),
          Visibility(
              visible: addMedicineProvider.frequencySelectionStr !=
                      AppStrings.asNeeded.tr
                  ? true
                  : false,
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    items: doesList
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: AppTxtStyles.getAppRegularFont(
                                    size: 14, fontWeight: FontWeight.w400),
                              ),
                            ))
                        .toList(),
                    value: addMedicineProvider.everyStr.tr,
                    onChanged: (value) {
                      addMedicineProvider.everyStr = value as String;
                    },
                    buttonHeight: 50,
                    buttonWidth: 150,
                    itemHeight: 50,
                  ),
                ),
              )),
          Visibility(
              visible: (addMedicineProvider.frequency > 0 &&
                      addMedicineProvider.frequencySelectionStr !=
                          AppStrings.asNeeded.tr)
                  ? true
                  : false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                    height: (addMedicineProvider.frequency == 4)
                        ? 200.h
                        : (addMedicineProvider.frequency == 3)
                            ? 175.h
                            : (addMedicineProvider.frequency == 2)
                                ? 120.h
                                : 110.h,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.colorECECEC,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            AppStrings.setTimeAndDose.tr,
                            style: AppTxtStyles.getAppRegularFont(
                                size: 16.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                            height: (addMedicineProvider.frequency == 4)
                                ? 130.h
                                : (addMedicineProvider.frequency == 3)
                                    ? 110.h
                                    : (addMedicineProvider.frequency == 2)
                                        ? 60.h
                                        : 30.h,
                            width: 350.w,
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: addMedicineProvider.frequency,
                                itemBuilder: (BuildContext context, int index) {
                                  DoesTime doesTime =
                                      addMedicineProvider.doesTimeList[index];
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setTimeAndDoseBottomSheet(
                                              context,
                                              addMedicineProvider,
                                              index,
                                              doesTime);
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: Text(getTimeString(
                                                    doesTime.dateTime))),
                                            SizedBox(
                                              width: 140.w,
                                            ),
                                            Text(AppStrings.take.tr),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(doesTime.doesCount
                                                  .toString()),
                                            ),
                                            Text(AppStrings.pills.tr),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (index !=
                                          addMedicineProvider.frequency - 1)
                                        const Divider(
                                          thickness: 0.1,
                                          color: AppColors.color8f8f8f,
                                        ),
                                    ],
                                  );
                                }))
                      ],
                    )),
              )),
          Visibility(
            visible: addMedicineProvider.frequency > 0 ? true : false,
            child: const Divider(
              thickness: 0.1,
              color: AppColors.color8f8f8f,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(text: '', children: <InlineSpan>[
                    TextSpan(
                      text: AppStrings.startDate.tr,
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
                      // onTap: () {
                      //   selectStartDateBottomSheet(addMedicineProvider, context)
                      //       .then((date) {
                      //     addMedicineProvider.startDateSelected = date;
                      //     if (addMedicineProvider.isDateValidStartDate ==
                      //         false) {
                      //       showSnackBar(
                      //           context: context,
                      //           msg: AppStrings.startDateInvalid.tr);
                      //     }
                      //   });
                      // },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(addMedicineProvider.startDateSelectedStr == null
                              ? AppStrings.selection.tr
                              : addMedicineProvider.startDateSelectedStr!),
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
                      text: AppStrings.endDateOptional.tr,
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
                      // onTap: () {
                      //   selectEndDateBottomSheet(addMedicineProvider, context)
                      //       .then((date) {
                      //     addMedicineProvider.endDateSelected = date;
                      //     if (addMedicineProvider.isDateValidEndDate == false) {
                      //       showSnackBar(
                      //           context: context,
                      //           msg: AppStrings.endDateBeforeStartDate.tr);
                      //     }
                      //   });
                      // },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(addMedicineProvider.endDateSelectedStr == null
                              ? AppStrings.selection.tr
                              : addMedicineProvider.endDateSelectedStr!),
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
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget getPage3(
      BuildContext context, AddMedicineProvider addMedicineProvider) {
    return
      Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.sound.tr,
              style: AppTxtStyles.getAppRegularFont(
                  size: 18, fontWeight: FontWeight.w700),
            ),
            FlutterSwitch(
                inactiveColor: AppColors.colorECECEC,
                activeColor: AppColors.colore74034,
                width: 55.w,
                height: 30.h,
                showOnOff: false,
                onToggle: (val) {
                  addMedicineProvider.sound = val;
                },
                value: addMedicineProvider.sound),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Text.rich(TextSpan(text: '', children: <InlineSpan>[
          TextSpan(
            text: AppStrings.setTheSoundOfNotification.tr,
            style: AppTxtStyles.getAppRegularFont(
                size: 16.sp, fontWeight: FontWeight.w400),
          ),
        ])),
        const SizedBox(
          height: 10,
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
              items: soundList
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 14, fontWeight: FontWeight.w400),
                        ),
                      ))
                  .toList(),
              value: soundList[0],
              onChanged: (value) {},
              buttonHeight: 50,
              buttonWidth: 150,
              itemHeight: 50,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(
            thickness: 0.5,
            color: AppColors.colorECECEC,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.vibration.tr,
              style: AppTxtStyles.getAppRegularFont(
                  size: 18, fontWeight: FontWeight.w700),
            ),
            FlutterSwitch(
                inactiveColor: AppColors.colorECECEC,
                activeColor: AppColors.colore74034,
                width: 55.w,
                height: 30.h,
                showOnOff: false,
                onToggle: (val) {
                  addMedicineProvider.vibration = val;
                },
                value: addMedicineProvider.vibration)
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Divider(
            thickness: 0.5,
            color: AppColors.colorECECEC,
          ),
        ),
        CustomShadowFormTextField(
          showStickyLabel: true,
          labelText: AppStrings.unitInStock.tr,
          stickyLabelStyle: AppTxtStyles.getAppRegularFont(
              size: 16, fontWeight: FontWeight.normal),
          isMandatory: false,
          maxLines: 1,
          isEditable: true,
          worksAsPopup: false,
          keyboardType: TextInputType.number,
          obscureText: false,
          hintText: AppStrings.example5.tr,
          hintStyle: AppTxtStyles.getAppRegularFont(
                  size: 14, fontWeight: FontWeight.normal)
              .copyWith(color: AppColors.color565656),
          validator: (String? value) {
            if (value == null || value.trim().isEmpty) {
              return AppStrings.required.tr;
            }
            return null;
          },
          onValueChanged: (value) {
            addMedicineProvider.stockPills = value;
          },
          onSaved: (String? value) {},
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          thickness: 0.5,
          color: AppColors.colorECECEC,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.refillReminder.tr,
              style: AppTxtStyles.getAppRegularFont(
                  size: 18, fontWeight: FontWeight.w700),
            ),
            FlutterSwitch(
              inactiveColor: AppColors.colorECECEC,
              activeColor: AppColors.colore74034,
              width: 55.w,
              height: 30.h,
              showOnOff: false,
              onToggle: (val) {
                addMedicineProvider.refillReminder = val;
                if (val == false) {
                  addMedicineProvider.isValidForm3 = true;
                } else {
                  addMedicineProvider.isValidForm3 = false;
                }
              },
              value: addMedicineProvider.refillReminder,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Visibility(
            visible: addMedicineProvider.refillReminder,
            child: SizedBox(
              height: 80.h,
              child: Row(
                children: [
                  Expanded(
                    child: CustomShadowFormTextField(
                      showStickyLabel: true,
                      labelText: AppStrings.reminder.tr,
                      stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                          size: 16, fontWeight: FontWeight.normal),
                      isMandatory: true,
                      maxLines: 1,
                      isEditable: true,
                      worksAsPopup: false,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      hintText: AppStrings.example5.tr,
                      hintStyle: AppTxtStyles.getAppRegularFont(
                              size: 14, fontWeight: FontWeight.normal)
                          .copyWith(color: AppColors.color565656),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppStrings.required.tr;
                        }
                        return null;
                      },
                      onValueChanged: (value) {
                        addMedicineProvider.refillReminderNote =
                            value as String;
                        if (addMedicineProvider.refillReminderNote.isNotEmpty) {
                          addMedicineProvider.isValidForm3 = true;
                        } else {
                          addMedicineProvider.isValidForm3 = false;
                        }
                      },
                      onSaved: (String? value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(text: '', children: <InlineSpan>[
                        TextSpan(
                          text: AppStrings.reminderTime.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: " *",
                          style: AppTxtStyles.getAppRegularFont(
                                  size: 16.sp, fontWeight: FontWeight.w400)
                              .copyWith(color: Colors.red),
                        )
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
                          onTap: () {
                            refillReminderBottomSheet(
                                context, addMedicineProvider);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                addMedicineProvider.refillReminderDateTime ==
                                        null
                                    ? AppStrings.selection.tr
                                    : getTimeString(addMedicineProvider
                                        .refillReminderDateTime!),
                              ),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ))
      ],
    );
  }

  Widget getPage4(
      BuildContext context, AddMedicineProvider addMedicineProvider) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.colorECECEC,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      color: Colors.white),
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          addMedicineProvider.imageFile == null ? 30 : 10,
                      vertical:
                          addMedicineProvider.imageFile == null ? 30 : 10),
                  child: InkWell(
                    onTap: () {
                      ImagePickerWidget().addPhotoBottomSheet(context);
                    },
                    child: addMedicineProvider.imageFile == null
                        ? SvgPicture.asset(
                            R.assetsIconsMedicineBox,
                            color: AppColors.color295788,
                            width: 30,
                            height: 50,
                          )
                        : Image.file(
                            File(addMedicineProvider.imageFile!.path),
                            width: 80,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                thickness: 0.5,
                color: AppColors.colorECECEC,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.name.tr,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Flexible(
                    child: Text(
                      addMedicineProvider.medicineName!,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: AppTxtStyles.getAppRegularFont(
                              size: 16, fontWeight: FontWeight.w700)
                          .copyWith(
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (addMedicineProvider.strength != null)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      AppStrings.strength.tr,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16, fontWeight: FontWeight.w400),
                    )),
                    Expanded(
                        child: Text(
                      "${addMedicineProvider.strength} ${addMedicineProvider.unit}",
                      textAlign: TextAlign.end,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16, fontWeight: FontWeight.w700),
                    )),
                  ],
                ),
              ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                thickness: 0.5,
                color: AppColors.colorECECEC,
              ),
            ),
            Text(
              AppStrings.scheduledFor.tr,
              style: AppTxtStyles.getAppRegularFont(
                  size: 18, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppStrings.frequency.tr,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16, fontWeight: FontWeight.w400)),
                  const Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: 10,
                      )),
                  Text(
                    addMedicineProvider.frequencySelectionStr.tr,
                    textAlign: TextAlign.left,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Visibility(
                visible: (addMedicineProvider.frequency > 0 &&
                        addMedicineProvider.frequencySelectionStr.tr !=
                            AppStrings.asNeeded.tr)
                    ? true
                    : false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                      height: (addMedicineProvider.frequency == 4)
                          ? 200.h
                          : (addMedicineProvider.frequency == 3)
                              ? 175.h
                              : (addMedicineProvider.frequency == 2)
                                  ? 120.h
                                  : 110.h,
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.colorECECEC,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              AppStrings.setTimeAndDose.tr,
                              style: AppTxtStyles.getAppRegularFont(
                                  size: 16.sp, fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                              height: (addMedicineProvider.frequency == 4)
                                  ? 130.h
                                  : (addMedicineProvider.frequency == 3)
                                      ? 110.h
                                      : (addMedicineProvider.frequency == 2)
                                          ? 60.h
                                          : 30.h,
                              width: 350.w,
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: addMedicineProvider.frequency,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DoesTime doesTime =
                                        addMedicineProvider.doesTimeList[index];
                                    return Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: Text(getTimeString(
                                                    doesTime.dateTime))),
                                            SizedBox(
                                              width: 140.w,
                                            ),
                                            Text(AppStrings.take.tr),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(doesTime.doesCount
                                                  .toString()),
                                            ),
                                            Text(AppStrings.pills.tr),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                        if (index !=
                                            addMedicineProvider.frequency - 1)
                                          const Divider(
                                            thickness: 0.1,
                                            color: AppColors.color8f8f8f,
                                          ),
                                      ],
                                    );
                                  }))
                        ],
                      )),
                )),
            Visibility(
                visible: addMedicineProvider.startDateSelectedStr == null
                    ? false
                    : true,
                child: Text(
                  AppStrings.dateRange.tr,
                  style: AppTxtStyles.getAppRegularFont(
                      size: 18, fontWeight: FontWeight.w700),
                )),
            Visibility(
              visible: addMedicineProvider.startDateSelectedStr == null
                  ? false
                  : true,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child:
                          Text.rich(TextSpan(text: '', children: <InlineSpan>[
                        TextSpan(
                          text: AppStrings.from.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: addMedicineProvider.startDateSelectedStr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 16.sp, fontWeight: FontWeight.w700),
                        ),
                      ])),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Visibility(
                      visible: addMedicineProvider.endDateSelectedStr == null
                          ? false
                          : true,
                      child: Expanded(
                          child: Text.rich(
                              TextSpan(text: '', children: <InlineSpan>[
                        TextSpan(
                          text: AppStrings.to.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: addMedicineProvider.endDateSelectedStr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 16.sp, fontWeight: FontWeight.w700),
                        ),
                      ]))),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: AppColors.colorECECEC,
            ),
            Container(
                child: Text(
              AppStrings.notificationSetup.tr,
              style: AppTxtStyles.getAppRegularFont(
                  size: 18, fontWeight: FontWeight.w700),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    AppStrings.soundType.tr,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16, fontWeight: FontWeight.w400),
                  )),
                  const Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: 10,
                      )),
                  Expanded(
                      child: Text(
                    "Ding-Dong",
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16, fontWeight: FontWeight.w700),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    AppStrings.vibration.tr,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16, fontWeight: FontWeight.w400),
                  )),
                  const Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: 10,
                      )),
                  Expanded(
                      child: Text(
                    (addMedicineProvider.vibration
                        ? AppStrings.active.tr
                        : AppStrings.inactive.tr),
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16, fontWeight: FontWeight.w700),
                  )),
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
              color: AppColors.colorECECEC,
            ),
            Visibility(
              visible: addMedicineProvider.stockPills.isNotEmpty ? true : false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          AppStrings.unitInStock.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 16, fontWeight: FontWeight.w400),
                        )),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Expanded(
                        child: Text(
                      addMedicineProvider.stockPills,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16, fontWeight: FontWeight.w700),
                    )),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: addMedicineProvider.stockPills.isNotEmpty ? true : false,
              child: const Divider(
                thickness: 0.5,
                color: AppColors.colorECECEC,
              ),
            ),
            Visibility(
              visible: addMedicineProvider.refillReminder,
              child: Text(
                AppStrings.refillReminder.tr,
                style: AppTxtStyles.getAppRegularFont(
                    size: 18, fontWeight: FontWeight.w700),
              ),
            ),
            Visibility(
              visible: addMedicineProvider.refillReminder,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      AppStrings.reminder.tr,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16, fontWeight: FontWeight.w400),
                    )),
                    const Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 10,
                        )),
                    Expanded(
                        child: Text(
                      addMedicineProvider.refillReminderNote,
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16, fontWeight: FontWeight.w700),
                    )),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: addMedicineProvider.refillReminder,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          "Reminder Time:",
                          style: AppTxtStyles.getAppRegularFont(
                              size: 16, fontWeight: FontWeight.w400),
                        )),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Expanded(
                        child: Text(
                      "11:00 am",
                      style: AppTxtStyles.getAppRegularFont(
                          size: 16, fontWeight: FontWeight.w700),
                    )),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 0.5,
              color: AppColors.colorECECEC,
            ),
          ]),
    );
  }

  Widget getDotDecoration(int index) {
    switch (index) {
      case 0:
        return SizedBox(
          height: 40.h,
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                R.assetsIconsDottActive,
                width: 8,
                height: 8,
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                R.assetsIconsDottInactive,
                width: 5,
                height: 5,
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                R.assetsIconsDottInactive,
                width: 5,
                height: 5,
              ),
            ],
          ),
        );
      case 1:
        return SizedBox(
          height: 40.h,
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                R.assetsIconsDottInactive,
                width: 5,
                height: 5,
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                R.assetsIconsDottActive,
                width: 8,
                height: 8,
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                R.assetsIconsDottInactive,
                width: 5,
                height: 5,
              ),
            ],
          ),
        );
      case 2:
        return SizedBox(
          height: 40.h,
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                R.assetsIconsDottInactive,
                width: 5,
                height: 5,
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                R.assetsIconsDottInactive,
                width: 5,
                height: 5,
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                R.assetsIconsDottActive,
                width: 8,
                height: 8,
              ),
            ],
          ),
        );
      default:
        return SizedBox(
          height: 40.h,
          width: 100.w,
        );
    }
  }

  void selectFrequencyBottomSheet(
      AddMedicineProvider addMedicineProvider, BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.colorececec,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) {
          return Container(
            height: 350.h,
            decoration: const BoxDecoration(
                color: AppColors.colorececec,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50.h,
                  child: Text(
                    AppStrings.selectFrequency.tr,
                    style: AppTxtStyles.getAppRegularFont(
                            size: 16, fontWeight: FontWeight.w400)
                        .copyWith(color: AppColors.color8f8f8f),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addMedicineProvider.frequencySelectionStr =
                        AppStrings.everyDay;
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50.h,
                        child: Text(
                          AppStrings.everyDay.tr,
                          style: AppTxtStyles.getAppRegularFont(
                            size: 18,
                            fontWeight: FontWeight.w400,
                          ).copyWith(
                            color: AppColors.color007aff,
                          ),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addMedicineProvider.frequencySelectionStr =
                        AppStrings.specificDays.tr;
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50.h,
                      child: Text(AppStrings.specificDays.tr,
                          style: AppTxtStyles.getAppRegularFont(
                            size: 18,
                            fontWeight: FontWeight.w400,
                          ).copyWith(color: AppColors.color007aff)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addMedicineProvider.frequencySelectionStr =
                        AppStrings.daysInterval.tr;
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50.h,
                      child: Text(AppStrings.daysInterval.tr,
                          style: AppTxtStyles.getAppRegularFont(
                            size: 18,
                            fontWeight: FontWeight.w400,
                          ).copyWith(
                            color: AppColors.color007aff,
                          )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addMedicineProvider.frequencySelectionStr =
                        AppStrings.asNeeded.tr;
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50.h,
                      child: Text(
                        AppStrings.asNeeded.tr,
                        style: AppTxtStyles.getAppRegularFont(
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ).copyWith(
                          color: AppColors.color007aff,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50.h,
                      child: Text(AppStrings.cancel.tr,
                          style: AppTxtStyles.getAppRegularFont(
                            size: 18,
                            fontWeight: FontWeight.w700,
                          ).copyWith(
                            color: AppColors.color007aff,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
  //
  // Future<DateTime> selectStartDateBottomSheet(
  //     AddMedicineProvider addMedicineProvider, BuildContext context) async {
  //   return (await showDialog<DateTime>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AwesomeCalendarDialog(
  //         selectionMode: SelectionMode.single,
  //         canToggleRangeSelection: true,
  //         dayTileBuilder: CustomDayTileBuilder(),
  //         confirmBtnText: Text(AppStrings.done.tr,
  //             style: AppTxtStyles.getAppRegularFont(
  //               size: 14,
  //               fontWeight: FontWeight.w700,
  //             ).copyWith(
  //               color: AppColors.colorE86606,
  //             )),
  //         cancelBtnText: Text(AppStrings.cancel.tr,
  //             style: AppTxtStyles.getAppRegularFont(
  //               size: 14,
  //               fontWeight: FontWeight.w700,
  //             ).copyWith(
  //               color: AppColors.colorE86606,
  //             )),
  //       );
  //     },
  //   ))!;
  // }

  // Future<DateTime> selectEndDateBottomSheet(
  //     AddMedicineProvider addMedicineProvider, BuildContext context) async {
  //   return (await showDialog<DateTime>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AwesomeCalendarDialog(
  //         selectionMode: SelectionMode.single,
  //         canToggleRangeSelection: true,
  //         dayTileBuilder: CustomDayTileBuilder(),
  //         confirmBtnText: Text(AppStrings.done.tr,
  //             style: AppTxtStyles.getAppRegularFont(
  //               size: 14,
  //               fontWeight: FontWeight.w700,
  //             ).copyWith(
  //               color: AppColors.colorE86606,
  //             )),
  //         cancelBtnText: Text(AppStrings.cancel.tr,
  //             style: AppTxtStyles.getAppRegularFont(
  //               size: 14,
  //               fontWeight: FontWeight.w700,
  //             ).copyWith(
  //               color: AppColors.colorE86606,
  //             )),
  //       );
  //     },
  //   ))!;
  // }

  void setTimeAndDoseBottomSheet(BuildContext context,
      AddMedicineProvider addMedicineProvider, int index, DoesTime doesTime) {
    addMedicineProvider.currentDoesTime = doesTime;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 340.h,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 4.h,
                              width: 55.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                              child: const Text(""),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: SizedBox(
                                  height: 30.h,
                                  child: Text(
                                    AppStrings.cancel.tr,
                                    style: AppTxtStyles.getAppRegularFont(
                                        size: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: SizedBox(
                                height: 100.h,
                                child: Text(
                                  AppStrings.setTimeAndDose.tr,
                                  style: AppTxtStyles.getAppRegularFont(
                                      size: 18.sp, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  addMedicineProvider.updateDoesTimeList(index);
                                  Get.back();
                                },
                                child: SizedBox(
                                  height: 100.h,
                                  child: Text(
                                    AppStrings.done.tr,
                                    style: AppTxtStyles.getAppRegularFont(
                                        size: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 0.2,
                    color: AppColors.color8f8f8f,
                  ),
                  Stack(
                    children: [
                      Center(
                          child: SizedBox(
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: timePicker(addMedicineProvider),
                        ),
                      )),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60.h,
                            ),
                            const Divider(
                              thickness: 0.3,
                              color: AppColors.color8f8f8f,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            const Divider(
                              thickness: 0.3,
                              color: AppColors.color8f8f8f,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 0.2,
                    color: AppColors.color8f8f8f,
                  ),
                  Text(
                    AppStrings.howMuchManyDidYouTakeToJustDose.tr,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16.sp, fontWeight: FontWeight.w700),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (doesTime.doesCount >= 2) {
                              setState(() {
                                doesTime.doesCount--;
                              });
                              addMedicineProvider.currentDoesTime = doesTime;
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                  color: Colors.black26,
                                  width: 1 // red as border color
                                  ),
                              color: AppColors.color295788,
                            ),
                            child: Text(
                              "-",
                              style: AppTxtStyles.getAppRegularFont(
                                      size: 16, fontWeight: FontWeight.w600)
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: 110.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              border: Border.all(
                                  color: Colors.black26,
                                  width: 1.5 // red as border color
                                  ),
                              color: Colors.white,
                            ),
                            child: Text(
                              getPillsCount(doesTime),
                              style: AppTxtStyles.getAppRegularFont(
                                  size: 15, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              doesTime.doesCount++;
                            });
                            addMedicineProvider.currentDoesTime = doesTime;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                  color: Colors.black26,
                                  width: 1 // red as border color
                                  ),
                              color: AppColors.color295788,
                            ),
                            child: Text(
                              "+",
                              style: AppTxtStyles.getAppRegularFont(
                                      size: 16, fontWeight: FontWeight.w600)
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  Widget timePicker(AddMedicineProvider addMedicineProvider) {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: AppTxtStyles.getAppRegularFont(
              size: 18, fontWeight: FontWeight.normal)
          .copyWith(color: AppColors.color8f8f8f),
      highlightedTextStyle:
          AppTxtStyles.getAppRegularFont(size: 23, fontWeight: FontWeight.w400),
      spacing: 15,
      onTimeChange: (time) {
        addMedicineProvider.currentDoesTime?.dateTime = time;
      },
    );
  }

  void refillReminderBottomSheet(
      BuildContext context, AddMedicineProvider addMedicineProvider) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 240.h,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 4.h,
                              width: 55.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                              child: const Text(""),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: SizedBox(
                                  height: 30.h,
                                  child: Text(
                                    AppStrings.cancel.tr,
                                    style: AppTxtStyles.getAppRegularFont(
                                        size: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: SizedBox(
                                  height: 30.h,
                                  child: Text(
                                    AppStrings.setTime.tr,
                                    style: AppTxtStyles.getAppRegularFont(
                                        size: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: SizedBox(
                                  height: 100.h,
                                  child: Text(
                                    AppStrings.done.tr,
                                    style: AppTxtStyles.getAppRegularFont(
                                        size: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 0.2,
                    color: AppColors.color8f8f8f,
                  ),
                  Stack(
                    children: [
                      Center(
                          child: SizedBox(
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: refillReminderTimePicker(addMedicineProvider),
                        ),
                      )),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60.h,
                            ),
                            const Divider(
                              thickness: 0.3,
                              color: AppColors.color8f8f8f,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            const Divider(
                              thickness: 0.3,
                              color: AppColors.color8f8f8f,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget refillReminderTimePicker(AddMedicineProvider addMedicineProvider) {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: AppTxtStyles.getAppRegularFont(
              size: 18, fontWeight: FontWeight.normal)
          .copyWith(color: AppColors.color8f8f8f),
      highlightedTextStyle:
          AppTxtStyles.getAppRegularFont(size: 23, fontWeight: FontWeight.w400),
      spacing: 15,
      onTimeChange: (time) {
        addMedicineProvider.refillReminderDateTime = time;
      },
    );
  }

  String getPillsCount(DoesTime doesTime) {
    return doesTime.doesCount.toString();
  }

  String getTimeString(DateTime dateTime) {
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

  Widget getNextBtn(
      BuildContext context, AddMedicineProvider addMedicineProvider) {
    return InkWell(
      onTap: () {
        if (addMedicineProvider.currentPageIndex < 3) {
          if (addMedicineProvider.currentPageIndex == 0) {
            if (addMedicineProvider.isValidForm1) {
              addMedicineProvider.currentPageIndex++;
            } else {
              showSnackBar(
                  context: context,
                  msg: AppStrings.pleaseFillTheFieldsCorrectly.tr);
            }
          } else if (addMedicineProvider.currentPageIndex == 1) {
            if (addMedicineProvider.isValidForm2) {
              addMedicineProvider.currentPageIndex++;
            } else {
              showSnackBar(
                  context: context,
                  msg: AppStrings.pleaseFillTheFieldsCorrectly.tr);
            }
          } else if (addMedicineProvider.currentPageIndex == 2) {
            if (addMedicineProvider.isValidForm3) {
              addMedicineProvider.currentPageIndex++;
            } else {
              showSnackBar(
                  context: context,
                  msg: AppStrings.pleaseFillTheFieldsCorrectly.tr);
            }
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: (addMedicineProvider.currentPageIndex == 0 &&
                    addMedicineProvider.isValidForm1)
                ? AppColors.color295788
                : (addMedicineProvider.currentPageIndex == 1 &&
                        addMedicineProvider.isValidForm2)
                    ? AppColors.color295788
                    : (addMedicineProvider.currentPageIndex == 2 &&
                            addMedicineProvider.isValidForm3)
                        ? AppColors.color295788
                        : Colors.black26,
            style: BorderStyle.solid,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 40.h,
        width: 80.w,
        child: Row(
          children: [
            SizedBox(
              width: (addMedicineProvider.currentPageIndex == 2 &&
                      Get.locale == const Locale("ar"))
                  ? 30
                  : 10,
            ),
            Text(
              addMedicineProvider.currentPageIndex == 2
                  ? AppStrings.done.tr
                  : AppStrings.next.tr,
              style: AppTxtStyles.getAppRegularFont(
                      size: 14.sp, fontWeight: FontWeight.w700)
                  .copyWith(
                color: (addMedicineProvider.currentPageIndex == 0 &&
                        addMedicineProvider.isValidForm1)
                    ? AppColors.color295788
                    : (addMedicineProvider.currentPageIndex == 1 &&
                            addMedicineProvider.isValidForm2)
                        ? AppColors.color295788
                        : (addMedicineProvider.currentPageIndex == 2 &&
                                addMedicineProvider.isValidForm3)
                            ? AppColors.color295788
                            : Colors.black26,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: (addMedicineProvider.currentPageIndex == 0 &&
                      addMedicineProvider.isValidForm1)
                  ? AppColors.color295788
                  : (addMedicineProvider.currentPageIndex == 1 &&
                          addMedicineProvider.isValidForm2)
                      ? AppColors.color295788
                      : (addMedicineProvider.currentPageIndex == 2 &&
                              addMedicineProvider.isValidForm3)
                          ? AppColors.color295788
                          : Colors.black26,
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget getBackBtn(AddMedicineProvider addMedicineProvider) {
    return InkWell(
      onTap: () {
        if (addMedicineProvider.currentPageIndex >= 1) {
          addMedicineProvider.currentPageIndex--;
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.color295788,
            style: BorderStyle.solid,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 40.h,
        width: 80.w,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.arrow_back,
              color: AppColors.color295788,
            ),
            Text(
              AppStrings.back.tr,
              style: AppTxtStyles.getAppRegularFont(
                      size: 14.sp, fontWeight: FontWeight.w700)
                  .copyWith(
                color: AppColors.color295788,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
