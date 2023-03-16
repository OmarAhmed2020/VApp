import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:textfield_search/textfield_search.dart';
import '../../localization/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_txt_styles.dart';
import '../widgets/app_bar_widget.dart';

class AddDose extends StatelessWidget {
  const AddDose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const label = "Search";
    const dummyList = ['Vitamin A', 'Vitamin B'];
    TextEditingController myController = TextEditingController();
    var doseList=[
      {
        'name':' Vitamin A',
        'stock':'Stock',
        'pillsLeft':'200',
      }
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBarWidgetWithTitle(AppStrings.addDose.tr, (){}),
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
              ],
            ),

            const Divider(
              thickness: 1,
              color: AppColors.colorECECEC,
            ),

            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context,index){
                    return
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 110.h,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: AppColors.colorECECEC,
                                width: 1 // red as border color
                            ),),

                          child:Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Expanded(
                                  child: Row(
                                    children: [Text("Vitamin A",
                                      style: AppTxtStyles.getAppRegularFont(
                                          size: 16.sp, fontWeight: FontWeight.w700),)],
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                color: AppColors.colorECECEC,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text(AppStrings.stock.tr,
                                        style: AppTxtStyles.getAppRegularFont(
                                            size: 14.sp, fontWeight: FontWeight.w400),)),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 105.w,
                                        height: 35.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.colorececec,
                                          borderRadius: BorderRadius.circular(12.0),

                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("200",
                                                style: AppTxtStyles.getAppRegularFont(
                                                  size: 14.sp, fontWeight: FontWeight.w400,)
                                            ),
                                            Text(AppStrings.pillsLeft.tr,
                                                style: AppTxtStyles.getAppRegularFont(
                                                  size: 14.sp, fontWeight: FontWeight.w400,)
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
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