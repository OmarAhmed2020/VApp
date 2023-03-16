import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:intl/intl.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import 'package:voithy/ui/theme/app_txt_styles.dart';
import 'package:voithy/ui/view/widgets/app_bar_widget.dart';
import '../../../model/medicine_model.dart';
import '../../../model/scheduled_medicine_model.dart';
import '../../../r.dart';
import '../../localization/app_strings.dart';
import '../more/more_screen.dart';
import '../widgets/bottomSheet/add_medicine_buttom_sheet.dart';
import '../widgets/medicine_popup.dart';

enum Mode { week, day, month }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  Mode modeSelected = Mode.week;
  String modeSelectedStr = AppStrings.week.tr;
  List<String> modeList = [
    AppStrings.week.tr,
    AppStrings.day.tr,
    AppStrings.month.tr
  ];
  late DateTime today;
  late DateTime selectedDate;
  late String month;
  List<ScheduledMedicine> scheduledMedicine = [];

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    selectedDate = today;
    month = DateFormat("MMMM").format(today);
    scheduledMedicine = getTempScheduledMedicinesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "${AppStrings.today.tr}${today.day}",
                        style: AppTxtStyles.getAppRegularFont(
                            size: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        month,
                        style: AppTxtStyles.getAppRegularFont(
                            size: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: AppColors.color295788,
                            width: 1 // red as border color
                            ),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          items: modeList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: AppTxtStyles.getAppRegularFont(
                                              size: 14,
                                              fontWeight: FontWeight.w700)
                                          .copyWith(
                                              color: AppColors.color295788),
                                    ),
                                  ))
                              .toList(),
                          value: modeSelectedStr,
                          onChanged: (value) {
                            String mode = value as String;
                            if (mode == AppStrings.week.tr) {
                              setState(() {
                                modeSelected = Mode.week;
                                modeSelectedStr = AppStrings.week.tr;
                              });
                            } else if (mode == AppStrings.day.tr) {
                              setState(() {
                                modeSelected = Mode.day;
                                modeSelectedStr = AppStrings.day.tr;
                              });
                            } else if (mode == AppStrings.month.tr) {
                              setState(() {
                                modeSelected = Mode.month;
                                modeSelectedStr = AppStrings.month.tr;
                              });
                            }
                          },
                          buttonHeight: 30,
                          buttonWidth: 80,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              getCalendarWidget(),
              const SizedBox(
                height: 30,
              ),
              getDateScheduledMedicinesWidget(
                  date: selectedDate,
                  scheduledMedicinesList: scheduledMedicine),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: AppColors.colorE86606,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          switch (index) {
            case 2:
              showAddMedicineBottomSheet(context);
              break;
            case 4:
              Get.to(MoreScreen());
              break;
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              R.assetsImagesIcHome,
              color: currentIndex == 0 ? AppColors.colorE86606 : Colors.black,
            ),
            label: AppStrings.home.tr,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              R.assetsImagesIcReport,
              color: currentIndex == 1 ? AppColors.colorE86606 : Colors.black,
            ),
            label: AppStrings.report.tr,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              R.assetsImagesIcAdd,
              color: currentIndex == 2 ? AppColors.colorE86606 : Colors.black,
            ),
            label: AppStrings.add.tr,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              R.assetsImagesIcMyCircle,
              color: currentIndex == 3 ? AppColors.colorE86606 : Colors.black,
            ),
            label: AppStrings.myCircle.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.more_horiz,
              color: currentIndex == 4 ? AppColors.colorE86606 : Colors.black,
            ),
            label: AppStrings.more.tr,
          ),
        ],
      ),
    );
  }

  Widget getCalendarWidget() {
    switch (modeSelected) {
      case Mode.week:
        return HorizontalCalendar(
          date: selectedDate,
          showMonth: false,
          initialDate: DateTime(2022),
          textColor: Colors.black,
          backgroundColor: Colors.white,
          selectedColor: AppColors.colorE86606,
          onDateSelected: (date) {
            setState(() {
              selectedDate = DateTime.parse(date);
            });
          },
        );
      case Mode.day:
        return Container();
      case Mode.month:
        return AwesomeCalendar(
          selectedSingleDate: selectedDate,
          dayTileBuilder: CustomDayTileBuilder(onTap: (dateTime){
            setState(() {
              selectedDate = dateTime;
            });
          }),
        );
    }
  }

  List<ScheduledMedicine> getTempScheduledMedicinesList() {
    List<ScheduledMedicine> scheduledMedicineList = [];
    for (int i = 1; i < 4; i++) {
      DateTime? _dateTime = DateTime.now().add(Duration(days: i));
      ScheduledMedicine scheduledMedicine = ScheduledMedicine();
      scheduledMedicine.dateTime = _dateTime;
      List<Medicine> medicinesList = [];
      Medicine medicine = Medicine(
          medicineName: "Thyrox",
          action: MedicineAction.skipped,
          amount: i,
          unit: AppStrings.pills.tr);
      Medicine medicine1 = Medicine(
          medicineName: "Plavix",
          action: MedicineAction.reScheduled,
          amount: i,
          unit: AppStrings.ml.tr);
      Medicine medicine2 = Medicine(
          medicineName: "Asprin",
          action: MedicineAction.taken,
          amount: i,
          unit: AppStrings.ml.tr);
      medicinesList.add(medicine);
      medicinesList.add(medicine1);
      medicinesList.add(medicine2);
      scheduledMedicine.medicineList = medicinesList;
      scheduledMedicineList.add(scheduledMedicine);
    }
    return scheduledMedicineList;
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

  Widget getDateScheduledMedicinesWidget(
      {required DateTime date,
      required List<ScheduledMedicine> scheduledMedicinesList}) {
    ScheduledMedicine? scheduledMedicineItem;
    DateTime dateTime = DateTime(date.year, date.month, date.day);
    for (int i = 0; i < scheduledMedicinesList.length; i++) {
      scheduledMedicineItem = scheduledMedicinesList[i];
      DateTime itemDate = DateTime(
          scheduledMedicineItem.dateTime!.year,
          scheduledMedicineItem.dateTime!.month,
          scheduledMedicineItem.dateTime!.day);
      if (dateTime == itemDate) {
        break;
      }
    }
    DateTime itemDate = DateTime(
        scheduledMedicineItem!.dateTime!.year,
        scheduledMedicineItem.dateTime!.month,
        scheduledMedicineItem.dateTime!.day);
    if (dateTime == itemDate) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
                color: AppColors.colorECECEC, width: 1 // red as border color
                ),
          ),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 100),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: getTempScheduledMedicinesList().length,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Expanded(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        R.assetsIconsAddMedicine,
                                        height: 22.h,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        AppStrings.scheduledFor.tr,
                                        style: AppTxtStyles.getAppRegularFont(
                                            size: 16.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '${getCurrentDateTimeSrt(DateTime.now())}',
                                        style: AppTxtStyles.getAppRegularFont(
                                            size: 16.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                color: AppColors.colorECECEC,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: InkWell(
                                  onTap: (){
                                    addMedicinePopup(context);
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            '${getTempScheduledMedicinesList()[0].medicineList![index].medicineName}',
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
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '${getTempScheduledMedicinesList()[index].medicineList![index].amount}',
                                                  style: AppTxtStyles
                                                      .getAppRegularFont(
                                                    size: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                  '${getTempScheduledMedicinesList()[index].medicineList![index].unit}',
                                                  style: AppTxtStyles
                                                      .getAppRegularFont(
                                                    size: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 25.w,
                                          height: 25.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            children: [
                                              if (getTempScheduledMedicinesList()[
                                                          index]
                                                      .medicineList![index]
                                                      .action ==
                                                  MedicineAction.skipped) ...[
                                                SvgPicture.asset(
                                                    R.assetsIconsSkipped),
                                              ] else if (getTempScheduledMedicinesList()[
                                                          index]
                                                      .medicineList![index]
                                                      .action ==
                                                  MedicineAction.reScheduled) ...[
                                                SvgPicture.asset(
                                                    R.assetsIconsReScheduled),
                                              ] else if (getTempScheduledMedicinesList()[
                                                          index]
                                                      .medicineList![index]
                                                      .action ==
                                                  MedicineAction.taken) ...[
                                                SvgPicture.asset(
                                                    R.assetsIconsTaken),
                                              ] else ...[
                                                SvgPicture.asset(
                                                    R.assetsIconsEmpty),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Center(
              child: SvgPicture.asset(
            R.assetsImagesHomeImg1,
          )),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppStrings.noMed.tr,
            style: AppTxtStyles.getAppRegularFont(
                size: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            AppStrings.startYourJourney.tr,
            style: AppTxtStyles.getAppRegularFont(
                size: 16, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      );
    }
  }
}

class CustomDayTileBuilder extends DayTileBuilder {
  CustomDayTileBuilder({this.onTap});
  Function(DateTime datetime)? onTap;
  @override
  Widget build(BuildContext context, DateTime date,
      void Function(DateTime datetime)? onTap) {
    return DefaultDayTile(
      date: date,
      onTap: this.onTap,
      selectedDayColor: AppColors.colorE86606,
      currentDayBorderColor: AppColors.colorE86606,
    );
  }
}
