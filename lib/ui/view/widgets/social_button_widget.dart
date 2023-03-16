import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voithy/ui/theme/app_colors.dart';

import '../../../r.dart';

class CustomWidgets {
  static Widget socialButtonRect(title, color,colortxt, image, {Function? onTap}) {

    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
            color: color, borderRadius: const BorderRadius.all(Radius.circular(10),
        ),border: Border.all(color:AppColors.borderSocialButtons )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              image,
              height: 40.h,
              width: 40.w,

            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(title,
                  style:  TextStyle(
                      color:colortxt ,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}

