import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/models/contants.dart';
import '../../../../common/widgets/app_shadow.dart';
import '../../../../common/widgets/text_widgets.dart';
import '../../../../global.dart';

class AppOnboardingPage extends StatelessWidget {
  final PageController controller;
  final String imagePath;
  final String title;
  final String subTitle;
  final int index;
  final BuildContext context;

  const AppOnboardingPage(
      {Key? key,
      required this.controller,
      required this.imagePath,
      required this.title,
      required this.subTitle,
      required this.index,
      required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.fitWidth,
        ),
        Container(
            margin: EdgeInsets.only(top: 15.h),
            child: text20Normal(text: title)),
        Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Text16Normal(text: subTitle),
        ),
        _nextButton(index, controller, context)
      ],
    );
  }
}


Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (index < 3) {
        controller.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
      } else {
        Global.storageService
            .setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);

        Navigator.pushNamed(
          context,
          "/sign_in",
        );
      }
    },
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
      decoration: appBoxShadow(),
      child: Center(
          child: Text16Normal(
              text: index < 3 ? "Tiếp theo" : "Bắt đầu", color: Colors.white)),
    ),
  );
}
