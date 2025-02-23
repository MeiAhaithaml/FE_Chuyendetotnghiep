import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/widgets/text_widgets.dart';

import '../utils/app_colors.dart';
import 'app_shadow.dart';

class AppButton extends StatelessWidget {
  final double width;
  final double height;
  final String buttonName;

  final bool isLogin;
  final BuildContext? context;
  final void Function()? func;

  const AppButton(
      {super.key,
      this.width = 290,
      this.height = 50,
      this.buttonName = "",
      this.isLogin = true,
      this.context,
      this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: appBoxShadow(
            color: isLogin ? AppColors.primaryElement : Colors.white,
            boxBorder: Border.all(color: AppColors.primaryFourthElementText)),
        child: Center(
            child: Text16Normal(
                text: buttonName,
                color: isLogin
                    ? AppColors.primaryBackground
                    : AppColors.primaryText)),
      ),
    );
  }
}
