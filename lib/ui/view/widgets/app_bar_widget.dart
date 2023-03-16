import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:voithy/ui/theme/app_txt_styles.dart';
import '../../../r.dart';

PreferredSizeWidget getAppBarWidget() {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
      onPressed: () => Get.back(),
    ),
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SvgPicture.asset(R.assetsIconsLogo),
        ),
        const SizedBox(
          width: 50,
        )
      ],
    ),
  );
}

PreferredSizeWidget getAppBarWidgetWithNotificationIcon() {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
      onPressed: () => Get.back(),
    ),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.notifications_none,
          color: Colors.black,
        ),
        onPressed: () {
          // do something
        },
      )
    ],
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SvgPicture.asset(R.assetsIconsLogo),
        ),
        const SizedBox(
          width: 50,
        )
      ],
    ),
  );
}

PreferredSizeWidget getAppBarWidgetWithTitle(String title, VoidCallback onClosePressed) {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.close, color: Colors.black),
      onPressed: onClosePressed,
    ),
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Text(
            title,
            style: AppTxtStyles.getAppRegularFont(
                    size: 15.sp, fontWeight: FontWeight.normal)
                .copyWith(color: Colors.black),
          ),
        )),
      ],
    ),
  );
}
