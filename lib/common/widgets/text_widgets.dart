import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/utils/app_colors.dart';

Widget text24Normal(
    {String text = "",
    Color color = AppColors.primaryText,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: 24.sp, fontWeight: fontWeight),
  );
}
Widget text20Normal(
    {String text = "",
      Color color = AppColors.primaryText,
      FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: 20.sp, fontWeight: fontWeight),
  );
}
class Text16Normal extends StatelessWidget {
  final String? text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const Text16Normal(
      {Key? key,
      this.text = "",
      this.color = AppColors.primarySecondaryElementText,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(color: color, fontSize: 16.sp, fontWeight: fontWeight),
    );
  }
}

class Text14Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;


  const Text14Normal(
      {Key? key,
      this.text = "",
      this.color = AppColors.primaryThirdElementText,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color, fontSize: 14.sp, fontWeight: fontWeight),
    );
  }
}

class Text11Normal extends StatelessWidget {
  final String? text;
  final Color color;
  final FontWeight fontWeight;

  const Text11Normal(
      {Key? key, this.text = "", this.color = AppColors.primaryElementText, this.fontWeight = FontWeight.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: TextAlign.start,
      style: TextStyle(
          color: color, fontSize: 11.sp, fontWeight: FontWeight.normal),
    );
  }
}

class Text10Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;

  const Text10Normal(
      {Key? key,
      this.text = "",
      this.color = AppColors.primaryThirdElementText,
      this.weight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
          color: color, fontSize: 10.sp, fontWeight: FontWeight.normal),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
class Text13Normal extends StatelessWidget {
  final String? text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;

  const Text13Normal(
      {Key? key,
        this.text = "",
        this.color = AppColors.primaryText,
        this.fontWeight = FontWeight.bold,
        this.textAlign = TextAlign.start,
        this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text!,
      textAlign: textAlign,
      style: TextStyle(color: color, fontSize: 13.sp, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

Widget textUnderline({String text = "Your text"}) {
  return GestureDetector(
    onTap: () {},
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14.sp,
        color: AppColors.primaryText,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.primaryText,
      ),
    ),
  );
}

class FadeText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;
  final double fontSize;

  const FadeText(
      {Key? key,
      this.text = "",
      this.color = AppColors.primaryThirdElementText,
      this.weight = FontWeight.normal,
      this.fontSize = 13})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: false,
      maxLines: 1,
      overflow: TextOverflow.fade,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: color, fontSize: fontSize.sp, fontWeight: FontWeight.bold),
    );
  }
}
